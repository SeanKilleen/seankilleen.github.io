---
title: "Avoiding Primitive Obsession in Configuration: My Approach"
date: 2016-12-27 22:43:00.000000000 -05:00
excerpt: "A good blog post got my wheels turning."
references:
 - title: "Autofac And Primitive Obsession: How I Learned To Love The Injection Of Configuration Parameters" 
   url: http://arialdomartini.github.io/primitive-obsession.html
   parenttitle: "Arialdo Martini"
   parenturl: http://arialdomartini.github.io/
 - title: "SeanKilleen/SimpleConfigInjectionExample on Github" 
   url: https://github.com/SeanKilleen/SimpleConfigInjectionExample
   parenttitle: "SeanKilleen's Github Page"
   parenturl: https://github.com/SeanKilleen
 - title: "nlkl/Optional on Github" 
   url: https://github.com/nlkl/Optional
   parenttitle: "nlkl's Github Page"
   parenturl: https://github.com/nlkl
 - title: "Autofac" 
   url: https://autofac.org/
comments: true
---
I woke up this morning and saw [a great blog post by Arialdo Martini] that inspired me to blog a little bit (thanks, Arialdo!) 

 In the post, he describes the problems of using primitive variables in your classes, and the pitfalls of using a service locator pattern to resolve those issues. It's a good read; I recommend checking it out. The conclusion he came to (and I'm greatly oversimplifying here) is that configuration settings work better as value objects, and shows some tricks for how to achieve this in a more painless way.

 I definitely agree that a value object is better than a primitive when it makes sense. However, there are times when a collection of primitives does make the most sense. 

 So, I thought I'd share some current thoughts on how I prefer to inject configuration into my classes.

## Setting up the Problem

Let's say I have a class -- let's call it `MyEmailSender` -- that takes in a fromAddress and which SMTP server to use:

 ```csharp
public class MyEmailSender
{
  private readonly string _fromAddress;
  private readonly string _smtpServer;
  
  public MyEmailSender(string fromAddress, string smtpServer)
  {
    _fromAddress = fromAddress;
    _smtpServer = smtpServer;
  }
   public void SendEmail(string emailText)
  {
    // make use of fromAddress and smtpServer here.
  }
}
 // And to call the code:
var theFromAddress = ConfigurationManager.AppSettings["emailFromAddress"];
var theSmtpServer = ConfigurationManager.AppSettings["smtpServer"];
 var sender = new MyEmailSender(theFromAddress, theSmtpServer);
sender.SendEmail("Hello world");
```

 This becomes cumbersome when:

 * **The number of configuration properties grows**. One setting might be fine, but 5 configuration settings is much more cumbersome.
 * (Side note: one could argue that if you need 5 different configuration parameters, your class is doing too much and should be broken down anyway, but roll with me on this.)
* **You're trying to keep similar configuration uniform**. Using different configuration properties in different ways can cause confusion.
* **You have to hit AppSettings to create this object**. That's pretty annoying, and makes your code dependent on something you can't test.
* **You try to use an IoC container to inject these primitives.** This is what Arialdo's post helps a great deal with. IoC containers play much better when you're not injecting many small primitives.
* **You attempt to account for real world scenarios.** What happens when a config is missing or you need to supply a default or an override of some kind? How can you be sure the app works?

## My Preferred Solution to this Problem
 
When faced with a number of primitive configurations, my preferred steps to refactor our way out of it are:

### Extract the Configuration to an Interface / Immutable POCO
 
**NOTE:** This would be one interface per type of configuration that you need. Don't be afraid to inject multiple small interfaces into your class rather than one giant configuration. Interfaces may eventually be re-used, and it's nice to keep contracts small.

 So, we'd create an interface & immutable POCO like:

 ```csharp
public interface IEMailSettings
{
  string FromAddress { get; }
  string SmtpServer { get; }
}
 public class EmailSettings : IEMailSettings
{
  public string FromAddress { get; }
  public string SmtpServer { get; }
   public EmailSettings (string fromAddress, string smtpServer)
  {
    FromAddress = fromAddress;
    SmtpServer = smtpServer;
  }
}
```

 And we refactor our `MyEmailSender` class to:

 ```csharp
public class MyEmailSender
{
  private readonly IEMailSettings _emailSettings;
  
  public MyEmailSender(IEMailSettings emailSettings)
  {
    _emailSettings = emailSettings;
  }
   public void SendEmail(string emailText)
  {
    // make use of _emailSettings.FromAddress and _emailSettings.SmtpServer here.
  }
}
 // and the calling code:
var theFromAddress = ConfigurationManager.AppSettings["emailFromAddress"];
var theSmtpServer = ConfigurationManager.AppSettings["smtpServer"];
 // creating the settings object first now
var settings = new EmailSettings(theFromAddress, theSmtpServer);
var sender = new MyEmailSender(settings);
sender.SendEmail("Hello world");
```

### Wire up Dependencies Using an IoC Container

Next up -- I don't like having to create the `EmailSettings` object or the `MyEmailSender` manually, passing in all of the dependencies.

 So, we'll use an IoC container (in this case [Autofac], but that's just for the sake of example) and wire up the dependency to get passed in.

 Now our calling code will look like:

 ```csharp
var containerBuilder = new ContainerBuilder();
containerBuilder.Register(c => {
      var theFromAddress = ConfigurationManager.AppSettings["emailFromAddress"];
      var theSmtpServer = ConfigurationManager.AppSettings["smtpServer"];
      return new EmailSettings(theFromAddress, theSmtpServer);
      })
      .As<IEmailSettings>();
containerBuilder.RegisterType<MyEmailSender>();
 var container = containerBuilder.Build();
 // Now, use the container to create the class
var sender = container.Resolve<MyEmailSender>();
sender.SendEmail("Hello world");
```

No hard-wired dependencies right in the class -- I'm feeling better already.

### Extract a class for Obtaining the settings

But pulling from the config settings right in the registration for the container seems dicey at best. What if something blows up? What if I want to test this? What if I want more flexibility?

 Sounds like obtaining the settings is its own responsibility. So we create a class:

 ```csharp
public class EmailSettingsObtainer
{
  public EmailSettings GetSettings()
  {
      var theFromAddress = ConfigurationManager.AppSettings["emailFromAddress"];
      var theSmtpServer = ConfigurationManager.AppSettings["smtpServer"];
      return new EmailSettings(theFromAddress, theSmtpServer);
  }
}
```

 and we update the registration:

 ```csharp
containerBuilder.Register(c => new EmailSettingsObtainer().GetSettings())
      .As<IEmailSettings>();
```

### For AppSettings, extract a small interface / wrapper

But we're still calling ConfigurationManager directly from within our class. Not sure I like that -- what if I want to test what happens when a config value is incorrect?

So we'll create an interface and a tiny wrapper for the app settings:

 ```csharp
public interface IAppSettings
{
  string GetValue(string settingName);
}
 public class AppSettingsWrapper : IAppSettings
{
  public string GetValue(string settingName)
  {
    return ConfigurationManager.AppSettings[settingName];
  }
}
```

And we'll use it in our `EmailSettingsObtainer`:

 ```csharp
public class EmailSettingsObtainer
{
  private readonly IAppSettings _appSettings;
   public EmailSettingsObtainer(IAppSettings appSettings)
  {
    _appSettings = appSettings;
  }
   public EmailSettings GetSettings()
  {
      var theFromAddress = _appSettings.GetValue("emailFromAddress");
      var theSmtpServer = _appSettings.GetValue("smtpServer"); 
      return new EmailSettings(theFromAddress, theSmtpServer);
  }
}
```

 This allows us to write tests that can make the app settings return whatever they want, quickly and easily.

 We can't forget to update the container registration:

 ```csharp
containerBuilder.Register(c => new EmailSettingsObtainer(new AppSettingsWrapper()).GetSettings())
      .As<IEmailSettings>();
```

### Write some tests!

Bonus points if we'd been doing it all along the way. :) Some common scenarios I like to cover are:

 * What happens if `ConfigurationManager` throws an error?
* What happens if a setting is empty?
* What happens if a setting has a garbage value?
* Do you want something to have a default value? 
* Do you have tests where a setting should be different depending on the source setting?
* Are you converting values from strings to their expected types correctly?

 We won't cover writing the tests here due to the length, but I'll add some to the sample repository (see below).

### Extract Helper Methods for common types of extraction

As your code is covered by tests, extracting out some pieces to do common types of work will be trivial.

 For example, I find that you commonly end up with the concept of retrieving a value or a default, e.g.:

 ```csharp
// Just an example; we didn't write this method earlier in the code
int configItem = GetValueOrDefault<int>(_appSettings.GetValue("aNumberSetting"), defaultValue: 47);
```

 This will start to yield a greater degree of flexibility in how you ingest and deal with configuration values. 

### ...and Beyond!

* With this set up, you can still introduce value objects in the place of primitives where they make sense.
* You could also set up an easy configuration check by using your IoC container to instantiate a number of settings objects upon startup and intelligently surfacing any errors with configuration.
* Optional values: You could use these interfaces to communicate optional values (there's a great library called [Optional] that can help with this)
 * Including values that may be optional for one type of configuration but required or defaulted for another.
* What other possibilities do you see? Sound off in the comments!

## Benefits of This Approach

* **Greater flexibility**: Your interfaces can express whatever settings they need to do the job.
* **Better error handling / logging**: You can many opportunities to create cleaner, more expressive errors and log more intelligent warnings when a configuration value isn't found.
* **Centralized Config handling**: Your code can depend on configuration that it needs and know that it will be in the right format, without having all sorts of checks and conversions strewn throughout the code.
* **Appropriately-sized contracts**: You can separate different types of configuration into the groupings that matter the most, and deliver strongly typed results.
* **Testable**: Want to be sure about how your settings will work? You can prove every bit of it with unit tests.

## Drawbacks of This Approach

To be fair, there are some drawbacks that I can think of off-hand:

 * **Lots more classes**: Depending on how many configuration settings you have and all the different places they're used, this may lead to a number of new, albeit smaller, classes and interfaces, which may seem cumbersome to navigate.
* **More work when configs are still churning:** If your project is in the early stages and the configurations are evolving rapidly, you may not want to take this approach yet. When the solution has settled down a bit, you can apply the refactoring steps in this article to introduce more robust configuration handling.

 To me, the trade-offs are worth it. But I might be missing some (drop me a line in the comments if you think of a drawback that I'm not faily considering here).

## A Working Source Code Example

What's better to demonstrate an example than some running code, right? 

 I lay out some of these concepts in [a sample repository on GitHub]. Feel free to check it out and run it on your own!

## Thoughts?

I'd love to hear feedback on what you think. Is this approach a reasonable way of injecting configuration? Sound off in the comments!

[a great blog post by Arialdo Martini]: http://arialdomartini.github.io/primitive-obsession.html
[a sample repository on GitHub]: https://github.com/SeanKilleen/SimpleConfigInjectionExample
[Autofac]: https://autofac.org/
[Optional]: https://github.com/nlkl/Optional

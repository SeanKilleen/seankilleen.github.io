---
title: "A SpecFlow scenario: logging users in"
comments: true
tags:
  - specflow
  - testing
  - aat
  - csharp
date: 2020-12-29 08:51 -0500
---
The SpecFlow mailing list had a fun question and I decided to hop in and break down the answer in my opinion. I'm replicating the question & answer below in case it could be beneficial for others here.

## Question

> Good day, as a beginner of Specflow I am struggling with a script that does the following:
> I need help please
> 
> Open browser
> Login with Username and Password
> Click on the Login button
> Home landing page shows
> Logout
> 
> My script includes: Specflow, EPPlus(reading data from an EXcel speadsheet..looping through the rows with a For loop(Url, Username, Password).
> 
> I am attaching my script which is working without using Specflow.

## My Response

I hadn't seen any responses to this so thought I'd put a few thoughts down.

It's unclear to me if you are still seeking to use the Excel file in your process or not, so I'll try to speak to both scenarios. This is my thought process, which may be lacking some of your context, so apologies if I make assumptions.

### Questioning the Premise

I would first question: is this necessary? Is the goal to ensure that every single user in the list can login? Or, is the goal to ensure that the login functionality works as expected? If it's the latter, I would avoid a large list of usernames and passwords and instead keep the scenario small.

### Adjusting the Language of our Approach
The next step, I think, is to change the approach in terms of language. What is actually being described in terms of functionality? I suggest it would be something like the below in your SpecFlow feature file:

```feature
    # Modify to suit your needs
    Feature: Logins

        As a user
        I want to be able to login
        So that I can see my customized profile information 

    Scenario Outline: Logging in a registered user
        Given I am on the home page
        When I enter the username <username>
        And I enter the password <password>
        And I click login
        Then I should be authenticated

# These would be copied from your Excel file into the scenario file (see my suggestion later for then switching to Excel)
    Examples:
    | username | password |
    | user1 | password1 |
    | user2 | password2 |
```

There are various different takes on this format; my example above is just a draft suggestion.

### Pseudo-Setup
In terms of executing, we therefore have something like:

```
(Implied setup)
    Initialize a Chrome Driver
    Know the URL to Hit

Given I am on the home page
    Navigate to home page

When I enter the username <username>
    Enter the provided username in the username field

And I enter the password <password>
    Enter the provided password in the password field

And I click login
    Click the login button

Then I should be authenticated
    Check something (to see if a profile icon exists maybe?)

(Implied scenario tear-down)
    Logout

(Implied test run tear-down)
    Quit Chrome
```

### Getting Started

So, if we were to create the Steps file for our example feature file above, it might look like the below. Note that this is not something I've thoroughly tested, but rather is something to get you started.

This is also available in a gist now at <https://gist.github.com/SeanKilleen/16552bbd65bc53f21695950cedc5a296>

```csharp
    [Binding]
    public sealed class UserLoginSteps : IDisposable
    {
        private readonly IWebDriver _driver;
        private const string HOME_PAGE_URL = "https://seankilleen.com";
        private readonly Uri _homePageUri;

        private readonly ScenarioContext _scenarioContext;

        public UserLoginSteps(ScenarioContext scenarioContext)
        {
            _scenarioContext = scenarioContext;
            _homePageUri = new Uri(HOME_PAGE_URL);
            _driver = new ChromeDriver(); // TODO: Add specific driver location if not in bin folder.
        }

        [Given(@"I am on the home page")]
        public void GivenIAmOnTheHomePage()
        {
            _driver.Navigate().GoToUrl(_homePageUri);
        }

        [When(@"I enter the username (.*)")]
        public void WhenIEnterTheUsernameUser(string username)
        {
            UsernameField().SendKeys(username);
        }

        [When(@"I enter the password (.*)")]
        public void WhenIEnterThePasswordPassword(string password)
        {
            PasswordField().SendKeys(password);
        }

        [When(@"I click login")]
        public void WhenIClickLogin()
        {
            LoginButton().Click();
        }

        [Then(@"I should be authenticated")]
        public void ThenIShouldBeAuthenticated()
        {
            var manageProfileImage = ManageProfileImage();

            Assert.That(manageProfileImage, Is.Not.Null); // TODO: Replace with your own test
        }

        [AfterScenario]
        public void AfterScenario()
        {
            LogoutOfSite();
        }

        private void LogoutOfSite()
        {
            MoveOverManageProfileImage();
            ManageProfileImage().Click();
            ProfileLogoutButton().Click();
        }

        private IWebElement ProfileLogoutButton()
        {
            return _driver.FindElement(By.XPath("/html/body/div/main/nav/div/div[2]/ul/li[4]/div/a[3]"));
        }

        private void MoveOverManageProfileImage()
        {
            var clickNavbarProfileImage = new Actions(_driver);
            clickNavbarProfileImage.MoveToElement(ManageProfileImage());
            clickNavbarProfileImage.Build().Perform();
        }

        public void Dispose()
        {
            _driver?.Dispose();
        }

        private IWebElement ManageProfileImage()
        {
            return _driver.FindElement(By.XPath("//*[@id='navbarDropdownProfile']/img"));
        }

        private IWebElement LoginButton()
        {
            return _driver.FindElement(By.CssSelector("#account > div:nth-child(7) > div > button"));
        }

        private IWebElement PasswordField()
        {
            return _driver.FindElement(By.Id("Input_Password"));
        }

        private IWebElement UsernameField()
        {
            return _driver.FindElement(By.Id("Input_Email"));
        }
    }
```

If you are looking to keep the Excel file still for data input, SpecFlow+ Excel would likely be the best choice to combine with the approach above, to allow you to continue using Excel files for the data: <https://docs.specflow.org/projects/specflow-excel/en/latest/>
---
title: "How to Forward to a Long Conference Number Using Twilio"

date: 2019-01-08 11:30:00:00.000000000 -05:00

comments: true
---

I have a client where we use Zoom meetings which require dialing and then extra digits. We use these meetings all the time.

The client's conference phones allow for pauses to be saved in the address book, but not enough space to enter all the numbers for the conference call.

I really want to have a speed dial button we can use to save the time entering and remembering these numbers.

Not a problem! We have a solution for that.

## The Solution: Enter Twilio & TwiML bins

[Twilio](https://www.twilio.com), a voice & SMS platform, has great -- and cost-effective -- support for a solution to this sort of solution.

In this article, we'll walk step by step through how to set up forwarding for a conference phone with Twilio.

## The Overview: How it works

It's not free, but it doesn't cost a ton either.

* We pay $1.00/year for a Twilio phone number, (this is what we save in the conference phone)
* We associate that phone number with [TwiML (Twilio Markup language)](https://www.twilio.com/docs/voice/twiml) which executes the steps we expect.
* We pay a tiny monthly fee based on the # of minutes we use that line (small since we use it for standups)

## How to set up a TwiML bin for conference line forwarding

We'll walk through the process, step-by-step, below.

You can join Twilio with a free account via <https://www.twilio.com/try-twilio> but you may want to sign up for a paid account, add payment information, etc.

### Buying a Twilio Number

* From the [Twilio console](https://www.twilio.com/console), you can select `All Products & Services` and then `Phone Numbers`.  You can also head directly to <https://www.twilio.com/console/phone-numbers/incoming>.
* Click the `+` icon to add a phone number.
* Search for a phone number that has voice capabilities and pick a number that's to your liking.
* Complete the check-out process to purchase the number.

### Creating a TwiML bin

* From the twilio console, select `All Products & Services`, then `Runtime`, then `TwiML Bins`. You can also directly access the TwiML bins page directly via <https://www.twilio.com/console/runtime/twiml-bins>.
* Click the `+` icon to add a TwiML bin.
* Give your TwiML bin a friendly name, e.g. `Conference Line Forward` and look at the last section for adding the TwiML.

#### Adding and Examining the TwiML

Add some TwiML along the following lines.

 ```xml
<?xml version="1.0" encoding="UTF-8"?>
<Response>
    <Say voice="man">Now Forwarding to the stand-up conference line.</Say>
  <Dial>
    <Number sendDigits="wwww111111111#ww#">+1-222-222-2222</Number>
  </Dial>
</Response>
```

Let's break this down a bit. You can think of it like a script for whatever actions Twilio will take during the call.

* The `111111111` is our redacted Zoom Meeting ID,
* The `222-222-2222` is our redacted main Zoom dial-in number
* First, we say a phrase in a generic man's voice. (I chose the phrase so that the callers would know what was happening. I chose a generic man's voice because I was messing around with voice functionality one day, but there are a lot of options there.
* Next, we dial the number.
* After we say the phrase and dial the number, we send some digits & wait. In this case, a `w` represents a certain amount of time waiting. I fiddled with this a bit to get it right.
* Regarding `#ww#`: we need to enter `#` after we dial the meeting number, wait for it to ask our participant ID, and then hit `#`.

You can also refer to the [TwiML documentation](https://www.twilio.com/docs/voice/twiml) -- there's a bunch of stuff you can do with it.

When you are done with the TwiML bin, be sure to save it.

#### Associating the TwiML bin with the phone number

* Return to [the phone numbers screen](https://www.twilio.com/console/phone-numbers/incoming)
* Click on the phone number you previously purchased
* Select to accept voice calls
* Under `a call comes in`, select `TwiML` and select the TwiML bin you previously created.
* Save the phone number settings.

### Trying it out

Dial your number and hear it in action!

## What do you think?

Did you hit any snags? Have you solved this problem in a different way? Sound off in the comments!

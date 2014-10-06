---
layout: post
title: 'Maximo Tip: PM Work Order Cancellation [Field Notes]'
date: 2012-09-18 18:00:00.000000000 -04:00
---
###Problem
In Maximo, I want to cancel a PM work order because the work wasn't done for that particular scheduled PM.

However, when I attempt to cancel the PM, the following may happen:

* I don't see the `CAN` status anywhere in the list of statuses.
* I receive error BMXAA4507E: "warning-wo{0} is in a non-cancel condition"

###Solution
This happens because of PM work order sequencing within Maximo. The rules is: You cannot cancel a PM work order without first cancelling all the PM work orders that generated after that particular PM work order. The reasoning behind this is that based on how Maximo generates next PMs, a break in the sequence would cause this generation to fail. (I happen to see that as a design flaw, but hey, that's just me.)

What I didn't realize was that **if you've completed a newer PM work order, it cannot be canceled, and therefore none of the previous PM work orders that generated for that PM can be cancelled.**

For example: if I generate workorder #s 1, 2, 3, 4, and 5 (5 being the latest) on one PM, and I forget to do #s 1 and 2, I can cancel 5 and 4. However, if 3 was already completed, cancelling 5 and 4 does not mean that I can now cancel #s 1 and 2.

The recommendation in this situation, as far as I'm aware, is that the work orders that were missed (#s 1 and 2 in my example) **should be closed with a message indicating that work was never actually performed**.

Gross, but it's the only solution I've seen so far.

Have you found any better tricks for cancelling PMs or avoiding this problem? I'd love to hear about it in the comments.

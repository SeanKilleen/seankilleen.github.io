---
title: "TIL: Kubernetes Auto-scaling and Requests vs Limits"
comments: true
tags:
  - k8s
  - kubernetes
  - devops
date: 2025-01-06 09:00 -0500
header:
  overlay_image: /images/overlays/unsplash/mar-bocatcat-vi3fXw_6ySs-unsplash.jpg
  overlay_filter: 0.5
  caption: "Photo credit: [**Mar Bocatcat @ Unsplash**](https://unsplash.com/@marbocatcat?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)"
# cSpell:words Belgrave
---
I recently revised an incorrect mental model I had about Kubernetes as part of a strange experience, and I figured I'd share here in case it helps someone else.

## Background / Challenge

* I have a Horizontal Pod Auto-scaler set to scale at 80% CPU or 80% RAM, with a minimum of 2 pods and a max of 5.
* I've given these pods limits of 1GB RAM (throwing some more resources at a problem temporarily :wink: )
* I recently saw my HPA set the pod count to 3. So I'm curious as to why -- maybe these things are just hogging RAM?
* I see the RAM threshold as 84/80 on the HPA, even with 3 pods running
* However, I check our instance of [Goldilocks](https://goldilocks.docs.fairwinds.com/) which is giving us recommendations from a vertical pod auto-scaler (in observe-only mode) -- and it's telling me I can set our resources way lower.
* So I run `kubectl top pods --all-namespaces --sort-by=memory`
 ...and I see the pods are using 145mi, 118mi, 115mi -- far from the 1024mi I specified

What gives?

## First Lesson Learned: Horizontal Auto-scaling Works With Requests, not Limits

I made the math make sense.

If I request `150mi` for each pod, the total requested across all 3 pods is `450mi`.

I looked up the other values. 145 + 118 + 115 = 378, which is 84% of 445.

## But...Why? (the Part Where I Learn More about Requests vs Limits)

I got a great answer on the [Rands Leadership Slack](https://randsinrepose.com/welcome-to-rands-leadership-slack/) -- thanks to [Ryan Belgrave](https://linkedin.com/in/rbelgrave). In retrospect, it makes sense -- I had the wrong mental model.

In my mind, I was thinking that a pod would ask for more resources, and then this would change its utilization rate, affecting auto-scaling. To do it based on the resource request alone seemed too inflexible.

But where I was going wrong is that the limit, in a sense, doesn't matter. (Insert Lindsay Lohan gif here). The request defines what the pod should have to run, but if it asks for more memory and none is available, the container will close with an OOM exception.

There probably could be room here to improve horizontal pod auto-scaling to take into account the utilization based on currently granted resources. But I assume there's a very good reason it's not that way already, decided by people much better at this than I am.

So, if you need guarantees for your auto-scaling, you need to do it based on requests. What will happen, generally speaking, is:

* Memory usage hits the threshold
* Pods horizontally scale and continue to do so as needed
* Those pods may or may not ask for and receive additional resources as needed.

For this reason, a lot of people advocate for guaranteed QoS -- which is to say, setting the request and the limit to the same value. This way, you will be forced to ask for what your app needs and know that you won't be getting more. I'm torn on this, because I don't love the idea of asking for more at the outset that might not be used because I want it available for pods that need it.

## I'd Love Your Thoughts!

How do you strategize your pod resource requests and limits? Let me know in the comments!

---
title: "[Field Notes] Why Isn't my Kubernetes LoadBalancer Service Showing Up?"
comments: true
tags:
  - kubernetes
  - k8s
  - services
  - loadbalancer
date: 2025-06-15 08:45 -0400
---
Recently I hit something that stumped me for a bit, so I wanted to share my notes here.

## Background

In the Terraform for our SAP BTP Kyma instance, we had a deployment and a service of type LoadBalancer to expose that to the world
 Normally we'd use the default Istio-based mechanism, but in addition to an HTTP-based Web site, this workload exposed a function that Istio doesn't yet support (SFTP in particular).

Things were going fine, but when I moved to the official Helm chart for this workload, everything stopped working, I couldn't figure out why.

## Things I tried

* I checked the application logs and could see requests from the load balancer succeeding.
* I could get to the service _inside_ of the cluster using `kubectl port-forward`, so I knew things were accessible and running within the cluster.
* I looked at the YAML for what Helm generated vs what we had previously. It was essentially identical across the deployment, the services, and the DNS entry.
* Viewing in a web browser didn't fail immediately. It took ~20 seconds before I saw a failure.
* Tried all manner of checking the IP and DNS.
* Made sure that Istio wasn't being injected anywhere, since I knew we were purposefully going around it.
* Checked the Kubernetes events list for any load balancer events.

## Narrowing it Down

I was so focused on HTTP that I hadn't checked SFTP. Turns out...it worked! (there was additional confusion because I hadn't set up an initial user correctly).

So now, I knew that the workload could be seen by the world and it was just a matter of figuring out why I could view http inside the cluster but not outside. 

## The Culprit: Redirects!

As I mentioned earlier, the first thing I did was I looked in the container logs and I could see requests from the load balancer succeeding. But I missed a crucial detail.

The requests were succeeding...with a 302 redirect. While this is correct from an application perspective, load balancers see 302s as unhealthy in many cases. 

So now I had a theory: the load balancer was marking the mode as unhealthy and not allowing traffic (and also for some reason it wasn't showing up in Kubernetes events at all, which seemed strange)

## The Fix: Pointing the Load Balancer Elsewhere


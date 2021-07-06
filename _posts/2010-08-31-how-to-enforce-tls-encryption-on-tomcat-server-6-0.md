---
 
title: 'How To: Enforce TLS Encryption on Tomcat Server 6.0'
date: 2010-08-31 13:35:00.000000000 -04:00
comments: true
redirect_from: 
 - /2010/08/how-to-enforce-tls-encryption-on-tomcat.html
---
_[**Note**: I should begin this post by saying that I’m no expert on SSL or TLS encryption or the “handshakes” and negotiations that browsers and servers go through when giving the user a connection to secure material. Feel free to jump in on the comments if I get the terminology or methodology wrong.]_

As far as I understand it, SSL is pretty secure, but [TLS v1] (its successor) is the max you can get on a standard web browser for encrypted traffic between the browser and the server today.

Recently, I was tasked with setting up a [Tomcat Server] to enforce TLS for a government client. We had already defined a server.xml file that specified “TLSv1″ as the protocol and AES encryption. However, apparently Tomcat 6.0 doesn’t strictly enforce TLS if SSL is also enabled. That is to say, if TLSv1 is not enabled on the browser, but SSL is, the server will “fall back” to SSL in the hopes of displaying the content — I suppose it takes the “well, SSL is better than nothing” approach.

However, this wasn’t going to fly for my client — an institution with strict security rules for its web applications — which, really, is a good thing. If TLSv1 wasn’t enabled properly, the site shouldn’t display, even if SSL is enabled.

I looked around for how to do this, and to my surprise, it was incredibly difficult to find. After a great deal of Google searches and frustration, I finally found a post on the old, archived Tomcat developers listserv/group.[^1] It turns out that there’s another attribute you can add to your server connector in server.xml — the “protocols” attribute (standing for "secure" I believe; not a pluralization)

So, in short, a Tomcat 6.0 connector in server.xml that enforces TLS looks something like the connector below (I’ve changed the password to a dummy, of course):

```conf
<Connector
    port="8443"
    protocol="HTTP/1.1"
    protocols="TLSv1"
    SSLEnabled="true"
    enableLookups="false"
    acceptCount="100"
    maxThreads="200"
    scheme="https"
    keystoreFile="d:keystore.keystore"
    keystorePass="changeme"
    secure="true"
    clientAuth="false"
    sslProtocol="TLSv1"
    cipher="AES"
    allowUnsafeLegacyRenegotiation="false"
>
```

I wanted to provide this bit of knowledge as a public service. Would love to hear about your own experiences enforcing TLS or security in Tomcat and other web servers in the comments! Please let me know if you’ve found this useful.

#### Notes

[^1]: Unfortunately, I'm unable to find the link to this post. If I ever come across it, I'll update the blog accordingly. Feel free to point me to it in the comments.

[TLS v1]: http://en.wikipedia.org/wiki/TLSv1
[Tomcat Server]: http://tomcat.apache.org/

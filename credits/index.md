---
layout: single
author_profile: true 

title: "Credits"
modified: 2018-12-31T10:53:07.573882-04:00
sitemap: true
---  

These lovely people have contributed a fix to my blog. If you want to see yourself in this list, send me a pull request!

Every post in my blog has an edit link that lets you edit the blog post directly in the browser and automatically sends me a pull request.

Or [visit my repository]({{site.github.repository_url}}) and send me a pull
request the old fashioned way.

## General Credits

* I think much credit is due to [Phil Haack](http://haacked.com/). He inspired me with the idea that the entirety of a blog could be collaborative, and his posts on it removed some of the fear for me. His blog is the reason that I have an edit link, an issue submission link, and, well, this credits page. He's a constant source of inspiration.
* Thanks to [Pat Hawks][Pat Github] for helping [fix][pat 1] [several][pat 2] [issues][pat 3] early on. Thanks, Pat! 

## Contributors

<ul class="contributor-list">
{% if site.github.contributors.size > 0 %}

{% for contributor in site.github.contributors %}
  <li>
    <img src="{{ contributor.avatar_url }}" /> <a href="{{ contributor.html_url }}">{{ contributor.login }}</a>
  </li>
{% endfor %}

{% else %}
  <li>
    <img src="{{ site.avatar_url }}" /><a href="#">Nobody Yet</a>
  </li>
{% endif %}
</ul>

{% include _i-want-you.md %}

[jekyll link]: http://jekyllrb.com/
[ruby link]: https://www.ruby-lang.org/en/
[jekyll-sitemap link]: http://rubydoc.info/gems/jekyll-sitemap/0.6.0/frames
[octopress link]: http://octopress.org/
[github-pages link]: https://pages.github.com/
[jekyll-redirect-from link]: https://github.com/jekyll/jekyll-redirect-from
[minimal mistakes link]: https://mademistakes.com/articles/minimal-mistakes-jekyll-theme/
[disqus link]: https://disqus.com/
[phil haack homepage]: http://haacked.com/
[new issue link]: https://github.com/SeanKilleen/seankilleen.github.io/issues/new
[fork link]: https://github.com/SeanKilleen/seankilleen.github.io/fork
[pat 1]: https://github.com/SeanKilleen/seankilleen.github.io/pull/32
[pat 2]: https://github.com/SeanKilleen/seankilleen.github.io/pull/33
[pat 3]: https://github.com/SeanKilleen/seankilleen.github.io/pull/34
[Pat Github]: https://github.com/pathawks
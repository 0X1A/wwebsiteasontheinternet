---
layout: post
title:  "(At Least) A Commit a Day for 30 Days"
date: 2013-12-02
tags: misc
desc: A commit a day keeps the incompetence away
---

About 30 days ago I started my daily groggy morning, booting up my machines, 
checking for updates, reading the top posts on HN and /r/linux, and making 
coffee. I don't quite remember which of all the sites I tend to regular, was a 
link to a blog (more than likely it was HN). I just read the title, which I also 
don't remember, though it was probably something along the lines of '30 Days of 
Commits'. I immediately thought 'shit, I should do that'. So I have and here is 
the obligatory blog post.

It's often I find myself distracted by some of the wwebsites I listed before, I 
constantly choose to push back intentions to write a single line. This served as
a mean to eliminate just that procrastination. What quickly became the problem, 
was what to commit.


### What to push?
While it was easy to distract my self with [dotfiles](https://github.com/0X1A/dotfiles), 
[window manager configurations](https://github.com/0X1A/xmonad), or [updating a website](https://github.com/0X1A/wwebsiteasontheinternet), 
what I found difficult was adding to my larger project, a 2D game engine. Often 
times I found myself trying to avoid it. For months I had been pushing small 
diff commits, avoiding a quite measly object oriented design problem that I 
hadn't yet learned to solve. Though considering this is my first, rather large 
project, I tend to give myself a little leeway. Eventually, there was little 
much to do other than to work on the engine.

### The Commits

![Screenshot](/img/BotUrx2.png)

99 commits in the 30 days averages out to 3.3 commits a day. Generally I tried 
to keep commits meaningful. I have the habit of pushing small commits that tend 
to border along meaningless. A perfect example of this would be fixing a typo in
a README and commiting/pushing instead of waiting to commit/push with another 
change. I asked myself if I was pushing these commits to meet the daily quota, 
but this has been a habit of mine since I first picked up git, a habit I've 
found somewhat hard to break.

I quickly became more effective with the workflow I had set up using my dotfiles
and other set ups. I also sought out to use a CI server (both [my own](http://0x1a.us/ci)
on a local server and [Travis-CI](https://travis-ci.org)) as well as [Coveralls](https://coveralls.io).
All of which I had no prior knowledge in using, but thanks to some useful 
documentation I picked them up quicky and found myself becoming very fond of.
I also actively seeked out to try to get pull requests merged, though these were
mostly for documentation on projects. I also picked up GPG, and got into the 
habit of signing off my commits with my key. Something I've [read](http://mikegerwitz.com/papers/git-horror-story.html)
might come in handy once/if I get to work on a large project with other people.

I've been programming for a little over a year now, and I still very much 
consider myself a newbie. Doing this has helped me not only get into the habit 
of writing something at least once a day, but it's also helped me become more 
accustomed to my workflow.

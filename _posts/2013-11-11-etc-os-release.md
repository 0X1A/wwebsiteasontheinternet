---
layout: post
title:  "/etc/os-release"
date:   2013-11-11
desc: A shell script for all
---

I have the horrible habit of distro-hopping. I've constantly had to set up my
dotfiles. I honestly can't remember the amount of times or the amount of
distros I have installed on my machines, but it's easily been about a hundred
times during the past 2 years. So I thought to myself, why not just write a
script that installs everything I normally use? Enter my discovery of
`/etc/os-release` (the replacement of `lsb_release`). This file contains
information such as the distribution name, webpage url, support url and a bug
reporting url.

Output of `cat /etc/os-release` on Arch Linux:
{% highlight bash linenos %}
NAME="Arch Linux"
ID=arch
PRETTY_NAME="Arch Linux"
ANSI_COLOR="0;36"
HOME_URL="https://www.archlinux.org/"
SUPPORT_URL="https://bbs.archlinux.org/"
BUG_REPORT_URL="https://bugs.archlinux.org/"
{% endhighlight %}
This makes it easy to find the distribution name on LSB compliant
distributions. An example of this would be something like:
{% highlight bash linenos %}
#!/bin/bash

DIST=/etc/os-release

if grep Arch -c $DIST &>/dev/null
then
    echo "Distribution is Arch"
fi
{% endhighlight %}
Where Arch can be replaced with what ever distribution you are trying to check 
for. Of course there are more ways to do this then with `grep`, as is with most 
things.

### Where this comes in handy
Automation, I no longer have to install everything manually. Command, after
command, after command, after package manager, it became not only annoying, but
a huge time sink . All I do now is run a script that installs my doftiles, and
dependencies for my development environment. It's fast, and I no longer have to
waste time setting these things up after I've made the horrible decision to
leave my Arch comfort zone just to checkout the development of a different
distribution. 

For an example of such a script you can check out [the install
script](https://github.com/0X1A/dotfiles/blob/master/install.sh) for my
dotfiles.

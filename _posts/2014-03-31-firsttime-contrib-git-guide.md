---
layout: post
title: "A New Contributor's Guide to Git"
date: 2014-03-31
tags: dev
desc: A newbie's contributing guide
---

**Note:** This is not a guide to git but a guide to contributing
to a project that uses git for version control and general good practices for
getting things accepted for upstream.

With the Google Summer of Code coming around I've recently had first hand
experience on what happens when you don't practice good contribution guidelines.
That is, I had never contributed to a project that wasn't actively managed
through GitHub. Mailing patches was a completely foreign idea to me, and was
completely unaware that this is the way git was meant to be used. So then, what
exactly makes good (n)etiquette?

## Sign Your Commits
There are already several [horror stories](http://mikegerwitz.com/papers/git-horror-story) 
sprinkled around the internet concerning commits and potential forgery. There are
also several blog posts covering exactly how to sign your commits with both your 
GnuPG key and signing off, though to save you time searching for the latter I'll 
help you out here.

#### Signing with GnuPG key and SoB (Signed-off-by)
Creating a gpg key is out of the scope of this post though the [GnuPG manual](http://www.gnupg.org/gph/en/manual.html#INTRO)
is the best resource for this. You can set a global gpg key to sign with with:
{% highlight bash %}
$ git config --global user.sign key 00XX11AA
{% endhighlight %}
where `00XX11AA` corresponds with your public key.
So then, to sign a commit both with your gpg key and SoB simply run:
{% highlight bash %}
$ git commit -Ss
{% endhighlight %}
Passing both options `-Ss`, signs your commit with your set gpg key and adds 
your SoB. `s` for adding your SoB and `S` for signing with your gpg key.

## Formatting a Patch and Git's Email Feature
So you've committed changes to the repo on your branch and now you're ready to
show off your work, but how? Well, git can format patches for you. A patch is
essentially a diff between the changes you've made and the master branch.
To create a patch you run:
{% highlight bash %}
$ git format-patch origin/master
0001-Your-commit-message.patch
{% endhighlight %}
You now have a patch ready to submit to your project's mailing list and/or
maintainer. To do this you can use git's `send-email` feature, though to do that
you must have git configured with your email. A typical configuration for gmail
would look like this:
{% highlight bash %}
[sendemail]
from = YourName <you@gmail.com>
smtpserver = smtp.gmail.com
smtpuser = you@gmail.com
smtpencryption = tls
smtppass = GMAILPASSWORD
smtpserverport = 587
{% endhighlight %}

Now that you've got git configured with your email you can go ahead and send that
patch.
{% highlight bash %}
$ git send-email 0001-Your-commit-message.patch --to="Project Mailing list 
<project@mailinglist.org>" --cc="Project Maintainer <maintainer@email.com>"
{% endhighlight %}
Alternatively, if you use an email client you can simply attach that patch to the
message.

## Follow Proper Mailing list Practice
No HTML, don't reply to digests, no top posting. As a first time active 
participant 
in a mailing list I had no clue what top/bottom posting was, so here's a quick 
run down of what both look like.
### Top Posting
{% highlight text %}
Yes, I can apply this patch, thanks.

> On 30 Mar 2014, at 18:26, Friend <friend@email.com> wrote:
> The attached patch tries to resolve the looping issue with the
> "entered" branch of yours. I am assuming that you were referring to
> this in irc today morning, I was sleeping then and missed it.
{% endhighlight %}

### Bottom Posting
{% highlight text %}
> On 30 Mar 2014, at 18:26, Friend <friend@email.com> wrote:
> The attached patch tries to resolve the looping issue with the
> "entered" branch of yours. I am assuming that you were referring to
> this in irc today morning, I was sleeping then and missed it.

Yes, I can apply this patch, thanks.
{% endhighlight %}

Using bottom posting you're allowing the person that reads your response to see
exactly what you were responding to. It's also best to only quote what you are
responding to, leaving a line between the quoted text and your response. Also,
**don't forget to Cc the mailing list!** If you reply to someone and do not Cc
the list then everyone subscribed to the list will likely not see what you had
said in your message.

## Don't be a Git
>*Git - noun*
>
>1. a foolish or worthless person

A projects mailing list is usually reserved for developers and bug reporting. 
When reporting a bug it's in both the reporter's and developer's interest that 
you effectively give errors, process, and troubles that you're encountering. 
Simply saying "This won't compile" does not help at all. Generally, it's a good
idea to come across as competent. Always ask yourself WWLD? (What would Linus
do?) Make good changes, write good commit messages, have good (n)etiquette, and
don't be a git.

Now go, dig into some source, find something you can patch and submit your 
changes.

#### Resources
- [Submitting patches](https://www.kernel.org/doc/Documentation/SubmittingPatches)

- [Using a GPG Key to Sign-Off Git Commits and Emails](http://driesvints.com/blog/using-a-gpg-key-to-sign-off-git-commits-and-emails)

- [HOWTO Edit Messages - Message Editing and Quoting Guide](http://www.guckes.net/mail/edit.html)

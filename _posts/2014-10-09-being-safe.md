---
layout: post
title: "Being Safe: A Safer (Better?) Kernel"
date: 2014-10-09
tags: dev
desc: 
---

Ah C, the system programmers main maiden. One with pitfalls, caveats and major
downfalls. That is, I am not aiming to undermine any developer or persons
more knowledgeable than myself in both systems programming and C, or C++ for the
matter. For what it's worth I'd like to fully disclose that I am very much an 
amateur. What this post is about rather, is envisioning a better kernel through
a "safe" language.

## Rust
Yes, Rust. The language by Mozilla has attracted a lot of attension as of late
 (late being the past couple of years) not because it is a new language toting 
a new programming paradigm but rather a language that ensures and helps the user
 in writing something that they actually intend to write.

It's easy to fall into the opinion that a competent programmer will always know 
where their memory is and what their pointers are pointing to. Sure, there are 
many new features in C++ that could help the developer, but jeez have you seen 
the type of errors GCC throws at you when you step on something's toes using the
 STL? It can be quite the mess. Ideally the programmer is always at 100%, and 
ideally the compiler is always willing to do what the programmer does. Or at 
least what the programmer really meant to do. Threads, scheduling, concurrency, 
all these can obviously live safetly in the world of C as they have for the 
past decade. Standards, specifications that are ignored and thrown out the 
window, all a side effect of not the language or hardware specs 
but both implementations and old standards (or ignored standards) that help keep
old systems in order (lookin' at you POSIX). That is all and well for creating 
systems to befall the fallout of Unix. That is Unix is rather old, and POSIX 
seems to be rather tired.

## Rust is A Cute Kid, but Can it Stand by Itself?
Yes, it can, well, kind of.

From [rust-lang.org](http://www.rust-lang.org):
> Rust is a systems programming language that runs blazingly fast, prevents 
> almost all crashes*, and eliminates data races.

><sub>*In theory. Rust is a work-in-progress and may do anything it likes to
>up to and including eating your laundry</sub>

The Rust standard library depends on a runtime, and
 a lot of the juicy features of Rust depend on a C library implementation. Much 
 like C, all these things would have to be implemented essentially two times 
 over. Both in the C library for the system, and for the Rust runtime. Rust 
 aims to be a system programmer's language, but at it's current stage it is a 
 bit lacking. Just today Rust 0.12 was released, and getting a freestanding 
 Rust kernel would require a keen sense on the changes in the language. Again, 
 ideally, this language will and can be used to implement a safe, soft, cozy 
 place for an advanced operating system.

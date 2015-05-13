---
layout: post
title: "Working with Rust"
date: 2015-05-01
desc: Re-implementing The GNU coreutils in Rust
---

Rust is a programming language currently being developed by Mozilla Research.
Its main feature list includes: memory safety, preventing almost all crashes,
and eliminating data races. Never in my experience with a compiler have I
experienced such a stern yelling about my code other than with that of Rust's
`rustc`. That is, I was often used to writing C++ and a common 'gotcha' of the
language was having my program behave in a way I did not mean for it to. This
was often due to pointers, and pointer arithmetic. Though this post serves less
as an introduction to Rust and more to share my experience using Rust and my
decision to use it for [rewriting the GNU
coreutils](https://github.com/0X1A/core-utils). This rewrite served as both a
means to become more proficient in Rust and to hopefully build something that I
and possibly others could use.

## The Transition

Prior to learning and using Rust I used C++ exclusively. Like many other
programmers C++ was my first introduction to programming, my first large
project being a now completely defunct 2D game engine. Full of memory leaks,
amateur mistakes, and misconceptions of memory, that project was a rude slap to
the face. While working on this project I naively found build systems to be
quite lacking, as such I of course found the need to  write yet another build
system, or [`yabs`](https://github.com/0X1A/yabs) for short.  This was my first
project where I felt I had enough knowledge of C++ to carry it out effectively.
While working on this project I realized that the C++ standard library, for all
it's template glory, was quite lacking in terms of file systems.  In order to
write platform independent, well abstracted code for working with an operating
system's file system, your code had to be riddled with `ifdef`s, `defines`, and
platform specific functions and idioms. There are of course more issues with
C++, object oriented programming, and feature lacking standard libraries that I
will not be focusing on.

With C++, and object oriented programming being my main means of writing
programs I found the transition to Rust to be quite easy. I immediately found
the expressiveness of Rust to be comfortable and easy to use though I had the most
difficulty learning to use Options and Results.  The use of `::` for scope
resolution was something very familiar to that of C++.  The structure of
projects being a means to `use` (code re-usage) was welcome as this creates a
project structure that is ubiquitous, something that also extends to the
tooling in Rust. Rust's standard library is quite extensive and has many niche
iterators that are useful when needed. The ability to slice, dice, and walk all
over Strings, Vectors and other 'containers' is something that I found
extremely useful. At the time of my becoming familiar with Rust the `io`,
`io::fs`, and `path` sections of the standard library were being completely
rewritten and while they are currently completed have been left mostly
unchanged. That is for all except the file system library. At the time of
writing this post there are still request for commits, and pull requests for
expanding the file system library. I feel this is mostly a side effect of
realizing the need for platform specific code mostly due in part by Windows and 
Rust's aim to be cross platform. One driving feature of Rust that drew me 
toward it was the fact that it required no run time as it is not garbage 
collected.

## Options, Results, Borrowing
Rust uses enumerations such as `Options` and `Results`. Options being something
that *could* return something or *could* return nothing, Results being
something that perform an operation and return a result. I often found myself
getting bit by these as I was very used to having to write my own error
checking and more often than not wanted the raw type of what these Options and
Results returned. This was a side effect of my mentality of often checking for
null pointers. Once past the idea of having to worry about null and dangling
pointers, Rust becomes extremely intuitive and borrow checking can easily become
an internalized thought process. You know you only need one instance of a data
type and the rest of the operations in your program only need to borrow this
value, all while this variable is immutable.  Mutability being something that I
hadn't realized was mostly completely unnecessary.

## Performance

Rust aims to be an alternative to C++, and as such must have comparable speeds
of other lower level languages. This is by no means an exhaustive benchmark of
how my implementation of `cp` in Rust compares to the `cp` in GNU coreutils. I
performed this test by copying a 70.6 GB, 9,926 item music directory with `perf
stat -B` to two different disks.

{% highlight bash linenos %}
cargo build --release:
 Performance counter stats for './target/release/cp -r $HOME/Seagate/Music/ $HOME/TEST-COPY':

     160399.285445      task-clock (msec)         #    0.156 CPUs utilized          
           570,718      context-switches          #    0.004 M/sec                  
            96,585      cpu-migrations            #    0.602 K/sec                  
               195      page-faults               #    0.001 K/sec                  
   267,152,862,912      cycles                    #    1.666 GHz                     [50.00%]
    50,624,973,304      stalled-cycles-frontend   #   18.95% frontend cycles idle    [50.03%]
   114,100,673,787      stalled-cycles-backend    #   42.71% backend  cycles idle    [49.91%]
   172,888,318,472      instructions              #    0.65  insns per cycle        
                                                  #    0.66  stalled cycles per insn [50.01%]
    30,839,135,602      branches                  #  192.265 M/sec                   [49.97%]
     1,459,171,114      branch-misses             #    4.73% of all branches         [50.09%]

    1025.060399962 seconds time elapsed

GNU coreutils cp:
 Performance counter stats for 'cp -r $HOME/Seagate/Music/ $HOME/TEST-COPY':

     156200.234477      task-clock (msec)         #    0.144 CPUs utilized          
           473,207      context-switches          #    0.003 M/sec                  
            51,472      cpu-migrations            #    0.330 K/sec                  
               126      page-faults               #    0.001 K/sec                  
   249,170,324,400      cycles                    #    1.595 GHz                     [49.90%]
    40,056,284,614      stalled-cycles-frontend   #   16.08% frontend cycles idle    [49.82%]
   112,235,476,331      stalled-cycles-backend    #   45.04% backend  cycles idle    [50.17%]
   167,551,175,280      instructions              #    0.67  insns per cycle        
                                                  #    0.67  stalled cycles per insn [50.11%]
    29,852,150,825      branches                  #  191.115 M/sec                   [50.18%]
     1,114,941,065      branch-misses             #    3.73% of all branches         [49.83%]

    1087.533959400 seconds time elapsed

{% endhighlight %}
That's a lot of numbers. What I care the most about here are the cycles and
time elapsed. Even though this benchmark is somewhat predetermined as I am
performing it across two separate disks this is limited to their read and write
speeds, I could easily see a comparison between the two. My Rust implementation
finished at about 17.08 minutes and GNU at 18.12 minutes. This is hardly a huge
difference. This 'test' carries little weight, as it was highly dependent on
the the read/write speeds of the disks and does not include more complex data
structures or algorithms.

## Implementation of 'cp'

For my implementation I tried to use `unwraps` the least I possibly could. When
using an unwrap you are explicitly ignoring the likelihood of error and are
expecting a value from a Result or Option, which on error will result in a
panic. The only time I found myself using them was when I already knew the
function's failure cases were covered (in this case where I check if the `path`
is a file, I know it **must** then have a file name). Here `walk_dir_copy`
returns the Result of reading a directory and its contents using the `try!`
macro.

{% highlight rust linenos %}
fn walk_dir_copy(from: PathBuf, mut to: PathBuf) -> io::Result<()> {
    if from.is_dir() {
        if !to.exists() {
            copy_dir(&from, &to);
        }
        for cont in try!(fs::read_dir(&from)) {
            let cont = match cont {
                Ok(g) => { g },
                Err(e) => {
                    panic!(e.to_string());
                }
            };
            if cont.path().is_file() {
                copy(cont.path(),
                to.clone().join(cont.path().file_name().unwrap()));
            } else if cont.path().is_dir() {
                to.push(cont.path().relative_from(&from).unwrap());
                match walk_dir_copy(cont.path(), to.clone()) {
                    Ok(s) => { s },
                    Err(e) => {
                        panic!(e.to_string());
                    }
                }
                to.pop();
            }
        }
    }
    return Ok(());
}
{% endhighlight %}
`try!` uses the result of the Result that `fs::read_dir` returns. In case of
returning an `Err` it will immediately panic.

## Tooling

[Cargo](https://github.com/rust-lang/cargo), Rust's package manager and build
system, manages dependencies, metadata, publishing, build targets, and features
within a project using a TOML configuration file.  For example, core-utils'
current configuration (edited for brevity):

{% highlight TOML linenos %}
[package]
name = "core-utils"
version = "0.1.0"
authors = ["Alberto Corona <alberto@0x1a.us>"]
description = "A reimplementation of the GNU core utils in the Rust programming language"
repository = "https:/github.com/0X1A/core-utils"
keywords = ["coreutils", "core-utils", "core", "utils"]
license = "GPL-3.0"

[dependencies]
getopts = "0.2.10"
term = "0.2.7"

[lib]
name = "common"
path = "lib/lib.rs"

[[bin]]
name = "mv"
path = "mv/main.rs"

...
{% endhighlight %}
With this configuration we set project information, an executable binary to be
compiled under `[[bin]]`, a library to be compiled under `[[lib]]`, and the
project's  external dependencies. Even more yet, project features could be set
and selected at compile time with cargo. Running cargo automatically downloads
and compiles dependencies and compiles any library or binary files in your
project.

## Community

Rust's first compiler is to have a 1.0 release sometime in two weeks. As such
there are not many resources for working with the language that are not either
the compiler's source code itself, the build system, community written
libraries or documentation (some of which is still being written). There are
StackOverflow questions and blog posts but I often found them to be slightly
dated. Rust is a moving target, and could be difficult to keep track of. This
is something that I believe will change once 1.0 exits beta.

A huge resource to help understand Rust was the community on Rust's IRC
channel. When ever I was completely stumped I turned to the people on IRC for
help or clarification on either Rust's standard library, features of the
language, or syntax that I did not understand. Never did I feel patronized nor
was I ever belittled for asking a question, even though I'm sure there have
been questions that have been asked more than a few times, though I feel that
questions one asks should be well worded and not long the lines as "this does
not work". Never do I join IRC channels, but Rust's has been one that I've
found to be extremely helpful and inviting.

---
title: "Execute commands in nano"
date: 2023-04-11T18:10:14+03:00
draft: false
---

In nano, it's trivial to execute command and paste command's output to the
current buffer. That's what `Ctrl-t` does.

So, for example, you want to insert list of files with specified name. you
can do this in a such way:

- `Ctrl-t`
- type `ls -l | grep emacs`, press `Enter`

## How to filter rows in nano editor

We can pass text in the current buffer as input to a pipe that will
pass it to another program. To do this, press `Alt-\`
before typing command to execute.


For example, it's very handy to filter rows.
Imagine you have these rows in your buffer:

```
emacs
some string
I love emacs
I hate vim
I use web-mode for emacs to write html
```

To leave only strings that contain word "emacs":

- `Alt`-`t`
- `Alt`-`\`
- type <code>grep emacs</code>
- `Enter`

<p>
After that buffer will conain filtered rows:
</p>

<pre>
emacs
I love emacs
I use web-mode for emacs to write html
</pre>
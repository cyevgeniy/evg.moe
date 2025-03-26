---
title: "Why this site looks like this"
date: 2025-01-13
draft: true
show_full: true
icon: 'static/icons/js.svg'
---

Yes, this site looks pretty ugly, considering my everyday job is to write (and
my favourite - delete) CSS and JS. I'm nott a designer, but it wouldn't be so
hard to mimic popular UI pqatterns on my blog. So why it looks this way?

<!--more-->

It's the place where my frontend soul taking rest from my work. Let me explain.
The thing is that I like to think about any CSS and Javascript line of code as
of damage to the blank, raw, black-on-white web page. Sadly, industry likes
when you always add features (which, despite my best efforts, requires more
code), and doesn't like (in the best case it just doesn't care) when you're
doing something that doesn't ship new features, and it's equal to death when
you stop adding them.

Therefore, my daily job is to add code, which is a first frontend sin.

## Decisions

There's as little  CSS as possible to make the site look nice on mobile devices
+ a few color-related and decorating styles.

HTML markup is very simple. Again, because I don't use complex layout, I don't
need a lot of things to style.

I use hugo, so html minification is just as easy as this:

```
hugo --minify
```

That is, now all html markup in a generated website is minified.


## Plans

- Add pagination to the blog. I like when you can see all posts on a single
  page, but it looks nice only when you display only titles, without images or
  any post description.
- Use smaller images for post thumbnails in the posts list, or maybe dither
  original, full-sized images that are shown on a single post page. Dithering is
  not a silver bullet, though. The problem I encountered is that sometimes you
  can get a dithered image which is bigger than the original. Even in the hugo
  documentation section about dithering, a dithered image is bigger than
  original!

  ![](hugo-dither-documentation.png)

  ![](./hugo-dither-original.jpg)

  ![](./hugo-dither-dithered.jpg)

  ![](./hugo-dithered-sizes.png)

**But I like to change my blog instead of writing in it**, so I plan to limit CSS sizeto some plank - for example, 500 bytes, and try to change the look however I want whilt the max size is not exceeded.

<!---->
<!-- This site represents my opionated views on how -->
<!-- blogs should *not look like*, mainly: -->
<!---->
<!-- - If they don't provide interactive elements for learning purposes, -->
<!--   they should be fully static -->
<!-- - They should be minimized to the max (thanks to the tools like -->
<!--   LightningCSS, hugo etc it's very easy) -->
<!---->
<!-- I use hugo to build my blog. And with hugo, it's pretty trivial to -->
<!-- minimize css and html. -->
<!---->

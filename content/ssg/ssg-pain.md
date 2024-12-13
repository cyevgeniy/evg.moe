---
title: "The pain of static site generators"
date: 2024-11-05
tags: [ssh, hugo]
draft: true
---

I've been using static site generators (SSG) since my
first blog in 2016. My first SSG was Jekyl, and after
first problems with Ruby version I switched to Hugo,
which I still use today.

The main reason for static site generators for me is performance -
you just need to serve static html pages, which is
fast, no need for database, which is cheap.

But damn, it's **so hard to create content with them**.

Here I decided to log my main problems with static site generators.

## It's hard to write a blog post

To create a blog post, you have to physically clone the whole repo,
create a new file, fill all required parameters in the frontmatter,
save it. If your site is not builded on the server (Github pages for example),
you additionally need to build and upload your site. If you need to build,
you need to install your SSG on the machine you work, so it's very annoying
to write to your blog outside your configured environment.

## Frontmatter

This is evil. As I mentioned earlier, you need to fill a frontmatter
for a post. Frontmatter in SSG's is a special section in (usually)
markdown file, which contains required and optional metadata,  such as
title, create date, tags, featured images and a lot of other things.

For example, this is how the frontmatter for this post looks:

```
---
title: "Terrifier 3"
date: 2024-11-02
images: [/posts/terrifier3/terrifier.jpg]
featured_image: "/posts/terrifier3/terrifier.jpg"
tags: [terrifier, movies]
---
```

Each time you need to *type* these things - there's no way
to generate it automatically.


## Add an image

Adding images is full of bad emotions.
First, you have to download images to the specific directory.
You have to name it so it will be easy for you to type its name
(The only way you can add an image is to type its name in markdown).

This is one of the one of the reasons shy my previous post was
written in LibreOffice and then converted to PDF.

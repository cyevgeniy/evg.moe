---
title: "Let's create a site like we're in 90s"
date: 2023-04-13T23:51:11+03:00
draft: false
---

Now, it's very easy to create a website - there are so many
CMS, static site generators, online builders, so you can
create a nice webpage in a few clicks. In this post, we'll create
a website from scratch like we're in 90's. We'll dive into wonderful
atmosphere of freedom, into the time where web pages were fun an useful, and exploring
new websites was a great adventure. I hope you'll enjoy this post and maybe you'll
find some inspiration and new ideas, or just have fun. Moreover, during
this tutorial, you'll learn basic HTML, most of which is still relevant today.

## Tools

Websites were created mostly in two ways - with the help of 
WYSIWYG (What You See Is What You Get) html editors, or by using plain
HTML tags. We are going to use the second way, still Dreamweaver and Frontpage
software was also great. So, we need this:

1. Text editor. Pick a favorite one. I beg you  - don't use VSCode, please-please-please.
   Better choose something simple. I'll use Sublime Text, without any plugins, syntax highlighting
   and autocomplete. If you're a Windows user, Notepad is a great choice.
2. Web browser. It doesn't matter what you'll use - every modern browser is ok. But, you may
   want additionally install something more exotic - like Emacs Browser, or [Lynks](https://lynks.browser.org).
   Emacs Browser displays images, while Lynks works only with text and ignores images.


## Site's template

We'll create a personal site. On this site, we'll tell about our favorite music,
post some fancy pictures and create a page with useful guidelines about web development.
First, let's create a directory for our website. You may use any name you want, but I'll
name it `blog`. Inside this directory, create a file `index.html` - it's the main page of our
site, its "entry point". Right now, open this file and write this:

```
<html>
<head>
	<title> Personal website </title>
</head>

<body>
	<h1> Hello </h1>
</body>

</html>
``` 

The structure of our directory is very simple:

```
blog
|
+--index.html
```

Now, open index.html file in a browser - look what a beautiful site!
But we need to fill it with information, and for this, we need to learn
some basic html. Since we're in late nineties, we'll use
[this version of HTML](https://www.w3.org/MarkUp/1995-archive/html-spec.html).

### HTML

It's very simple, actually. All information is enclosed in *tags*.
Tags affect on visual presentation of our document  in a web browser, for example
this html text: `<strong> Strong text </strong>` will be rendered as bold text.
Almost all tags should have a closing tag,  - `</strong>`, in our example.

Our tags:

1. Headings. Created with tags `<h1></h1>, <h2></h2> ... <h6></h6>`. That's what the specification
   says about them:

   >Typical Rendering
   >
   >H1
   >Bold very large font, centered. One or two lines clear space between this and anything following. If printed on paper, start new page.
   >
   >H2 Bold, large font,, flush left against left margin, no indent. One or two clear lines above and below.
   >
   >H3 Italic, large font, slightly indented from the left margin. One or two clear lines above and below.
   >
   >H4 Bold, normal font, indented more than H3. One clear line above and below.
   >
   >H5 Italic, normal font, indented as H4. One clear line above.
   >
   >H6 Bold, indented same as normal text, more than H5. One clear line above.

2. Links. Classic blue link. Created with `<a href="anotherpage.html">Text</a>`
3. Paragraphs. Like in books. Created with `<p>Paragraph text </p>`
4. Strong text. To visually mark some text. `<strong>This is the strong text </strong>`


## Menu and other pages

Great, now we're ready to move further. First of all, we need to pick a cool site name. I like 
the "The Web Heaven". Let's add it to the website as well as short greeting message:

```
<html>
<head>
	<title> The Web Heaven site </title>
</head>

<body>
	<h1> The Web Heaven </h1>

	<p>
		Hi everyone, welcome to my tiny peace of Internet.
		On this site you may find interesting information about web development,
		helpful tips & tricks and some info about me.
	</p>
</body>

</html>
```

![Screenshot of the page](/posts/web90/webheaven_1.png)

Very nice! Now it's time to make a menu for our site. Here we have a large
variety of possible design decisions, but I prefer "classic" horizontal menu.
Menu is just a list of links, so it's easy to create one:

```
<html>
<head>
	<title> The Web Heaven site </title>
</head>

<body>
	<h1> The Web Heaven </h1>

	<a href="./tips.html">Tips </a>
	|
	<a href="./pics.html">Pictures</a>
	|
	<a href="./contact.html">Contact</a>

	<p>
		Hi everyone, welcome to my tiny peace of Internet.
		On this site you may find interesting information about web development,
		helpful tips & tricks and some info about me.
	</p>
</body>

</html>
```

![Screenshot of the page with menu](/posts/web90/webheaven_2.png)

Notice that we use relative paths in links ( `./tips.html`, not `/tips.html`), because otherwise 
our links won't work when we open our site locally. Obviously, we have to create `tips.html`, `pics.html`
and `contact.html` files. They have similar structure and differ only in headings:

```
<html>
<head>
	<title> Web dev tips </title>
</head>

<body>
	<h1> Tips </h1>

	<p>
		This is the Tips page
	</p>
</body>

</html>
```

Later we'll work on their design, now we just need some simple pages, like our
main page. Change headings on these pages by yourself. The structure of our site now is following:

```
blog
+--index.html
+--contact.html
+--pics.html
+--tips.html
```

Now when we open our main page, we see the menu. By clicking on menu items, we open
related pages.

![page screenshot](/posts/web90/webheaven_3.png)

Great, but here's a problem - we need the navigation menu on all pages, so add those lines to all remaining pages:

```
<a href="./tips.html">Tips </a>
|
<a href="./pics.html">Pictures</a>
|
<a href="./contact.html">Contact</a>
```

## Background

Our site is boring. White background and black screen - are you serious?
It would be cool to change the background of our site. Moreover, we want to set an image as a background.
But there's one problem - the Internet speed is very low.
So I'm going to use tiling images - small images that works like a puzzle - they create a nice decoration
when the screen is filled with them. I'm going to use this one:

![tiling background space image](/posts/web90/background.gif)

Download this image and save as `background.gif`.

For styling we'll use [CSS 1](https://www.w3.org/TR/REC-CSS1/). Let's add styles to all our pages. Create file `style.css` in the root directory of our site:

```
body {
	background: url(background.gif);
}
```

And then add styles on every page of our site, by adding this line inside `<head>` tag:

```
<link rel=stylesheet type="text/css" href="style.css">
```

![tiling background space image](/posts/web90/webheaven_4.png)

Now we have to fix text colors. Let's add them to the css file:

```
body {
	background: url(background.gif);
	color: yellow;
}

a {
	color: white;
}

h1 {
	color: red;
}
```

*Property `color` sets text color, and `background` property sets our space image as background*.

![tiling background space image](/posts/web90/webheaven_5.png)


## Interactivity


I like colors now, but I would have a more interactive, more "live" site. Of course, I don't know Javascript, but it's not a problem, because there are so many fancy pictures! Here's my choice:

![skull image](/posts/web90/skull.gif)

![dog image](/posts/web90/dogrun.gif)

![email image](/posts/web90/email.gif)

Download all these images to the site's directory. This is how it should look now:

```
blog
|
+--index.html
+--tips.html
+--contact.html
+--pics.html
+--skull.gif
+--background.gif
+--dogrun.gif
+--email.gif
```


Skull picture is for the site's name - so cool! Now we have to replace all occurrences of `<h1> The Web Heaven </h1>` with the `<h1><img src="./scull.gif"> The Web Heaven </h1>`. By the way, we placed image inside the `h1` tag, because otherwise heading is moved to the next line. This is how our main page looks now:

![](/posts/web90/webheaven_6.png)

Modify `contact.html` page:

```
<html>
<head>
	<title> The Web Heaven site </title>
	<link rel=stylesheet type="text/css" href="style.css">
</head>

<body>
	<a href="./index.html"><h1><img src="./skull.gif"> The Web Heaven </h1></a>

	<a href="./tips.html">Tips </a>
	|
	<a href="./pics.html">Pictures</a>
	|
	<a href="./contact.html">Contact</a>

	<h2><img src="email.gif"> Contacts </h2>

	<p>If you like my site, email me to my-email at somehost dot com</p>
</body>

</html>
```

You probably have noticed some changes - we've added a link to the homepage:

```
<a href="./index.html"><h1><img src="./skull.gif"> The Web Heaven </h1></a>
```

![](/posts/web90/webheaven_7.png)

## hr tag

Let's visually mark our navigation menu. For this, we'll use the `<hr>` tag. It stands for "Horizontal
Line", and of course it draws a horizontal line. Replace navigation menu **only in the `index.html` page** with
this code:

```
<hr>
<a href="./tips.html">Tips </a>
|
<a href="./pics.html">Pictures</a>
|
<a href="./contact.html">Contact</a>
<hr>
```

## Iframe

Of course, we have to update this menu in all our pages, but this is very inconvenient - it's hard to do even in three pages, what we say if, for example, our site will be 10 navigation pages? Well, in HTML 1 we need to
handle this by hands. But, if we would like to cheat and use [HTML 4](https://www.w3.org/TR/html401/), then fortunately, we can use
a mechanism that can help us to deal with that by including one html page into another, so that when we change
injected html file, it is being updated everywhere. This is possible with `iframe` tag, by the way - this is
how we watch youtube videos outside youtube nowadays! The bad part is that even if we want to use iframe, we need to
manually modify each file where we want to display navigation. So, if you wish, create `nav.html` file with the following content:

```
<html>
<head>
	<link rel=stylesheet type="text/css" href="style.css">
</head>
<hr>
<a href="./tips.html" target="_parent">Tips </a>
|
<a href="./pics.html" target="_parent">Pictures</a>
|
<a href="./contact.html" target="_parent">Contact</a>
<hr>
</html>
```

On each page we need to replace our menu with this line:

```
<iframe src="./nav.html" width="100%" height="60" frameborder="0"></iframe>
```

You can read more about `iframe` in the [specification](https://www.w3.org/TR/html401/present/frames.html#h-16.5).
Ughh, that's was tough, but now, when we need to modify navigation, we need to modify it only in our `nav.html`
file. Remember that it's available only because we've cheated - there weren't any iframes in the first versions of html.

## Add content

Now, it's time to finally add useful content (and I think some pictures, of course).
The trouble is that I don't have funny pictures, but in the future I definitely
add them. We need to notify our dear visitors that this site is not finished yet.
For this, we gonna use very popular solution - add a "under construction" banner
to our main page. Here's the picture:

![under construction banner](/posts/web90/construction.gif)

You can find a great collection of "under construction" banners [here](http://www.textfiles.com/underconstruction/).

This is how our `index.html` page looks now:

```
<html>
<head>
	<title> The Web Heaven site </title>
	<link rel=stylesheet type="text/css" href="style.css">
</head>

<body>
	<h1><img src="./skull.gif"> The Web Heaven </h1>

	<iframe src="./nav.html" width="100%" height="60" frameborder="0" >
	</iframe>

	<p>
		Hi everyone, welcome to my tiny peace of Internet.
		On this site you may find interesting information about web development,
		helpful tips & tricks and some info about me.
	</p>

	<h2> About me </h2>

	<p> I like music, funny pictures and I like HTML! </p>

	<img src="./construction.gif">
</body>

</html>
```

I think that it's enough for the first version, it's time to upload it to
Geocities and tell my friends about my brand new website. [Here](/posts/web90/index.html)
is what we've got. Hope this post was interesting for you.


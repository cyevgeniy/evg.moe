---
title: "Asciidoctor tutorial"
toc: true
---

Asciidoctor is a markup language similar to markdown, but
more readable.

## Installation

Asciidoctor has multiple "backends", so you can choose from
multiple options:

### Node

Run

```
npm i -g asciidoctor
```

### Ruby

Search for a package with name `asciidoctor`: 

```
apt-get install asciidoctor
```

## How to convert asciidoctor page to html

```
asciidoctor page.adoc -o page.html
```

## The best feature of Asciidoctor #1

Links are easy to remember, check it out: 

```
This link is parsed automatically:

https://example.com

This link will render as a word 'link':

https://example.com[link]
```

If you want to open a link in a new tab:

```
https://example.com[window=_blank]

https://example.com[link^]
```

Mailto links are also automatically parsed:

```
mailto:username@example.com

mailto:username@example.com[email me]
```

## The best feature of Asciidoctor #2

Images.

Now you'll never being thinking whether you wrote a link
or an image element.

```
image::coolpic.png[]

image::coolpic.png[cool picture]
```

## Basic elements

This example should give you the full
understanding of the base elements in
asciidoctor:

```
= Asciidoctor tutorial

Asciidoctor is a powerfull and elegand
markup language, much better than markdown.

It's strengths:

- Links 
- Images
- Elegant headings syntax


== Text formatting

- **Bold text**
- __Italic text__
- +++Underlined text+++


== Blockquotes

Blockquotes are also better than in markdown:

----
This is a blockquote
----

Authoring is also supported:

[quote, proj11.com]
----
Asciidoctor as a **markup** language is better
than markdown, but its backends suck.
----

```

## Links

- [Asciidoctor official site](https://asciidoctor.org)
- [Asciidoctor syntax quick reference](https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/)



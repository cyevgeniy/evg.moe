---
title: "Create a tooltip with CSS"
date: 2024-10-21
tags: [css]
---

Recently I was needed to add a quick tooltip to a `span` element
in a project with vuetify and vue2. My first try was to use
vuetify's `v-tooltip`, but, you know, it **didn't work
after 3 minutes of copy-pasting code samples from docs**. 

So I just googled something like "HTML native tooltip", and found
an example of a tooltip on stackoverflow, which impressed me with
its small amount of code and nice results.

## Demo

<div class="demo">
  <div class="tooltip" data-tooltip="Hi there!">Hover me</div>
</div>

The solution is to use data-attribute and `attr()` function:

```css
[data-tooltip]:hover::after {
  display: block;
  position: absolute;
  content: attr(data-tooltip);
  border: 1px solid black;
  background: #eee;
  padding: .25em;
}
```

```html
<div data-tooltip="Hello, World!">Hello, World!</div>
```

Often CSS-only solutions look very tricky, but this one is very
good, I like it.

## More info

- [original answer](https://stackoverflow.com/a/77796790)
- [author](https://stackoverflow.com/users/440172/etuardu)

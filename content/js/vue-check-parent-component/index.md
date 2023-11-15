---
title: "Vue: How to check for a specific parent component"
description: "Vue: How to check for a specific parent component"
date: 2023-11-14
draft: true
---

The problem: you want to make sure that a component is
placed inside some other component.
<!--more-->
The reason why you may
want to do this is that your current component has no sence
when used without some parent. For example:

```
<ContextMenu>
  <ContextMenuItem icon="home-icon" text="Home" />
  <ContextMenuItem icon="cut-icon" text="Cut" />
  <ContextMenuItem icon="paste-icon" text="Paste" />
</ContextMenu>
```

In such cases, you can use [provide/inject](https://vuejs.org/guide/components/provide-inject.html):

1. Provide some value in `ContextMenu`
2. Inject value in `ContextMenuItem`. If it's not defined,
   throw an error.

## Example

Create parent component, provide value
Create child component, inject, check and throw an error

## Where did I find this

[Headless UI library](https://headlessui.com/)
In the headless ui component library (Add link, posts)

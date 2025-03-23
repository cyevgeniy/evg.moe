---
title: "Vue js: on keeping all components in a single directory"
date: 2023-05-04T19:24:11+03:00
description: "On keeping Vue components in a single directory"
draft: false
icon: "static/icons/vue.svg"
---

The point of article: keep components in one single
directory with a flat structure.

<!--more-->

Almost all Vue projects have a `components` directory, where
all application's components are kept. There are plenty of ways
how you can organize them, but I think it's better to put all
your components right into `components`
directory and do not create any sub-directories trying to
make the structure obvious and simple. It may sounds strange, but
in practice exactly this way is more simple and future-proof.

## A flat components structure

As was told, the flat structure implies that components' directory have no
any sub-directories, just component files. Besides the components themselves,
this directory contains their tests, if any. This way of organizing components has some benefits over non-flat structure:

- It's easier to see the whole picture
- Imports are shorter:
  ```
  import Avatar from "./Avatar.vue"
  ```
  No ugly paths, like this:

  ```
  import Avatar from "@/components/main/header/Avatar.vue"
  import TextLabel from "../../Text/TextLabel.vue"
  ```
- You won't spend your time deciding where should you put
  your new component. This is a really good one. If you have a
  card with an article author's avatar and a header with the same avatar,
  where should you put the "Avatar.vue"? In a "header" subdirectory or
  in a "card"? Or maybe create a "shared" directory and put all repetitive
  components here? It's hard to decide actually.
  Moreover, often, when we create a new component,
  **we don't know whether it will be used somewhere else or not**. With
  the flat structure, it's not an issue.
- Such structure forces you to re-use your components. If you
  group components into different directories based on their
  functionality, business logic or visual hierarchy, then you wouldn't
  try to check whether a similar component already exists or not, or at
  least if you do, it will be hard to explore it.
- Resistance to changes. no more need to move component between
  directories and globally rename it because now it's not in the
  `TodoList` but in `Shared` directory.

## Official Vue style guides

Applying official components' naming convention dramatically increase
understanding of what's going on with your components. Consider this list of components:

```
Button.vue
MainLogoutButton.vue
LogoutButton.vue
Checkbox.vue
TextInput.vue
Sidebar.vue
Header.vue
```

```
AppButton.vue
AppTextInput.vue
AppCheckbox.vue
LogoutButton.vue
TheLogoutButton.vue
TheSidebar.vue
TheHeader.vue
```

At first glance it looks like there's no differences and both
lists provide the same information, but these styles of naming are very different.
Let's take `MainLogoutButton.vue` and `LogoutButton.vue`
from the first example. What's the difference between them? Most
probably we need to check their sources, because just their names don't tell
us anything. But in the second example, we know that the `TheLogoutButton.vue`
is the component that is instantiated only once per page, or even the whole
application, and most probably it has some specific application logic that
don't allow to re-use this component, though it's not a requirement.

The `App` prefix from the second example also tells us that those components
don't use any shared application state or implement any logic (such components are often called "dumb") -
they're used only for visual representation.

## Separate directories for pages and layouts

It's very common to use pages (views) that represent whole pages of the application,
and layouts directory with components that control high-order visual hierarchy (
for example, in a `Profile` layout we should always see `TheHeader` component at the top
of the page, but in the `Dashboard` layout it shouldn't be presented). Some
frameworks ([Nuxt](https://nuxt.com/)) or plugins for vue ([unplugin-vue-router](https://github.com/posva/unplugin-vue-router), [vite-plugin-pages](https://github.com/hannoeru/vite-plugin-pages)) expect
those directories, so if you use them, it's ok to move such kind of components outside
the `components` directory, just keep track of these directories cleanliness - they shouldn't
contain non-page or non-layout components.

## Links

- [Vue official styleguide ](https://vuejs.org/style-guide/)
- [Article on vueschool](https://vueschool.io/articles/vuejs-tutorials/how-to-structure-a-large-scale-vue-js-application/)

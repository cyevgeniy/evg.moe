---
title: "Vue: on flat components directory structure"
date: 2023-05-04T19:24:11+03:00
draft: true
---

The point of article: keep components in one single
directory.

<!--more-->

## Other ways to organize components directory

### Create subdirectory for pages

This way you create subdirectories for all pages in the application. Components that are
used exclusively on a page, kept in a corresponding folder (for example,
"dashboard", "profile"). Shared components usually
lie in a separate directory ("ui", "shared" etc). 


## Flat components structure

Flat structure means that components' directory have no
any sub-directories, just component files. Besides the components themselves,
this directory contains their tests, if any. This way of organizing components have
some benefits over non-flat structure:

- It's easier to see the whole picture
- Not a problem with aliases, but imports are short:
  ```
  import Avatar from "./Avatar.vue"
  ```
  No ugly paths, like this:
  ```
  import Avatar from "@/main/header/Avatar.vue"
  ```
- You won't spend your time deciding where you should put
  you new component. This is a really good one. If you have a 
  card with article author's avatar and a header with the same avatar,
  where you should put you "Avatar.vue"? In a "header" subdirectory or
  in a "card"? Or maybe create a "shared" directory, and put all repetitive
  components here? It's hard to decide actually.
  Moreover, often, when we create a new component, 
  **we don't know whether it will be used somewhere else or not**.
- Such structure forces you to re-use your components. If you
  group components into different directories based on their
  functionality, business logic or visual hierarchy, then you wouldn't
  try to check whether a similar component already exists or not. Most probably
  you'll create a new directory and a new component

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

At first glance it may look like there's no differences and both 
lists provide the same information, but there's a big difference
between them. Let's take `MainLogoutButton.vue` and `LogoutButton.vue`
from the first example. What's the difference between them? Most
probably we need to check their sources, because just their names don't tell
us anything. But in the second example we know that the `TheLogoutButton.vue`
is the component that is instantiated only once per page, or even the whole
application, and most probably it has some specific application logic that
don't allow to re-use this component, though it's not a requirement.

The `App` prefix from the second example also tells us that those components
don't use any shared application state (such components are often called "dumb").


## More links

- [Article on vueschool](https://vueschool.io/articles/vuejs-tutorials/how-to-structure-a-large-scale-vue-js-application/)




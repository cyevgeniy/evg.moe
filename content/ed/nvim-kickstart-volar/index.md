---
title: "Setup volar v2+ in neovim"
tags: [neovim, vue, editors]
date: 2024-06-26
draft: true
---

Allright, suppose you have Neovim and kickstart installed, you program
in vue and typescript, and you want to
have all these yammi features that volar offers.

Kickstart handles a lot, but starting from volar v2 and higher, typescript
support was moved to a separate package -
[@vue/typescript-plugin](https://www.npmjs.com/package/@vue/typescript-plugin).

First of all, we need to install it globally:

```
npm i -g @vue/typescript-plugin
```

Then, open `init.lua` file, and make sure your `tsserver` config
looks like this (add this section if doesn't exist):

```ts
tsserver = {
  init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
          languages = {"javascript", "typescript", "vue"},
        },
      },
  },
  filetypes = {'vue', 'javascript', 'typescript'}
}
```








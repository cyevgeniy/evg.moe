---
title: "Setup volar v2+ in neovim"
tags: [neovim, vue, editors]
date: 2024-06-26
draft: true
---

Alright, suppose you have Neovim and kickstart installed, you program
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

Also add this:

```
volar={}
```

You need to put the location of the the `@vue/typescript-plugin` is
installed. To find out where it's installed, you can run this:

```bash
npm root -g
```

This command prints the path to the directory where global packages are
installed (in my case it's `/usr/local/lib/node_modules`).










---
title: "Setup volar v2+ in neovim"
tags: [neovim, vue, editors]
date: 2024-06-26
draft: true
---

Alright, suppose you have Neovim and [kickstart](https://github.com/nvim-lua/kickstart.nvim) installed, you program
in vue and typescript, and you want to
have all these fancy features that [volar](https://volarjs.dev/) offers.

In the ideal world, simply adding `volar={}` in LSP config
should be enough, but starting from volar v 2.0 and higher, typescript
support was moved to a separate package -
[@vue/typescript-plugin](https://www.npmjs.com/package/@vue/typescript-plugin).

First of all, we need to install it globally:

```
npm i -g @vue/typescript-plugin
```

Then, open the `init.lua` file, find the code with
`local servers = {..}` and make sure your `tsserver` config
looks like this (add this section if it doesn't exist):

```lua
tsserver = {
  init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          -- Exact location of the typescript plugin
          location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
          languages = {"javascript", "typescript", "vue"},
        },
      },
  },
  -- Add TS support for vue files
  filetypes = {'vue', 'javascript', 'typescript'}
}
```


You need to set the location of where the `@vue/typescript-plugin` is
installed. To find out where is it, run this:

```bash
npm root -g
```

This command prints the path to the directory where global packages are
installed (on linux and mac, it's usually `/usr/local/lib/node_modules`).

The last step - add volar server:

```lua
local servers = {
  tsserver = {...},
  volar={}
  -- You can also add additional useful
  -- LSP servers, for example:
  -- eslint = {}
  -- tailwindcss = {}
}
```

That's it, after restarting neovim, you'll have the full experience of
volar!














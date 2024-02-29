---
Title: vue-tsc in watch mode
date: 2023-11-04
description: "Check for typescript errors in Vue components without LSP"
images: [/js/vue-tsc-watch-mode/vue-tsc.png]
---

`vue-tsc` can be run in a watch mode and report any typescript errors
as you change files in a project.

<!--more-->

Simply run it with this command:

```
npx vue-tsc --noEmit --watch
```

Why you may want to use it? I personally prefer to disable any
linter/LSP messages when I need more concentration on a task and I don't
want to be distracted by UI buzz that IDE or editor's plugins create.

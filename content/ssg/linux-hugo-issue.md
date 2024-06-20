---
title: "Problem solved: Hugo did not update content on linux"
date: 2024-06-20
tags: ['linux', 'ssg', 'hugo']
draft: false
---

Recently I was faced with a weird hugo behaviour on linux - it
didn't update the content of the site after running the dev server.

First thing that I tried is to run hugo with disabled "Fast Render Mode":

```bash
hugo server --disableFastRender
```

And it didn't help.

**Solution**: Reboot linux. I can't find the link right now,
but I found this answer somewhere on the internet.

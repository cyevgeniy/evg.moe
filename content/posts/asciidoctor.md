---
title: "Asciidoctor HTML output mess"
description: "Asciidoctor HTML output mess"
date: 2024-02-26T23:15:11+03:00
---

[Asciidoctor](https://asciidoctor.org) is a markup language, similar to
markdown. One of its tools, asciidoctor-js
(and most probably asciidoctor version written in Ruby),
wraps every block (paragraphs, lists and so on) in a div.
Resulting HTML is a mess.

<!--more-->

For example, simple code listing is wrapped in **three** divs:

```
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-vue" data-lang="vue">&lt;script setup lang='ts'&gt;
import { useFocus } from '@vueuse/core'
&lt;/script&gt;</code></pre>
</div>
</div>
</div>
```

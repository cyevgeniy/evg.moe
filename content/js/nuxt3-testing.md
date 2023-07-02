---
title: "Testing components in Nuxt 3 with vue testing library"
date: 2023-04-11T21:55:14+03:00
draft: true
---

In this tutorial, we'll learn how to test components in Nuxt3
and ....

<!--more-->

It's easy to use vue-testing-library with Vue itself. But
in Nuxt, I faced with some problems related to autoimports.
Moreover, I have used `unplugin-icons` package to get
offline versions of icons, which generates icons at the
build step, so during tests they're unavailable.
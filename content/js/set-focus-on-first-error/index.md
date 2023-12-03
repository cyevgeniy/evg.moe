---
title: "JS: focus on the first input with an error"
description: "How to set focus on the field that hasn't passed validation"
date: 2023-12-03
draft: true
toc: false
---

## TL;DR

Add `data-error` attribute to the element if it has an error and then
focus on it with [querySelector](https://developer.mozilla.org/ru/docs/Web/API/Document/querySelector) +
[focus()](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/focus).

## Project setup

Add link to zod validation post

## Create a form
### Define data structure
### Add validation
### Display errors
### Focus on error

## Pros and cons

+ Framework-agnostic, can be used with vanilla JS
- Won't work if html has non-default order of elements (because
  querySelector returns first matched element)

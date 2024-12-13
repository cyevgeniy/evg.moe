---
title: "How I spent half a hour because of a bad named variable"
date: "2024-12-13"
draft: true
---

Recently I was working on a feature in our Vue app, and
spent almost half a hour trying to figure out what the hell is
happening after I added only one line of code.

<!--more-->

The task was easy - I needed to pass an additional prop (`minDate`) to a component
which was a wrapper around the 
[VueDatepicker](https://vue3datepicker.com/) component.

<div class="note">

Here, I should say that often I use pretty minimal setup for
frontend development, and the most frustrating part for almost anyone
who I say that is that **I don't use VSCode and LSP plugins**.
</div>

Therefore, I needed to add just one line of code to a `NavBar` component, like this:

```vue{hl_lines=[7]}
const props = defineProps<{
  minDate: Dayjs
}>()

<template>
    <BasePicker
      :min-date="minDate"
    />
</template>
```

I added the line, and I saw a message in the console: 

```
[Vue warn]: Invalid prop: type check failed for prop "minDate". Expected Date, got Object
```

And of course, the `minDate` prop in the `VueDatepicker` didn't work.

After a few jumps between components, a few random `console.log`, I found the source of
the error - the component had a `computed` variable with the same name as a prop - `minDate`!

```vue{hl_lines=[5]}
const props = defineProps<{
  minDate: Dayjs
}>()

const minDate = computed(() => props.minDate.startOf('month'))

<template>
    <BasePicker
      :min-date="minDate"
    />
</template>
```

Later I launched VsCode and Ctrl + clicked on a variable name - a cursor jumped to
the computed. If I launched LSP, it won't be a problem at all, but I didn't 😤.

I don't know why I didn't search for `minDate` in the component and started searching for a problem
outside of the component, nor why we had a variable with the same name as a prop.

Such stupidiness just happens sometimes.

---
Title: Let's write a Vue component - checkbox
draft: true
date: 2023-09-23
toc: true
---

In this post, we'll create a checkbox component with Vue.
This time, we won't use any CSS framework.

## Init project

```
npm create vite@latest base-input-component -- --template vue-tsc
```

## Create a simple wrapper

Here's our first simple version of a checkbox component:

```vue
<script setup lang="ts">
defineProps<{
  modelValue: boolean
  label: string
}>()

const emit = defineEmits<{
  (evt: 'update:modelValue', v: boolean): void
}>()

function handleInput(e: Event) {
  emit('update:modelValue', (e.target as HTMLInputElement).checked)
}
</script>

<template>
  <label class="label">
    <input value="modelValue" type="checkbox" @input="handleInput">
    <span> {{ label }} </span>
  </label>
</template>

<style scoped>
.label {
  display: inline-flex;
  gap: 0.3rem;
}
</style>
```

It is, in fact, already usable. We'll disqus how we can improve it
soon, just a few notes on what we have done here.

Script part is pretty straightforward -
we declared props and events that our component will emit (for
now it's just an 'update:modelValue' event, which will be emited
every time user toggles the checkbox).

In the html markup, we wrapped input inside the `<label>` tag.
Label text itself is wrapped in `<span>` tag, which is a valid
case.

TODO: research more - Is span inside labels are valid Html markup?

## Disabled state

For disabled state, we'll use a `disabled` prop:

```vue{hl_lines=[5,13]}
...
defineProps<{
  modelValue: boolean
  label: string
  disabled?: string
}>()
...
<label class="label">
  <input
    value="modelValue"
    type="checkbox"
    @input="handleInput"
    :disabled="disabled"
  >
  <span> {{ label }} </span>
</label>
```

## Testing

We are going to use [vue-test-utils](https://test-utils.vuejs.org/) and [vitest](https://vitest.dev) for testing.
Installation steps were described in the [previous post](/js/lwvc-input/#install-vue-test-utils-and-vitest).

### Component is rendered

### Checkbox syncs initial state of the modelValue

### Emits 'update:modelValue' event

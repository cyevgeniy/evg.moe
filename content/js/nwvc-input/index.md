---
title: "Let's write a Vue component - Input"
date: 2023-08-10T21:52:43+03:00
draft: true
toc: true
---

## Stack

We will use these packages:

- Vite
- Vue 3
- Tailwind CSS

You can create a starter project with Vite easily,
checkout the docs.


## What we want to create

We're going to create a simple component which will wrap
`input` tag and provide some useful features that we almost
always want from the input field in any form. It will contain:

- A label that will be displayed above the input field
- An input element itself
- An error label, so we can display error message for the field

## Base wrapper

First of all, let's just wrap input element in a component.

*BaseInput.vue*:

```
<script setup lang="ts">
withDefaults(defineProps<{
  modelValue?: string
}>(), {
  modelValue: ''
})

const emit = defineEmits<{
  (evt: 'update:modelValue', val: string): void
}>()

function onInput(e: Event) {
  const target = e.target as HTMLInputElement

  emit('update:modelValue', target.value)
}
</script>

<template>
  <input
    :value="modelValue"
    type="text"
    @input="onInput"
  >
</template>
```

TODO: explain by small parts

*App.vue*:

```
<script setup lang="ts">
import { ref, watchEffect } from 'vue'
import BaseInput from './components/BaseInput.vue'

const text = ref('')

// For demonstration only
watchEffect(() => {
  console.log(text.value)
})
</script>

<template>
  <div>
    <BaseInput v-model="text" />
  </div>
</template>
```

TODO: explain by small parts

## Label and Error label

## Disabled state

## Icons

## Testing

Usually tests are being written in parallel with component implementation - you
write test for a specific testcase, it falls because the feature isn't implemented
yet, and then you make the testcase pass by implementig the feature in the component.

### Install vue-test-utils and vitest

### First test

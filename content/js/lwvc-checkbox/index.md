---
Title: Let's write a Vue component - checkbox
draft: false
date: 2023-09-23
toc: true
description: "Creating a checkbox component in Vue"
images: [/js/lwvc-checkbox/checkbox.png]
featured_image: "/js/lwvc-checkbox/checkbox.png"
tags: ["vue", "tech"]
icon: 'static/icons/vue.svg'
---

In this post, we'll create a checkbox component with Vue.
This time, we won't use any CSS framework.

<!--more-->

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
    <input :value="modelValue" type="checkbox" @input="handleInput">
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

It is, in fact, already usable. We'll discuss how we can improve it
soon, just a few notes on what we have done here.

Script part is pretty straightforward -
we declared props and events that our component will emit (for
now it's just an `update:modelValue` event, which will be emitted
every time a user toggles the checkbox).

In the html markup, we wrapped input and its label in the `<label>` tag.
Label text is wrapped in `<span>` tag, which is a valid
case.[^1]

[^1]: Thanks to this answer [here](https://stackoverflow.com/questions/31696060/can-i-put-a-span-and-an-input-inside-a-label)
      which pointed to the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label#technical_summary).
      According to them, [phrasing content](https://developer.mozilla.org/en-US/docs/Web/HTML/Content_categories#phrasing_content)
      (except another `label`) may be placed inside `label` tag.

## Main page

This is how we use our checkbox component (This is `App.vue` file):

```
<script setup lang="ts">
import { ref } from 'vue'
import LCheckbox from './components/LCheckbox.vue'

const checked = ref(true)
</script>

<template>
  <div class="demo">
    <LCheckbox v-model="checked" label="Test Value" />
  </div>
</template>

<style scoped>
.demo {
  padding: 2rem;
  border: 0.3rem solid darkgray;
  display: flex;
  justify-content: center;
}
</style>
```

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

## Styling

We won't style our checkbox much, just change label text color
when the checkbox is disabled:

```vue
...
<span :class="[disabled ? 'checkbox-disabled' : '']"> {{ label }} </span>
...
<style scoped>
.checkbox-disabled {
  color: lightgray;
}
```

**To pass a `true` value to a prop, it's enough to just
name it, like this**:

```
...
<LCheckbox disabled v-model="checked" label="Test label">
...
```

![Disabled checkbox](checkbox-disabled.png)

## Testing

We are going to use [vue-test-utils](https://test-utils.vuejs.org/) and [vitest](https://vitest.dev) for testing.
Installation steps were described in the [previous post](/js/lwvc-input/#install-vue-test-utils-and-vitest).

### Component is rendered

```ts
it('is rendered', () => {
  const wrapper = mount(LCheckbox, {
    props: {
      modelValue: true,
      label: '',
    },
  })

  expect(wrapper.find('[data-test="label"]').exists()).toBe(true)
})
```

### Checkbox syncs initial state of the modelValue

```
it('syncs initial state with modelValue (1)', () => {
   const wrapper = mount(LCheckbox, {
    props: {
      modelValue: false,
      label: '',
    },
  })

  expect(wrapper.find('input').element.checked).toBe(false)
})
```

### Emits 'update:modelValue' event

```
it('emits "update:modelValue" event', async () => {
  const wrapper = mount(LCheckbox, {
    props: {
      modelValue: true,
      label: '',
      'onUpdate:modelValue': (v: boolean) => wrapper.setProps({ modelValue: v }),
    },
  })

  await wrapper.find('input').setValue(false)
  // const events = wrapper.emitted('update:modelValue')

  expect(wrapper.props('modelValue')).toBe(false)
})
```

In this example we used [setValue](https://test-utils.vuejs.org/api/#setValue)
wrapper's method, which detects `input type="checkbox"` elements and sets "Checked"
attribute.

### Doesn't change state when disabled

Here we set `disabled` prop to `true` and trying to
change value in the checkbox. Since it's disabled,
initial `modelValue`'s value stays unchanged.

```
it('respects "disabled" property', async () => {
  const wrapper = mount(LCheckbox, {
    props: {
      modelValue: true,
      disabled: true,
      label: '',
      'onUpdate:modelValue': (v: boolean) => wrapper.setProps({ modelValue: v }),
    },
  })

  await wrapper.find('input').setValue(false)

  // The component is disabled, it means that 'update:modelValue` event
  // should not be emitted, and modelValue props will stay the same
  expect(wrapper.props('modelValue')).toBe(true)
})
```

## Full code

Here's the full source code for our component:

**LCheckbox.vue**

```
<script setup lang="ts">
defineProps<{
  modelValue: boolean
  label: string
  disabled?: boolean
}>()

const emit = defineEmits<{
  (evt: 'update:modelValue', v: boolean): void
}>()

function onChange(e: Event) {
  emit('update:modelValue', (e.target as HTMLInputElement).checked)
}
</script>

<template>
  <label class="label" data-test="label">
    <input
      :value="modelValue"
      :checked="modelValue"
      type="checkbox"
      @change="onChange"
      :disabled="disabled"
      data-test="label-input"
    >
    <span :class="[disabled ? 'checkbox-disabled' : '']" data-test="label-text"> {{ label }} </span>
  </label>
</template>

<style scoped>
.label {
  display: inline-flex;
  gap: 0.3rem;
}

.checkbox-disabled {
  color: lightgray;
}
</style>
```

**LCheckbox.spec.ts**:

```
import { expect, describe, it } from 'vitest'
import { mount } from '@vue/test-utils'
import LCheckbox from './LCheckbox.vue'

describe('LCheckbox', () => {
  it('is rendered', () => {
    const wrapper = mount(LCheckbox, {
      props: {
        modelValue: true,
        label: '',
      },
    })

    expect(wrapper.find('[data-test="label"]').exists()).toBe(true)
  })

  it('syncs initial state with modelValue (1)', () => {
     const wrapper = mount(LCheckbox, {
      props: {
        modelValue: false,
        label: '',
      },
    })

    expect(wrapper.find('input').element.checked).toBe(false)
  })

  it('syncs initial state with modelValue (2)', () => {
     const wrapper = mount(LCheckbox, {
      props: {
        modelValue: true,
        label: '',
      },
    })

    expect(wrapper.find('input').element.checked).toBe(true)
  })

  it('emits "update:modelValue" event', async () => {
    const wrapper = mount(LCheckbox, {
      props: {
        modelValue: true,
        label: '',
        'onUpdate:modelValue': (v: boolean) => wrapper.setProps({ modelValue: v }),
      },
    })

    await wrapper.find('input').setValue(false)
    // const events = wrapper.emitted('update:modelValue')

    expect(wrapper.props('modelValue')).toBe(false)
  })

  it('respects "disabled" property', async () => {
    const wrapper = mount(LCheckbox, {
      props: {
        modelValue: true,
        disabled: true,
        label: '',
        'onUpdate:modelValue': (v: boolean) => wrapper.setProps({ modelValue: v }),
      },
    })

    await wrapper.find('input').setValue(false)

    // The component is disabled, it means that 'update:modelValue` event
    // should not be emitted, and modelValue props will stay the same
    expect(wrapper.props('modelValue')).toBe(true)
  })
})
```

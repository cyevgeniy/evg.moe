---
title: "Create own signals in plain JS"
tags: ["js", "signals", "programming"]
date: "2024-06-09"
draft: true
---

In this article, we'll create our own signals implementation.

## What are signals

Signals are objects that incapsulate access to
their original value and can track dependencies that
use these signals as dependencies.

## Design signals

Our signals will work as in the [S.js](https://github.com/adamhaile/S) library -
the `createSignal()` will return a function that can be
used as a setter when we provide a new value, and as a getter when called without arguments:

```js
const userName = createSignal('User13')

console.log(userName()) // prints 'User13'

userName('User')
console.log(userName()) // prints 'User'
```

### Update value with function

For simple literal values like strings or numbers
changing values by simply passing them as arguments
is very handy, but for more complex types it may
be too verbose. Imagine a `user` object with complex
structure like this:

```
const user = {
  name: 'User13',
  age: 44,
  email: 'user13@mail.com',
  created_at: '2024-01-01',
}
```

To update one property we have to pass a new
value to a signal:

```js
const signal = createSignal(user)

signal({
  name: 'User02',
  age: 44,
  email: 'user13@mail.com',
  created_at: '2024-01-01',  
})

console.log(signal().name) // 'User02'  
```

We can, hovever, simplify this by using spread operator and signal as a getter:

```js
const signal = createSignal(user)

signal({
  ...signal(), // Will return current object
  name: 'User02',
})
```

Looks better, yet we can change it to be slighly handier - pass a callback
function with one parameter - current signal's value, and assign this
callback's result as a new value:

```js
const signal = createSignal(user)

signal(u => ({
  ...u,
  name: 'User02',
}))
```

Or with simple types:

```js
const signal = createSignal(3)

signal(v => ++v)

console.log(signal()) // prints '4'
```


## Links

- S.js
- SolidJS signals

---
title: "Create own signals in plain JS"
tags: ["js", "signals", "programming"]
date: "2024-06-09"
draft: true
toc: true
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
  ...signal(), // Will return the current object
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

But signals as containers for values are not very useful, though. We
want to be able to perform some actions when signal's internal value
changes. For this, we'll create a function named `on`:

```js
const s = createSignal(12)

on(s, (newVal) => {
  console.log(`New value is ${newVal}`)
})

s(13)
s(v => v++)
```

What we expect from this code? It should print these two lines:

```
New value is 13
New value is 14
```

## Implementation

First thing that we'll create is a function that acts differently depending
whether it's called with arguments or without them. For this, we need
the [arguments object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments).

```js{hl_lines=2}
function signal(param) {
  if (arguments.length === 0)
    console.log('Without arguments')
  else
    console.log('With arguments')
}

signal() // 'Without arguments'
signal(23) // 'With arguments'
```

Note that we can't check `param` for `undefined`, because in this
case we won't be able to distinct `signal()` and `signal(undefined)` calls:

```js
function signal(param) {
  if (param === undefined)
    console.log('Without arguments')
  else
    console.log('With arguments')
}

signal() // 'Without arguments'
signal(2) // 'With arguments'

// Oh no! It prints 'Without arguments'!
signal(undefined) // 'Without arguments'
```

For keeping the same state between signal function calls we'll wrap our state variable in a closure.

```js
function createSignal(value) {
  let _value = value

  function signal(v) {
    const isSetter = arguments.length > 0

    if (isSetter) {
      if (typeof v === 'function') {
        _value = v(_value)
      } else {
        _value = v
      }
    } else {
      return _value
    }
  }

  return signal
}

const name = createSignal('Anna')
console.log(name()) // 'Anna'
console.log(name('Tanya'))
console.log(name()) // 'Tanya'
```

And that's it, our signal is ready. It's simple, but it works! And it also works with functions, as we planned:

```js
const user = createSignal({ name: 'Anna', age: 41 })
user(u => ({...u, name: 'Tanya'}))
console.log(user().name) // 'Tanya'
console.log(user().age) // 41
```

### `on` function

This function accept a signal and a callback that should be called
when the signal is changed. It means two things:

1. We need some data structure to store callbacks
2. We need to modify the signals' implementation and execute required
   callbacks when signal is executed as a "setter".

Data structures go first. We'll use `Map` with signals as its keys and
array of callbacks as its values. This map should
be global for the whole module:

```
const effects = new Map()
```

```js
function on(signal, cb) {
  const signalEffects = effects.get(signal)

  if (signalEffects) {
    signalEffects.push(cb)
  } else {
    effects.set(signal, [cb])
  }
}
```

Very simple, isn't it? We just push the callback
to the array of already existed callbacks if it
exists. If it's not we create a brand new array with just
one value - our callback.

And finally, we need to find these callbacks
and execute them in our signals. This is the piece
of code that implements it:

```
// Find registered callbacks
const signalEffects = effects.get(signal)
if (signalEffects) {
  for (const cb of signalEffects) {
    cb(_value)
  }
}
```

## Full source

```js
const effects = new Map()

function ss(value) {
  let _value = value

  function signal(v) {
    const isSetter = arguments.length > 0

    // TODO: check for equality and don't trigger effects
    //       when the actual value has not been changed
    if (isSetter) {
      if (typeof v === 'function') {
        _value = v(_value)
      } else {
        _value = v
      }

      // Find registered callbacks
      const signalEffects = effects.get(signal)
      if (signalEffects) {
        for (const cb of signalEffects) {
          cb(_value)
        }
      }
    } else {
      return _value
    }
  }

  return signal
}

function on(signal, cb) {
  const signalEffects = effects.get(signal)

  if (signalEffects) {
    signalEffects.push(cb)
  } else {
    effects.set(signal, [cb])
  }
}
```

## Links

- S.js
- SolidJS signals

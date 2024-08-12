---
title: "Using Typescript to force errors handling"
date: 2024-07-24
draft: false
---

<div class="note shadow">

Summary: Typescript's discriminated unions may be
used to **force** you to handle exceptions.
</div>

## The problem

If a function can throw an error, it should be
wrapped in `try/catch` block to be properly
handled.

However, error handling  can be
ignored, which adds more room for potential errors. 

```ts
function getUserFromStorage(id: string) {
  return undefined
}

function getUser(id: string) {
  const user = getUserFromStorage(id)
  if (user === undefined)
    throw new Error('Specified user does not exist')

  return user
}

function printUserInfo(id: string) {
  const user = getUser(id)

  console.log(`User name is ${user.name}`)
}
```

The problem here is that we didn't check for errors
when we retrieve user from our storage.
Moreover, TS compiler **don't actually care**.

Ideally, `printUserInfo` should handle possible errors:

```ts
function printUserInfo(id: string) {
  try {
    const user = getUser(id)

    console.log(`User name is ${user.name}`)
  }
  catch {
    console.error('Some error')
  }
}
```
<div class="fb bg-black">
<div class="container">

## Discriminated unions

A union type is a type that combines multiple types into one.
A variable of a union type can store only values with those types:

```ts
type mode = 'edit' | 'view' | number

// ok, type ='edit'
const a = 'edit'

// ok, type = number
const b = 24

// ok, type = 'view'
const c = 'view'

// type error: type string is unassignable to type mode
const d = 'randomstring'
```

### Union types and type narrowing

When dealing with union types, we often need to **narrow** them before use:

```ts
type StringOrNumber = string | number

function getStringOrNumber(): StringOrNumber {
    return 2
}

let v = getStringOrNumber()

// Error!
// The left-hand side of an arithmetic operation must be of 
// type 'any', 'number', 'bigint' or an enum type.
console.log(v ** 3)
```

See, typescript complains because it doesn't know whether `v` is string or number,
Therefore, we need to **make sure that `v` is a number**:

```ts
type StringOrNumber = string | number

function getStringOrNumber(): StringOrNumber {
    return 2
}
let v = getStringOrNumber()

if (typeof v === 'number')
    console.log(v ** 3)
else
    console.log(v.toLowerCase())
```

Take a look at the last example one more time; did you notice ```console.log(v.toLowerCase())```?

It works because this statement is placed in the `else` branch of our check,
so typescript knows that `v` is a string.
</div>
</div>
 

## Fixing the problem

We can use union types and required type narrowing
to make result checking mandatory - or our program won't be compiled.

This is how it can be implemenented.

First of all, we create two main types and their union:

```ts
interface OkResult<T> {
  ok: true
  value: T
}

interface FailResult {
  ok: false
  error: string
}

type OkOrFail<T> = OkResult<T> | FailResult
```

Each of these types has `ok` field, which we can use to narrow `OkOrFail` type
to `OkResult` or `FailResult`:

```ts
type User = {
    name: string
    email: string
}

function getUser(id: number): OkOrFail<User> {
  try {
    const user = getUserFromDb(id)

    return {
      ok: true,
      value: user,
    }
  }
  catch {
    return {
      ok: false,
      error: 'can\'t find a user'
    }
  }
}
```

We used `try/catch` to return `OkResult` or `FailResult`, so our function
**doesn't throw errors**.

It returns union type instead, and in order to
work with the returned error we need to **narrow result** to `OkResult` type:

```ts
const u = getUser(1)

// Type Error!
// If u is `FailResult`, it doesn't have the `value` field!
console.log(u.value)

// Now everything is ok, we narrow result down to `OkResult` type
if (u.ok)
  console.log(u.value)
```

Always returning literal objects is too much to type, so we can create
helper functions for this:

```ts
function ok<T>(value: T): OkResult<T> {
  return {
    ok: true,
    value,
  }
}

function fail(error: string): FailResult {
  return {
    ok: false,
    error,
  }
}
```

And then our `getUser` can be refactored:

```ts
function getUser(id: number): OkOrFail<User> {
  try {
    const user = getUserFromDb(id)

    return ok(user)
  }
  catch {
    return fail('can\'t find a user')
  }
}
```

That's it, I hope you liked this article, good luck!

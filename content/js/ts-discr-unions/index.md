---
title: "Using typescript's discriminated unions instead try-catch"
date: 2024-07-24
draft: true
---

<div class="note shadow">

Summary: Typescript's discriminated unions may be
used to **force** you to handle exceptions.
</div>

## The problem

If a function can throw an error, it should be
wrapped in `try/catch` block to be properly
handled. However, in JS and TS, this **what**  can be
ignored, which adds one more place where bugs
may appear.

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
when we retrieved user from our storage.
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
A variable of a union type can store only values with those types,
for example:

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
</div>
</div>

Take a look at the last example one more time, did you notice ```console.log(v.toLowerCase())```?
It works because this statement is placed in the `else` branch 


## Fixing the problem

With discriminated unions, we can **force**
a programmer to check whether the result is
sucessful or not, but before let's recall what
are discriminated unions in typescript.


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

function getUser(id: string): OkOrFail {
  let result: OkOrFail<User>

    const user = getUserFromStorage(id)
    if (user === undefined)
      result = { ok: false, error: 'User was not found' }
    else
      result = { ok: true, value: user }

  return result
}

function printUserInfo(id: string) {
  const result = getUser(id)

  if (result.ok)
    console.log(`User name is ${result.value.name}`)
  else
    console.error(result.error)
}
```

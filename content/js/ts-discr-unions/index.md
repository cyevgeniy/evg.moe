---
title: "Using typescript's discriminated unions instead try-catch"
date: 2024-07-24
draft: true
---

Summary: Typescript's discriminated unions may be
used to **force** you to handle exceptions.

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
`printUserInfo` should look like this:

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

## Fixing the problem

By using discriminated unions, we can **force**
a programmer to check whether the result is
sucessful or failed:

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

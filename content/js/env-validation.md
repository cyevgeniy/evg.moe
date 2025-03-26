---
title: ".env validation with zod"
date: 2024-12-29
draft: false
tags: ["typescript", "validation", "programming", "zod"]
icon: "static/icons/js.svg"
---

**Summary**: You can use zod library to validate a `.env` file before building a
project. Zod's capabilities allow to handle very complex cases, though they are
very rare.

<!--more-->

Have you ever been in a situation when you built your frontend project and found
that some value in your `.env` file was incorrect, or even missed? I've been.

After the last time when this happened to me, I decided to add validation to the
build step.

## Add validation to a project

1. Install `zod`, `dotenv` and `tsx` packages as dev dependencies
   ```
   npm i -D zod dotenv tsx
   ```
2. Create a `validate-env.ts` file in a `scripts` directory:
   ```ts
    import 'dotenv/config'
    import process from 'node:process'
    import { z } from 'zod'

    const envSchema = z.object({
        VITE_BASE_API: z.string().url()
    })

    envSchema.parse(process.env)
   ```
3. Add this to a `build` script  in the `package.json`:
   ```
   build: "tsx scripts/validate-env.ts && vite build"
   ```

In my example I used vite and validated a single variable. You can add as many
rules as you need.

## Testing

Delete the .env file if it exists, and run `npm run build`. Zod will throw
an error, because the `VITE_BASE_API` variable is not valid:

```
ZodError: [
  {
    "code": "invalid_type",
    "expected": "string",
    "received": "undefined",
    "path": [
      "VITE_BASE_API"
    ],
    "message": "Required"
  }
]
```

Add the `VITE_BASE_API` variable to your .env, but leave it empty:

```
VITE_BASE_API=''
```

Now zod throws another error, because provided value is not a valid url:

```
ZodError: [
  {
    "validation": "url",
    "code": "invalid_string",
    "message": "Invalid url",
    "path": [
      "VITE_BASE_API"
    ]
  }
]
```

## Keep in mind

**When you add such thing to your project, you take additional responsibility
for updating validation rules.**

I Hope it was useful to someone, good luck.

## Links

- [Zod library](https://zod.dev) is used for validation
- [Dotenv package](https://www.npmjs.com/package/dotenv) is used for reading
  `.env` file
- [Tsx package](https://tsx.is/) is used to run `.ts` files in one command

---
title: ".env validation with zod"
date: 2024-12-29
draft: true
tags: ["typescript", "validation", "programming", "zod"]
---

Have you ever been in a sutuation when you build your frontend project and found
that some value in your `.env` file was incorrect, or even missed? I've been.

<!--more-->

After the last time when this happened to me, I decided to add validation to the
build step.

**Summary**: You can use zod library to validate a `.env` file before building a
project. Zods capabilities allow to handle very complex cases, though they are
very rare.

## Steps

1. Install `zod` and `dotenv` packages as dev dependencies
   ```
   npm i -D zod dotenv
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

In my example, I used vite, and validated a single variable. You can add as many
rules as you need.

By the way, this will also work in a CI/CD pipeline.

## Links

- [Zod library](https://zod.dev)
- [Dotenv package](https://www.npmjs.com/package/dotenv)

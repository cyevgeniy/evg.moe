---
title: "Using typescript's discriminated unions instead try-catch"
date: 2024-07-24
draft: true
---

I always didn't like try-catch blocks, and mainly because
`try/catch` block **breaks normal code flow**.

Using try-catch forces you to keep in mind additional context.

You may say: "Your code block inside the try/catch block
should be tiny and fit in 70 lines". **This is theory**.
In reality, you **will** met the large code wrapped in try/catch.


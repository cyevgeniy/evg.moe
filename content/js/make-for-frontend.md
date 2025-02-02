---
title: 'Using make in frontend projects'
date: 2025-02-01
draft: true
---

It's common to use package.json scripts to run commands in node-based
projects, like this: `npm run dev`.

To the point - I've started to use `make` in frontend projects, and I really like it. Here's an example of a Makefile for one of my projects at work:

```make
devpod:
	devpod up .
	devpod ssh lmst
dev:
	npx vite
type:
	npx tsc --noEmit
size:
	npx vite build
	npx size-limit
test:
	npx tap
```

Here's why I think it's better than scripts in a `package.json` file:

- Multi-line commands
- Comments
- Works great with non node-based commands. In one of our projects we use selenium for integration tests, and I don't blowing my mind every time struggling to remember how to install all dependencies and run tests.

For development I use devcontainers, and as you can see, connecting to a devcontainer is pretty much to type:

```bash
devpod up .
devpod ssh projname
```

Now I'm just typing `make devpod`, and after a few seconds I'm inside =>.

I've faced with one cons, though - Windows support. It will require additional steps to setup make. To handle this issue, we use a simple rule - base commands should be always available via `npm run`, such as
`dev`, `build`, `test`, and in the Makefile we duplicate them + add all other commands that may be useful.


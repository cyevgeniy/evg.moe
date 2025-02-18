---
title: 'Using make in frontend projects'
date: 2025-02-01
draft: true
---

It's common to use package.json scripts to run commands in node-based
projects, like this: `npm run dev`.


I've started to use `make` in my frontend projects, and I really like it.
Here's an example of a Makefile for one of my projects at work:

```make
devpod: # start a devcontainer and ssh into it
	devpod up .
	devpod ssh lmst
dev: # run in a dev mode
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
- Comments. Each line can be commented. You can describe **why** you run one command
  before another. In a `package.json` file, all your commands are placed on a single line.
- Works great with non node-based commands. In one of our projects we use selenium for integration tests, and I don't blowing my mind every time struggling to remember how to install all dependencies and run tests.

For development I use devcontainers, and connecting to a devcontainer is pretty much to type:

```bash
devpod up .
devpod ssh projname
```

Now I'm just typing `make devpod`, and after a few seconds I'm inside a devcontainer.

*In a team, this approach will work only if each of team's members
uses a platform with a `make` available. On linux and Mac, it's already
included. On a Windows system you need to install `make` by yourself.*

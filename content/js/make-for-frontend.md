 ---
title: 'Using make in frontend projects'
date: 2025-03-07
draft: false
---

**Summary**: Using `make` can greatly simplify the maintainance of your project.
If any command requires more than a few words to type, consider adding it to a `Makefile`.

It's common to use package.json scripts to run commands in node-based
projects, for example, `npm run dev`.

Recently, I came across several articles discussing the use of `make` and decided to give it a try.

As a result, I've started using `make` in all of my frontend projects, and I really like it.
Here's a simplified example of a Makefile for one of my work projects:

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

I think it's better than scripts in a `package.json` file, because of:

- Multi-line commands.
- Comments: each line can be commented. You can describe **why** you run one command before another. In a `package.json` file, all your commands are placed on a single line
- Works great with non-Node.js commands. In one of our projects, we use Selenium for integration tests, and I no longer struggling to remember how to install all dependencies and run tests

For development I use devcontainers + devpod setup, and connecting to a devcontainer is pretty much to type:

```bash
devpod up .
devpod ssh projname
```

Now I'm just typing `make devpod`, and after a few seconds I'm inside a devcontainer.

*In a team, this approach will work only if each of team's members
uses a platform with a `make` available. On linux and Mac, it's already
included. On a Windows system you need to install `make` by yourself.*

## A small tutorial on how to start using "make"

It's pretty easy to get started with `make` -just create a `Makefile` in the project's root directory.

Makefile consists of *targets*. For example, in the `make build` command,
`build` is a target.

Let's add a `type` target, so we'll be able to use `make type` to run typescript
checks in our project:

```make
type:
	npx tsc --noEmit
```

Nice! To build our project, we'll use `build` target. Typically, we want
to check types and then  build the project. For this, we can use *dependencies*:

```make
type:
	npx tsc --noEmit

build: type
	npx vite build
```

Now, if we run `make build`, actually these commands will be executed:

```
npx tsc --noEmit
npx vite build
```

#### Variables

Some commands differ by just one flag, such as running typescript type checks
mentioned above either single time or in watch mode:

```
npx tsc --noEmit
npx tsc --noEmit --watch
```

We can duplicate these commands:

```make
type:
	npx tsc --noEmit
type-watch:
	npx tsc --noEmit --watch
```

Or we can use **variables**:

```make
type:
        npx tsc --noEmit $(WATCH)

type-watch: WATCH = --watch
type-watch: type
```

Here, the `type-watch` target just sets a `WATCH`
 variable, and re-uses `type` target.

## A "docs" Pitfall

If you run a target and there's a file or
directory with the same name exists, `make` will think that this target
is up to date and won't do anything!

A classic example here is a `docs` target - most probably you would like
to run `make docs` to generate the  documentation, but if your
documentation is placed in the `docs` directory, you'll see this message:

```
make: 'docs' target is up to date.
```

To always run the specified target in such scenarios, we
need to use a special `.PHONY` target:

```make
.PHONY: docs

docs:
	npx vitepress
```

## Links

- [An introduction to Makefiles](https://web.mit.edu/gnu/doc/html/make_2.html#SEC4)
- [Makefiles for frontend](https://medium.com/finn-no/makefiles-for-frontend-1779be46461b)

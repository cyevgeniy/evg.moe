---
title: "Sublime Text setup for dev containers"
date: 2024-11-27
draft: true
---

In this article I'll tell how I use Sublime Text for frontend
development with devcontainers.

<!--more-->

## What are devcontainers

Link to the devcontainers site,


## Sublime text setup

With Sublime text, we can't achieve the same tight integration as
with VSCode, because it ...

Basic sublime text setup - essential plugins (terminus, package manager, comments-only colorscheme)

## Devcontainers setup

This section describes devcontainers setup.
For this, we'll use a few tools:

- Devpod
- Docker

We use devpod for just one thing - port forwarding from a container to a host.
Docker is used as a containers. (Podman didn't succeed because it can't detect
changes to the disk and so vite didn't reload).

## Workflow

Run sublime.

Open terminus in a new tab(view).

Run `devpod up .`

Run `devpod ssh project-name`

Open terminus panel.

Run `npx tsc --noEmit --watch`.

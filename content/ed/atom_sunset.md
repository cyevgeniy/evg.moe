---
title: "Atom text editor's sunset"
date: 2023-04-13T23:51:11+03:00
draft: false
---

"A hackable editor for the 21st Century", they said.

<!--more-->

## How it was at the beginning

In 2014-2015 ( I've found snapshots of [atom.io](https://atom.io)
website for 2014 year on [waybackmachine](https://web.archive.org/),
but Wikipedia says that it was released in 2015), Github released Atom ( I personally can't recall when I
 first heard of Atom) - "A hackable editor for the 21st Century".
It quickly became very popular, because... I don't know why, I never liked it.
Anyway, it's the fact. Atom was a loud name. None of "Best editors for..."  types of
articles and blog posts hadn't mentioned Atom as a honorable member of their lists.
It was built using web technologies ( that wasn't so popular as now ),
it was free, and a language for its extension was Javascript - one of the most popular
languages. Because of electron, Atom was RAM expensive for a text editor ( especially in comparison
to Sublime Text, Emacs, Vim or Notepad++ ), but for most users it wasn't an issue, because Atom was
in trend and beside that it had some really nice features - for free and out of the box.

## Microsoft bought Github

In 2018, Microsoft acquired Github. It was obvious that Microsoft won't support Atom because it had its own
product - VSCode, which is a mainstream editor/IDE now. I think that VSCode has drained a lot of ideas
and features from Atom:

- Technology (Electron)
- Extension language
- Built-in interface for working with git repositories
- Collaborative editing (In Atom , it was called "Teletype", in VSCode, it's the "Live Share" feature)

Over the years, VSCode was actively evolving ( not always in a good direction ) and became more and more
popular across developers. Let's see at stackoverflow developer survey results.

- 2022 - 1st place (74.48%); Atom - 12 place (9.35%) 
- 2021 - 1st place (71.06%); Atom - 10 place (12.94%) 
- 2020 - I have not found info about tools for this survey
- **2019 - 1st place (50.7%); Atom - 10 place (13.3%)**
- 2018 - 1st place (34.9%); Atom - 9 place (18.0%) 
- 2017 - 5 place (24%); Atom - 7 place (20%) 
- 2016 - 13 place (7.2%); Atom - 9 place (12.5%) 
- 2016 - Not presented; Atom - 5 place (2.8%) 

In 2019, the next year after acquiring Github, VSCode made a huge jump - from 34 to 50%. 

![](/ed/atom_dead_discussion.png)

By the way, Wunderlist service ( a todo app) was shut down the same way - it [was bought](https://techcrunch.com/2019/12/09/microsoft-to-finally-shut-down-to-do-list-app-wunderlist-on-may-6-2020/) by
Microsoft and later closed in favor of Microsoft todo.

## Sunset

In the winter of 2022, Github published a blog post, where they
announced that they're sunsetting Atom.

![Atom editor sunset](/ed/atom_sunset.png)

## Pulsar

Community has forked Atom and reincarnated it as Pulsar editor.

[Official website](https://pulsar-edit.dev/)

It's mostly an Atom editor (that's good), just with a new name.
According to the [Goals page](https://pulsar-edit.dev/about.html#the-goals),
Pulsar's main goal is to keep Atom and its huge package base alive and up to date.
It's a great idea.

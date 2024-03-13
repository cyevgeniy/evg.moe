---
title: "Sublime text basics"
date: 2023-04-29T21:37:11+03:00
draft: false
tags: ["editors", "sublime"]
---

Sublime Text basic usage.

## Tabs

- `Ctrl` - `n` - create new tab
- `Ctrl` - `w` - close current tab
- `Ctrl` - `tab` - move to the next tab

## Command palette

If you don't know hotkeys for a command, or don't know if such
a command even exists, use command palette. It's the first place
where you should search for unknown commands. To open the command
palette, press `Ctrl` - `Shift` - `p`, and then type command
name. For example, you want to transform selected text to upper case.
This is what you should do:

1. `Ctrl` - `Shift` - `p`
2. Type text "lower"
3. Select "Convert case: Lower case" command ( moving arrows ),
   and press `Enter` (or click )

## Sidebar

- `Ctrl` - `0` - focus on sidebar
- `Ctrl-k, Ctrl-b` - toggle sidebar

## Layouts

Sublime Text allows you to open a few tabs side by side.

- `Alt` - `Shift` - `1` - leave only one edit buffer
- `Alt` - `Shift` - `2` - split window vertically ( 2 tabs )
- `Alt` - `Shift` - `3` - split window vertically by (3 tabs)
- `Alt` - `Shift` - `4` - split window vertically by (4 tabs)
- `Alt` - `Shift` - `5` - "Grid layout". Two windows in a row
- `Alt` - `Shift` - `8` - Split horizontally, 2 tabs
- `Alt` - `Shift` - `9` - Split horizontally, 3 tabs

You can move between layout windows with `Ctrl` + `<number>` hotkeys.
`Ctrl` - `0` - move to the sidebar, `Ctrl` - `1` - move to the first tab,
`Ctrl` - `2` - move to the second tab, and so on.

## Line manipulation

- `Ctrl` - `Shift` - `arrow up/arrow down` - move the current line up/down
- `Ctrl` - `c` - copy the whole line
- `Ctrl` - `x` - cut the whole line
- `Ctrl` - `Shift` - `arrow up/down` - move the line up/down

## How to install packages (plugins)

First, you need to install package control. It's the Sublime Text package
manager.

1. Open control palette (`Ctrl` - `Shift` - `p`)
2. Type "Install package control", press enter
3. When package control is installed, open control palette and
   type "Install package" -  press enter.
4. Then start typing package name, for example "Color scheme". Sublime Text
   will show related packages.

## Multiple cursors

Sublime Text has a great support for working with multiple cursors.
To set an additional cursor, use `Ctrl` - `click`. Then, all commands
( like moving cursor, char/word deletion etc) will be applied to all
cursors.

There's also nice feature in Sublime Text - you can select next occurance
of the current word. It works this way:

1. Press `Ctrl` - `d` on current word. It will be selected.
2. Press `Ctrl` - `d` one more time. The next occurance of this word will be
   selected.

This is useful when you want, for example, delete or replace some occurances
of a word.

## Working with code

These commands may be useful for programmers.

- `Ctrl` - `m` - move between brackets. Works even if the cursor
  is placed in the middle of text between them.
- `Ctrl` - `Shift` - `m` - select text between brackets
- `Ctrl` - `g` - go to line
- `Ctrl` - `;` - open dialog with all words in the current document.
  Start typing, then select required word with `Enter`. Then you can
  move to the next occurance of the word with `F3`

---
title: "How to install packages on startup in Emacs"
date: 2023-04-13T23:51:11+03:00
draft: false
tags: ["editors", "emacs"]
---

Put these lines at the beginning of your `.emacs`:

<!--more-->

```
; list the packages you want
(setq package-list '(
	web-mode
	projectile
	))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
```

This solution I've grabbed [here](https://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name)

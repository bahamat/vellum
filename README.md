# Vellum — Beautifully Published Markdown Documents

> **vel•lum** `|ˈveləm|` noun  
> 1. fine parchment made originally from the skin of a calf.  
> 2. smooth writing paper imitating vellum.

Vellum is for individuals who want to make notes and publish them for others to see.

## Getting Started

1. Run `make setup`.
2. Add Markdown files to `src`.

#### Publishing Documents

1. Run `make`.
2. Sync `site` to your publishing root.

You can also use git hooks to automatically publish when you commit.

## Requirments

* [Pandoc 1.9][pandoc-install]
* `make`
* A web server to publish to.

## Bugs

The search currently has no form action. 

----

[pandoc-install]: http://johnmacfarlane.net/pandoc/installing.html
# Stencil Mail

A fork of [Stencil](http://github.com/micdijkstra/stencil) modified to help you get started building HTML emails fast.

## The short version
+ Install required gems with `$ bundle`.
+ Run compiler tasks with `$ grunt`.
+ Maintain custom Sass in `sass/_base.sass` and `sass/_modules.sass`.
+ Copy CSS modules/plugins into `vendor` (they are prepended to your `application.css`).
+ Manage and edit your email files in `assets`, `templates` and `includes`.
+ When you’re done, run `$ grunt inline` to generate your final email file `_build/index-inline.html`.

## Dependencies

+ Bundler
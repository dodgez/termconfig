#lang scribble/manual
@require[@for-label[termconfig
                    racket/base]]

@title{termconfig}
@author{dodgez}

@defmodule[termconfig]

@section{Cross-platform terminal helper library in Racket}

This library currently supports unix and windows.
Mac OS is supported implicitly via posix compatibility.
Explicit testing is done one Ubuntu and development is done on Windows and WSL.

@section{Exported functions}
@itemlist[
@item{@racket{(enable-raw)} - Platform specifically enables raw (aka non-canonical) mode.}
@item{@racket{(disable-raw)} - Platform specifically disables raw mode.
This currently needs to be called after @racket{enable-raw} to restore the saved terminal state.}
@item{@racket{(with-raw expr*)} - evaluates the exprs in the context of raw mode (recommended approach).}
@item{@racket{(move-cursor-x x)}, @racket{(move-cursor-y y)}, and @racket{(move-cursor x y)} move the cursor relatively by @racket{x}, @racket{y}, or @racket{x} and @racket{y} respectively.}
@item{@racket{(set-cursor x y)} sets the cursor position to the @racket{x} column and @racket{y} row.}
@item{@racket{(show-cursor)} and @racket{(hide-cursor)} show and hide the cursor respectively.}
@item{@racket{(set-color-style #:fg-style fg-color #:bg-style bg-color)} sets the color style for the terminal going forward.
The foreground and background are optional keywords and colors are exported as @racket{fg-color}, @racket{bg-color}, @racket{fg-bright-color}, and @racket{bg-bright-color}.}
@item{@racket{(clear-screen)} clears the screen.}
]

@section{Roadmap}
To see more information, go to the issues and projects tabs in the GitHub repository as well as the current statuses.

@itemlist[
@item{[X] Raw mode}
@item{[X] Cursor movement}
@item{[X] Clear the terminal or a single cell}
@item{[X] Foreground and background colors}
@item{[ ] Retrieve input in raw mode (see next item)}
@item{[ ] Callbacks or polling for input?}
@item{[ ] Resize and cursor movement events}
@item{[ ] Better documentation}
@item{[ ] Better testing, including platform specific testing}
]

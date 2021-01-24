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
]

@section{Roadmap}
To see more information, go to the issues and projects tabs in the GitHub repository as well as the current statuses.

@itemlist[
@item{[X] Raw mode}
@item{[ ] Cursor movement}
@item{[ ] Clear the terminal or a single cell}
@item{[ ] Foreground and background colors}
@item{[ ] Retrieve input in raw mode (see next item)}
@item{[ ] Callbacks or polling for input}
@item{[ ] Resize and cursor movement events}
@item{[ ] Better documentation}
@item{[ ] Better testing, including platform specific testing}
]

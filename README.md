termconfig
=========
## Cross-platform terminal helper library in Racket

This library currently supports unix and windows.
Mac OS is supported implicitly via posix compatibility.
Explicit testing is done one Ubuntu and development is done on Windows _and_ WSL.

## Exported functions
- `(enable-raw)` - Platform specifically enables raw (aka non-canonical) mode.
- `(disable-raw)` - Platform specifically disables raw mode.
This currently needs to be called after `enable-raw` to restore the saved terminal state.
- `(with-raw expr*)` - evaluates the `expr`s in the context of raw mode (recommended approach).
- `(move-cursor-x x)`, `(move-cursor-y y)`, and `(move-cursor x y)` move the cursor relatively by `x`, `y`, or `x` and `y` respectively.
- `(set-cursor x y)` sets the cursor position to the `x` column and `y` row.
- `(show-cursor)` and `(hide-cursor)` show and hide the cursor respectively.
- `(set-color-style #:fg-style fg-{color} #:bg-style bg-{color})` sets the color style for the terminal going forward.
The foreground and background are optional keywords and colors are exported as `fg-color`, `bg-color`, `fg-bright-color`, and `bg-bright-color`.
- `(clear-screen)` clears the screen.

## Roadmap
To see more information, go to the issues and projects tabs in the GitHub repository as well as the current statuses.

- [X] Raw mode
- [X] Cursor movement
- [X] Clear the terminal or a single cell
- [X] Foreground and background colors
- [ ] Retrieve input in raw mode (see next item)
- [ ] Callbacks or polling for input?
- [ ] Resize and cursor movement events
- [ ] Better documentation
- [ ] Better testing, including platform specific testing

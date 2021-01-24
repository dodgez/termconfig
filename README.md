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

## Roadmap
To see more information, go to the issues and projects tabs in the GitHub repository as well as the current statuses.

- [X] Raw mode
- [ ] Cursor movement
- [ ] Retrieve input in raw mode (see next item)
- [ ] Callbacks or polling for input
- [ ] Resize and cursor movement events
- [ ] Better documentation
- [ ] Better testing, including platform specific testing

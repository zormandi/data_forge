# DataForge Changelog

In reverse chronological order:

## 0.1.2 (in progress)

* Added the `filter` transformation to filter records of a file source with a boolean-yielding block.
* Added the `archive` command to archive processed file sources.
* Added the `trash` command to delete obsolete (or temporary) file sources.

## 0.1.1

* Added file definition inheritance using the `file :second, like: :first do … end` directive.

## 0.1

Initial release with basic CSV file transformation functionality.

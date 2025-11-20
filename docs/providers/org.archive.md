# `org.archive`

`org.archive` is the identifier for the package provider of [the Internet Archive](https://archive.org).

This provider enables sourcing one or more files from items uploaded to IA.

## `instdat.item_name`

The name of the target item. This is part of the URL. For example, for the URL `https://archive.org/details/my-test-item`, the ID is `my-test-item`.

## `instdat.filemaps`

A table which contains mappings for files and the local file they will be placed in.

The key for each item in the table should correspond to the name of the file, and the value should be the local destination.

# `org.softwareheritage.archive`

`org.softwareheritage.archive` is the identifier for the package provider of [the Software Heritage Archive](https://archive.softwareheritage.org).

This provider enables sourcing one or more files based on SWHIDs.

:::{admonition} This provider is very slow!
:class: warning

Internally, this provider uses a GraphQL query to get the file contents,
which requires server processing time.
Expect delays of about five seconds when using this provider.

**Consider mirroring the code onto another platform if many people will be using this package.**
:::

## `instdat.filemaps`

A table which contains mappings for SWHIDs and the local file they will be placed in.

The key for each item in the table should correspond to the [SWHID of **the file**](https://www.swhid.org/swhid-specification/v1.2/5.Core_identifiers/#52-contents) (starting with `swh:1:cnt:`), and the value should be the local destination. Other SWHID object types are not supported.

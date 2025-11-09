# `com.github.gist`

`com.github.gist` is the identifier for the package provider of [GitHub Gists](https://gists.github.com).

This provider enables sourcing files from a GitHub Gist.

:::{admonition} Why is there a `repo_ref` field?
:class: tip

GitHub Gists [are technically Git repositories](https://docs.github.com/en/get-started/writing-on-github/editing-and-sharing-content-with-gists/creating-gists#:~:text=Every%20gist%20is%20a%20Git%20repository), so `instdat` uses the same field names as the providers for other Git forges.
:::

## `instdat.repo_owner`

The owner of the target Gist.

## `instdat.repo_name`

The identifier of the target Gist. (This is named this way for consistency with [com.github](./com.github.md) and because Gists are technically repositories.)

## `instdat.repo_ref`

The [Git reference](https://git-scm.com/book/en/v2/Git-Internals-Git-References) (a commit) of the target repository.

This can be determined by clicking the "raw" button on any file in the Gist. The commit identifier is the second hexadecimal string in the URL.

## `instdat.filemaps`

A table which contains mappings for files on GitHub and their local counterparts.

The key for each item in the table should correspond to the full path on the GitHub Gist, and the value should be the local destination.

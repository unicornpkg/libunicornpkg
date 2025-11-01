# `org.bitbucket`

`org.bitbucket` is the identifier for the package provider of [Bitbucket](https://bitbucket.org).

This provider enables sourcing individual files from a Bitbucket repository.

## `instdat.repo_owner`

The owner of the target repository.

## `instdat.repo_name`

The name of the target repository.

## `instdat.repo_ref`

The [Git reference](https://git-scm.com/book/en/v2/Git-Internals-Git-References) (a tag, branch, or commit) of the target repository.


## `instdat.filemaps`

A table which contains mappings for files on Bitbucket and their local counterparts.

The key for each item in the table should correspond to the full path on the Bitbucket repository, and the value should be the local destination.


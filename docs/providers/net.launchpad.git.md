# `net.launchpad.git`

`net.launchpad.git` is the identifier for the package provider of the [Launchpad](https://launchpad.net) code forge.

This provider enables sourcing individual files from a GitLab repository.

## `instdat.launchpad_instance`

The domain of the Launchpad Git server. This defaults to `git.launchpad.net`.

## `instdat.repo_name`

The name of the target repository.

## `instdat.repo_ref`

The [Git reference](https://git-scm.com/book/en/v2/Git-Internals-Git-References) (a tag, branch, or commit) of the target repository.

## `instdat.filemaps`

A table which contains mappings for files on GitLab and their local counterparts.

The key for each item in the table should correspond to the full path on the Launchpad repository, and the value should be the local destination.

# `com.github.release`

`com.github.release` is the identifier for the package provider of [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases).

This provider enables sourcing artifacts from GitHub Releases.

## `instdat.repo_owner`

The owner of the target repository.

## `instdat.repo_name`

The name of the target repository.

## `instdat.repo_ref`

The Git tag associated with the release.

## `instdat.filemaps`

A table which contains mappings for artifacts on the GitHub release and their local counterparts.

The key for each item in the table should correspond to the full name on the GitHub release, and the value should be the local destination.


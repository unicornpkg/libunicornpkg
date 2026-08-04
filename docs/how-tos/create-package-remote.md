# How to create a package remote

Package remotes, analogous to package repositories in other package managers, make packages available from the web. This how-to will show you how to create a package remote using GitHub.

This guide assumes you have [a free GitHub account](https://github.com/signup) and an [installation of unicornpkg](./installation.md).

1. Create a repository on GitHub. We recommend starting the repository's name with `unicornpkg-***`, but this is not required. (We also recommend adding the `unicornpkg-remote` topic to your repository, but this is also not required.)
2. Add and commit your packages into the root of the repository. The filenames should be the same as the package's `name` field and must end with `.lua`.
3. In `/etc/unicorn/remotes/40_your_remote_name.txt`, create a new file containing `https://raw.githubusercontent.com/[name]/[repo]/[branch]/` replacing: 
    * `[name]` with your username, 
    * `[repo]` with your repository's name, and 
    * `[branch]` with your repository's main branch.
4. At this point, your package remote is done. Try installing from it with `hoof install a-package-in-my-repo`.

:::{tip}
If you're not fond of GitHub, don't fret! Package remotes can be hosted anywhere you can host static files.
:::

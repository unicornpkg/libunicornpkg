# How to create a package remote

Package remotes are simple text files made available on the web. This how-to will allow you to create a package repository with GitHub.

This guide assumes you have Git installed locally, a GitHub account, and Git configured to work with GitHub.

1. Create a repository on GitHub. The convention is to name the repository `unicornpkg-***`, but this is not required. (We also recommend adding the `unicornpkg-remote` topic to your repository, but this is also not required.)
2. Add and commit your package tables into the root of the repository.
3. Add this string to your ComputerCraft computer in `/etc/unicorn/remotes/40_your_remote_name.txt`, replacing `[name]` with your username, `[repo]` with your repository's name, and `[branch]` with your repository's main branch: `https://raw.githubusercontent.com/[name]/[repo]/[branch]/"`.
4. At this point, your package remote is done. Try installing from it with `hoof install a-package-in-my-repo`.

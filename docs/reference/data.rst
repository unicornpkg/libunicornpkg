The database and other configuration
====================================

Database
--------

The :func:`unicorn.core.install` function interacts with files in
``/etc/unicorn/packages/installed``, which are serialized with the
``textutils.serialise`` function. They can be inspected as a text file.

Configuring remotes
-------------------
The :func:`unicorn.remote.install` function reads remotes from the following directories, in order of priority:

1. `/etc/unicorn/remotes`
2. `/rom/config/unicorn/remotes`

Remotes with the same name that appear in both directories will be overriden by the remote in the higher-priority directory.


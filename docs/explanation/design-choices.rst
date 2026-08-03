Design choices
--------------

unicornpkg is a fairly opinionated piece of software.
This section explains why certain decisions were made.

Why are packages Lua and not a new DSL/JSON/YAML/TOML/etc.?
===========================================================

Portability
^^^^^^^^^^^

All versions of ComputerCraft can evaluate Lua out-of-the-box.
JSON support wasn't added to CC:T [until 1.7](https://tweaked.cc/module/textutils.html#v:serializeJSON).

Lintable
^^^^^^^^

There's tons of tooling for formatting and linting Lua and most common configuration formats.
A domain-specific language for unicornpkg would not be able to take advantage of this pre-existing ecosystem.

Syntax
^^^^^^

At least compared to JSON, Lua supports variables and comments. [1]_

Variables are very important because they help keep the code DRY, making package updates easier.
Consider this example:

.. code-block:: lua

    local thisPackage = {}
    thisPackage.name = "ccryptolib"
    thisPackage.desc = "A collection of cryptographic primitives for CC:Tweaked"
    thisPackage.version = "1.3.0"
    thisPackage.instdat = {}
    thisPackage.instdat.repo_owner = "migeyel"
    thisPackage.instdat.repo_name = "ccryptolib"
    thisPackage.instdat.repo_ref = "v" .. package.version
    thisPackage.instdat.filemaps = {}
    -- etc.

We use variables here to avoid repeating the version number, which marginally simplifies updates.

Comments are useful for explaining potentially-confusing lines of code.

.. [1] JSON5 supports comments, but CC:T doesn't appear to support it.

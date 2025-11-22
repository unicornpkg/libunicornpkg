Debugging
=========

Debug logs
----------

Very verbose debug logs can be enabled by setting
``_G.UNICORN_DEBUG_DO_NOT_USE_IN_PRODUCTION_CODE`` to ``1``.

**This interface should not be assumed to be stable.**

Inspecting database state
-------------------------

The :func:`unicorn.core.install` function interacts with files in
``/etc/unicorn/packages/installed``, which are serialized with the
``textutils.serialise`` function. They can be inspected as a text file.

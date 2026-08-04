# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import os
import re

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = "libunicornpkg"
copyright = "2025, Tomodachi94"
author = "Tomodachi94"
release = version = re.sub(
    "^v", "", os.popen('git describe --tags --match "v*"').read().strip()
)

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ["myst_parser", "sphinx_lua_ls", "sphinxext.rediraffe"]

templates_path = ["_templates"]
exclude_patterns = [".venv"]

primary_domain = "lua"
default_role = "lua:obj"
highlight_language = "lua"

# -- Theme configuration -----------------------------------------------------

html_sidebars = {
    "**": [
        "about.html",
        "searchfield.html",
        "navigation.html",
        "relations.html",
        "donate.html",
    ]
}

html_theme_options = {
    "extra_nav_links": {
        "Report a problem": "https://github.com/unicornpkg/libunicornpkg/issues/new?template=bug_report.md",
        "Suggest a feature": "https://github.com/unicornpkg/libunicornpkg/issues/new?template=feature_request.md",
        "Join our Discord": "https://discord.gg/Xs3VKNJrMb",
        "Default package repository": "https://github.com/unicornpkg/unicornpkg-main",
    },
    "github_user": "unicornpkg",
    "github_repo": "libunicornpkg",
    "github_banner": True,
}

# -- MyST configuration ------------------------------------------------------
# https://myst-parser.readthedocs.io/en/latest/configuration.html

myst_enable_extensions = ["colon_fence"]

# -- rediraffe configuration -------------------------------------------------

rediraffe_redirects = {
    "providers/com.github.releases.md": "providers/com.github.release.md",
    "providers/dev.devbin.md": "changelog.md",
    "api/index.rst": "reference/api/index.rst",
    "api/unicorn.core.rst": "reference/api/unicorn.core.rst",
    "api/unicorn.remote.rst": "reference/api/unicorn.remote.rst",
    "api/unicorn.util.rst": "reference/api/unicorn.util.rst",
    "api/unicorn.util.logging.rst": "reference/api/unicorn.util.logging.rst",
    "cli/changelog.md": "reference/cli/changelog.md",
    "cli/hoof.md": "reference/cli/hoof.md",
    "cli/index.rst": "reference/cli/index.rst",
    "cli/unicorntool.md": "reference/cli/unicorntool.md",
    "extras/etc-startup.md": "reference/extras/etc-startup.md",
    "extras/index.rst": "reference/extras/index.rst",
    "extras/unix-path-bootstrap.md": "reference/extras/unix-path-bootstrap.md",
    "providers/com.github.gist.md": "reference/providers/com.github.gist.md",
    "providers/com.github.md": "reference/providers/com.github.md",
    "providers/com.github.release.md": "reference/providers/com.github.release.md",
    "providers/com.gitlab.md": "reference/providers/com.gitlab.md",
    "providers/com.pastebin.md": "reference/providers/com.pastebin.md",
    "providers/ht.sr.md": "reference/providers/ht.sr.md",
    "providers/index.rst": "reference/providers/index.rst",
    "providers/io.sc3.p.md": "reference/providers/io.sc3.p.md",
    "providers/local.generic.md": "reference/providers/local.generic.md",
    "providers/local.nothing.md": "reference/providers/local.nothing.md",
    "providers/local.string.md": "reference/providers/local.string.md",
    "providers/net.launchpad.git.md": "reference/providers/net.launchpad.git.md",
    "providers/org.archive.md": "reference/providers/org.archive.md",
    "providers/org.bitbucket.md": "reference/providers/org.bitbucket.md",
    "providers/org.codeberg.md": "reference/providers/org.codeberg.md",
    "providers/org.softwareheritage.archive.md": "reference/providers/org.softwareheritage.archive.md",
    "information-for-websites.md": "explanation/information-for-websites.md",
}

# -- sphinx-lua-ls configuration ---------------------------------------------

lua_ls_project_root = ".."
lua_ls_backend = "luals"
lua_ls_apidoc_default_options = {
    "undoc-members": "",
    "protected-members": "",
    "globals": "",
}
lua_ls_apidoc_roots = {
    "unicorn": "reference/api",
}

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "alabaster"
html_static_path = ["_static"]

html_js_files = [
    (
        "//gc.zgo.at/count.js",
        {
            "async": "async",
            "data-goatcounter": "https://unicornpkg.goatcounter.com/count",
        },
    )
]

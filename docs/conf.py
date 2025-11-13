# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = "libunicornpkg"
copyright = "2025, Tomodachi94"
author = "Tomodachi94"
release = "1.3.1"

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
        "Installation guide": "https://unicornpkg.madefor.cc/how-tos/installation.html",
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
    "unicorn": "api",
}

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "alabaster"
html_static_path = ["_static"]

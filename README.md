# quentinmale.github.io

Personal academic website, built with [Jekyll](https://jekyllrb.com/) and the [Just the Docs](https://github.com/just-the-docs/just-the-docs) theme (loaded via `remote_theme`, so GitHub Pages builds it automatically — no GitHub Actions needed).

## Structure

```
_config.yml            Site settings, theme config, nav/search options
Gemfile                 Ruby gems needed to preview the site locally

index.md                Home page (uses layout: home)
publications.md         Publications page
codes.md                Codes page
data.md                 Data page
teaching.md             Teaching page
student-projects.md     Student projects page
gallery.md              Gallery page

research/
  index.md              "Research" parent page (top-level nav item)
  machine-learning.md    Child page (single topic, no further nesting)
  pac.md                 Child page, itself has children (has_children: true)
  pac/
    thermoacoustic-stabilization.md   Grandchild page
    combustion-enhancement.md         Grandchild page
    nox-chemistry.md                  Grandchild page
  hydrogen-combustion.md
  hydrogen-enrichment.md              Child page, has children
  hydrogen-enrichment/
    sequential-combustors.md
    prechamber-ignition-engines.md
  turbulent-jet-ignition.md           Child page, has children
  turbulent-jet-ignition/
    general-purpose.md
    prechamber-ignition-engines.md

assets/
  data/*.cti *.f90         Chemical mechanism files linked from data.md
  images/home/             Homepage images
  images/logos/            Funding-agency logos
  images/research/         Figures used across research pages
  images/codes/             Figures used in codes.md / research pages
  images/gallery/          Gallery images and video
```

The left sidebar is generated automatically by Just the Docs from each page's front matter — there's no manually maintained nav file.

## How the sidebar hierarchy works

Every content page starts with a YAML front matter block. The three keys that control where a page sits in the sidebar are:

- `title` — the text shown in the sidebar and at the top of the page.
- `parent` — the exact `title` of the page one level up. Omit this for a top-level page (e.g. Research, Publications).
- `grand_parent` — only needed for a third-level (grandchild) page. Must match the `title` of the top-level page, while `parent` matches the immediate parent's `title`.
- `has_children: true` — set this on any page that itself has children, so Just the Docs turns it into an expandable section.
- `nav_order` — an integer controlling the order pages appear in among their siblings.
- `permalink` — the clean URL for the page, e.g. `/research/pac/nox-chemistry/`.

Example — a grandchild page:

```yaml
---
title: Nitrogen oxides chemistry
parent: Plasma-Assisted Combustion (PAC)
grand_parent: Research
nav_order: 3
permalink: /research/pac/nox-chemistry/
---
```

Every content page (except `index.md`, which sets `layout: home`) inherits `layout: default` automatically from the `defaults:` block at the bottom of `_config.yml` — you don't need to add `layout:` yourself.

## Adding a new page

**A new top-level section** (like "Research" or "Publications"):
1. Create `my-section.md` in the repo root.
2. Add front matter with `title`, `nav_order`, and `permalink: /my-section/`.
3. Write the content below the front matter in normal Markdown.

**A new topic under Research** (a child page):
1. Create `research/my-topic.md`.
2. Front matter: `title`, `parent: Research`, `nav_order`, `permalink: /research/my-topic/`.
3. If this topic will itself have subtopics, also add `has_children: true`, and list them in the body as a bullet list of links (see `research/pac.md` for an example).

**A new subtopic** (a grandchild page, e.g. a new subsection under PAC):
1. Create `research/pac/my-subtopic.md` (i.e. inside the parent topic's own folder).
2. Front matter: `title`, `parent: Plasma-Assisted Combustion (PAC)`, `grand_parent: Research`, `nav_order`, `permalink: /research/pac/my-subtopic/`.
3. Add a link to it from `research/pac.md`'s bullet list so it's discoverable from the parent page's body too (the sidebar will pick it up automatically regardless).

**Images, PDFs, or other files**: drop them in the relevant `assets/` subfolder (or create a new one) and reference them with an absolute path, e.g. `/assets/images/research/my-figure.png`.

## Previewing the site locally on macOS

The very first time only:

```bash
brew install ruby
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc   # Apple Silicon
# echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc   # Intel Mac
source ~/.zshrc

cd /path/to/quentinmale.github.io
gem install bundler
bundle install
```

Every time you want to preview changes:

```bash
cd /path/to/quentinmale.github.io
bundle exec jekyll serve --livereload
```

Then open **http://127.0.0.1:4000** in your browser. The page auto-reloads whenever you save a file. Stop the server with `Ctrl+C`.

If you only change `_config.yml`, you need to stop and restart the server — livereload doesn't pick up config changes automatically.

You'll see a lot of "Sass @import / darken() deprecated" warnings in the terminal — these come from the theme's own stylesheets and Dart Sass being ahead of them. They're harmless and don't affect the site.

### Alternative: Docker (no Ruby install needed)

```bash
cd /path/to/quentinmale.github.io
docker run --rm -it -v "$PWD":/srv/jekyll -v "$PWD/vendor/bundle":/usr/local/bundle -p 4000:4000 jekyll/jekyll:latest jekyll serve --livereload
```

## Publishing

Commit and push to `main`. GitHub Pages rebuilds the site automatically (Settings → Pages should already be set to "Deploy from a branch: main / root" from before — no changes needed there).

Do **not** commit `_site/`, `.jekyll-cache/`, `.bundle/`, or `Gemfile.lock` — these are local build artifacts and are already listed in `.gitignore`.

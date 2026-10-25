# JuliaActuary Documentation

Unified documentation portal for JuliaActuary packages, hosted at [docs.juliaactuary.org](https://docs.juliaactuary.org).

This repo uses [MultiDocumenter.jl](https://github.com/JuliaComputing/MultiDocumenter.jl) to aggregate documentation from all core JuliaActuary packages into a single site with global navigation and search.

## Included Packages

- [MortalityTables.jl](https://github.com/JuliaActuary/MortalityTables.jl)
- [LifeContingencies.jl](https://github.com/JuliaActuary/LifeContingencies.jl)
- [ActuaryUtilities.jl](https://github.com/JuliaActuary/ActuaryUtilities.jl)
- [FinanceModels.jl](https://github.com/JuliaActuary/FinanceModels.jl)
- [FinanceCore.jl](https://github.com/JuliaActuary/FinanceCore.jl)
- [EconomicScenarioGenerators.jl](https://github.com/JuliaActuary/EconomicScenarioGenerators.jl)
- [ExperienceAnalysis.jl](https://github.com/JuliaActuary/ExperienceAnalysis.jl)

## How It Works

The GitHub Actions workflow (`deploy.yml`) runs every 12 hours and on push to `main`:

1. Clones each package's `gh-pages` branch
2. Aggregates them with MultiDocumenter.jl (adding global nav and search)
3. Deploys the result to `gh-pages`

## DNS Setup

A CNAME record must point `docs.juliaactuary.org` to `juliaactuary.github.io`. GitHub Pages is configured with the custom domain and HTTPS enforcement.

## Theme and local preview

`docs/assets/cassette.css` applies the JuliaActuary paper/navy palette, local
Inter body text, bold Atkinson Hyperlegible headings, and local JuliaMono code
fonts to every package. Prose uses a 64ch measure and 1.75 line spacing; inline
identifiers have quieter styling, while wide code blocks, plots, and tables
keep their available width.
Documenter's navigation, theme picker, and cassette dark mode remain available;
the optional Catppuccin palettes keep their native colors. Landing-page layout
is defined in `docs/make.jl`.

Edit `cassette.css` normally. `docs/theme.jl` generates a content-hashed stylesheet
name on each build, so readers receive theme changes without clearing their
browser cache. It also removes upstream Lato/JuliaMono CDN stylesheets; icons,
math fonts, and syntax highlighting remain supplied by each package.

`docs/assets/webfonts/` contains a pinned Inter 3.019 variable font for body
text, covering weights 400–700 and oblique styles, plus regular/bold JuliaMono
subsets with symbols for Julia identifiers, math, and UnicodePlots output.
Fonts use `font-display: swap`; system fonts are the body fallback. The font
licenses are included alongside the files.

Regenerate these subsets with `fonttools[woff]` installed, using the upstream
`Inter-Variable.ttf`, `JuliaMono-Regular.woff2`, and `JuliaMono-Bold.woff2` files
(all available in the main website repo):

```sh
python3 scripts/subset-fonts.py ../JuliaActuary.org/assets/webfonts
```

Keep shared brand typography and palette changes in sync between the two repos.

Build a preview without deploying (the first build downloads the package docs):

```sh
julia --project=docs -e 'using Pkg; Pkg.instantiate()'
julia --project=docs -e 'include("docs/make.jl"); cp(outpath, "preview"; force=true)'
python3 -m http.server 8766 --directory preview
```

Open <http://localhost:8766>. `preview/` is generated output and should not be
committed. Run the theme build checks with
`julia --project=docs test/runtests.jl`.

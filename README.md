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

The GitHub Actions workflow (`deploy.yml`) runs weekly and on push to `main`:

1. Clones each package's `gh-pages` branch
2. Aggregates them with MultiDocumenter.jl (adding global nav and search)
3. Deploys the result to `gh-pages`

## DNS Setup

A CNAME record must point `docs.juliaactuary.org` to `juliaactuary.github.io`. GitHub Pages is configured with the custom domain and HTTPS enforcement.

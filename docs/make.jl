using MultiDocumenter

clonedir = mktempdir()
outpath  = mktempdir()

docs = [
    MultiDocumenter.MultiDocRef(
        upstream = joinpath(clonedir, "MortalityTables"),
        path     = "MortalityTables",
        name     = "MortalityTables",
        giturl   = "https://github.com/JuliaActuary/MortalityTables.jl.git",
    ),
    MultiDocumenter.MultiDocRef(
        upstream = joinpath(clonedir, "LifeContingencies"),
        path     = "LifeContingencies",
        name     = "LifeContingencies",
        giturl   = "https://github.com/JuliaActuary/LifeContingencies.jl.git",
    ),
    MultiDocumenter.MultiDocRef(
        upstream = joinpath(clonedir, "ActuaryUtilities"),
        path     = "ActuaryUtilities",
        name     = "ActuaryUtilities",
        giturl   = "https://github.com/JuliaActuary/ActuaryUtilities.jl.git",
    ),
    MultiDocumenter.MultiDocRef(
        upstream = joinpath(clonedir, "FinanceModels"),
        path     = "FinanceModels",
        name     = "FinanceModels",
        giturl   = "https://github.com/JuliaActuary/FinanceModels.jl.git",
    ),
    MultiDocumenter.MultiDocRef(
        upstream = joinpath(clonedir, "FinanceCore"),
        path     = "FinanceCore",
        name     = "FinanceCore",
        giturl   = "https://github.com/JuliaActuary/FinanceCore.jl.git",
    ),
    MultiDocumenter.MultiDocRef(
        upstream = joinpath(clonedir, "EconomicScenarioGenerators"),
        path     = "EconomicScenarioGenerators",
        name     = "EconomicScenarioGenerators",
        giturl   = "https://github.com/JuliaActuary/EconomicScenarioGenerators.jl.git",
    ),
    MultiDocumenter.MultiDocRef(
        upstream = joinpath(clonedir, "ExperienceAnalysis"),
        path     = "ExperienceAnalysis",
        name     = "ExperienceAnalysis",
        giturl   = "https://github.com/JuliaActuary/ExperienceAnalysis.jl.git",
    ),
]

MultiDocumenter.make(
    outpath,
    docs;
    search_engine = MultiDocumenter.SearchConfig(
        index_versions = ["stable"],
        engine = MultiDocumenter.PageFind,
    ),
    rootpath         = "/",
    canonical_domain = "https://docs.juliaactuary.org",
    sitemap          = true,
)

# Deploy to gh-pages
if "deploy" in ARGS
    gitroot = normpath(joinpath(@__DIR__, ".."))
    run(`git pull`)
    outbranch = "gh-pages"
    has_outbranch = true
    if !success(`git checkout $outbranch`)
        has_outbranch = false
        if !success(`git switch --orphan $outbranch`)
            @error "Cannot create new orphaned branch $outbranch."
            exit(1)
        end
    end
    for file in readdir(gitroot; join = true)
        endswith(file, ".git") && continue
        rm(file; force = true, recursive = true)
    end
    for file in readdir(outpath)
        cp(joinpath(outpath, file), joinpath(gitroot, file))
    end
    # CNAME for custom domain
    write(joinpath(gitroot, "CNAME"), "docs.juliaactuary.org")
    run(`git add .`)
    if success(`git commit -m 'Aggregate documentation'`)
        if has_outbranch
            run(`git push`)
        else
            run(`git push -u origin $outbranch`)
        end
        run(`git checkout main`)
    else
        @info "No changes to aggregated documentation."
    end
end

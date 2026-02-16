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

# Custom landing page (replaces the auto-generated redirect)
landing_page = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuliaActuary Documentation</title>
    <link rel="canonical" href="https://docs.juliaactuary.org/" />
    <style>
        :root {
            --primary: #4054b2;
            --primary-light: #4c63d2;
            --bg: #fff;
            --text: #24292e;
            --text-light: #586069;
            --card-border: #e1e4e8;
            --card-hover: #f6f8fa;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            color: var(--text);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        header {
            background: var(--primary);
            color: #fff;
            padding: 2.5rem 1rem;
            text-align: center;
        }
        header h1 { font-size: 2rem; font-weight: 700; margin-bottom: 0.5rem; }
        header p { font-size: 1.1rem; opacity: 0.9; max-width: 600px; margin: 0 auto; }
        main { max-width: 900px; margin: 2rem auto; padding: 0 1rem; flex: 1; width: 100%; }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 1rem;
            margin: 1.5rem 0 2rem;
        }
        .card {
            border: 1px solid var(--card-border);
            border-radius: 6px;
            padding: 1.25rem;
            text-decoration: none;
            color: var(--text);
            transition: background 0.15s, border-color 0.15s;
            display: block;
        }
        .card:hover { background: var(--card-hover); border-color: var(--primary-light); }
        .card h2 { font-size: 1rem; color: var(--primary); margin-bottom: 0.35rem; }
        .card p { font-size: 0.875rem; color: var(--text-light); }
        .back-link {
            text-align: center;
            margin: 1rem 0 2rem;
        }
        .back-link a {
            color: var(--primary);
            font-weight: 500;
            text-decoration: none;
        }
        .back-link a:hover { text-decoration: underline; }
        footer {
            text-align: center;
            padding: 1.5rem 1rem;
            font-size: 0.8rem;
            color: var(--text-light);
            border-top: 1px solid var(--card-border);
        }
    </style>
</head>
<body>
    <header>
        <h1>JuliaActuary Documentation</h1>
        <p>Unified documentation for the JuliaActuary open-source actuarial modeling ecosystem.</p>
    </header>
    <main>
        <div class="grid">
            <a class="card" href="MortalityTables/stable/">
                <h2>MortalityTables.jl</h2>
                <p>Mortality table access and survival calculations</p>
            </a>
            <a class="card" href="LifeContingencies/stable/">
                <h2>LifeContingencies.jl</h2>
                <p>Insurance, annuity, and reserve mathematics</p>
            </a>
            <a class="card" href="ActuaryUtilities/stable/">
                <h2>ActuaryUtilities.jl</h2>
                <p>Financial math: IRR, duration, convexity, present value</p>
            </a>
            <a class="card" href="FinanceModels/stable/">
                <h2>FinanceModels.jl</h2>
                <p>Composable yield curve and financial models</p>
            </a>
            <a class="card" href="FinanceCore/stable/">
                <h2>FinanceCore.jl</h2>
                <p>Core financial types and interfaces</p>
            </a>
            <a class="card" href="EconomicScenarioGenerators/stable/">
                <h2>EconomicScenarioGenerators.jl</h2>
                <p>Interest rate and equity scenario generation</p>
            </a>
            <a class="card" href="ExperienceAnalysis/stable/">
                <h2>ExperienceAnalysis.jl</h2>
                <p>Actuarial exposure calculations</p>
            </a>
        </div>
        <div class="back-link">
            <a href="https://juliaactuary.org">&#8592; Back to JuliaActuary.org</a>
        </div>
    </main>
    <footer>
        Built with <a href="https://github.com/JuliaComputing/MultiDocumenter.jl" style="color: inherit; text-decoration: underline;">MultiDocumenter.jl</a>
    </footer>
</body>
</html>
"""
write(joinpath(outpath, "index.html"), landing_page)

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

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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --julia-red: #CB3C33;
            --julia-purple: #9558B2;
            --primary: #9558B2;
            --primary-light: #a76bc4;
            --bg: #fff;
            --text: #24292e;
            --text-light: #586069;
            --card-border: #e1e4e8;
            --card-hover: #f6f8fa;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            color: var(--text);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        header {
            background: linear-gradient(-45deg, var(--julia-red), var(--julia-purple) 100%);
            background-size: 300% 300%;
            animation: AnimateBG 40s ease infinite;
            color: azure;
            padding: 2.5rem 1rem 2rem;
            text-align: center;
        }
        @keyframes AnimateBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .logo { width: 80px; height: 80px; margin-bottom: 0.75rem; }
        header h1 { font-size: 2rem; font-weight: 700; margin-bottom: 0.5rem; }
        header p { font-size: 1.1rem; opacity: 0.92; max-width: 600px; margin: 0 auto; }
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
        /* Search bar in header */
        #search-container {
            position: relative;
            display: inline-block;
            margin-top: 1.25rem;
        }
        #search-container #search-input {
            width: min(28em, 80vw);
            height: 40px;
            padding: 0 12px;
            font-size: 1rem;
            font-family: inherit;
            border: 2px solid rgba(255,255,255,0.4);
            border-radius: 6px;
            background: rgba(255,255,255,0.15);
            color: #fff;
            outline: none;
            transition: background 0.15s, border-color 0.15s;
        }
        #search-container #search-input::placeholder { color: rgba(255,255,255,0.7); }
        #search-container #search-input:focus {
            background: #fff;
            color: var(--text);
            border-color: #fff;
        }
        #search-container #search-input:focus::placeholder { color: #999; }
        #search-container .search-keybinding {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255,255,255,0.5);
            font-size: 0.85rem;
            pointer-events: none;
        }
        #search-container:focus-within .search-keybinding { display: none; }
        /* Search results dropdown */
        #search-container .suggestions {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            margin-top: 4px;
            background: #fff;
            border: 1px solid var(--card-border);
            border-radius: 6px;
            padding: 0.4rem;
            list-style: none;
            z-index: 100;
            max-height: max(50vh, 300px);
            overflow-y: auto;
            text-align: left;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        #search-container:focus-within .suggestions { display: block; }
        #search-container .suggestions.hidden { display: none !important; }
        #search-container .suggestions mark { background-color: #fff3b0; color: #000; }
        #search-container .suggestion { line-height: 1.3; border-radius: 4px; overflow: hidden; text-overflow: ellipsis; }
        #search-container .sub-suggestions { list-style: none; padding: 0; }
        #search-container .sub-suggestions .suggestion { margin-left: 1rem; }
        #search-container .suggestion-header {
            padding: 0.4rem 0.6rem;
            display: block;
            color: var(--text);
            text-decoration: none;
        }
        #search-container .suggestion-header:hover,
        #search-container .suggestion-header:focus { background: var(--card-hover); outline: none; }
        #search-container .suggestion .suggestion-title { font-size: 1rem; font-weight: 600; }
        #search-container .suggestion .suggestion-excerpt { font-size: 0.85rem; color: var(--text-light); margin-top: 2px; }
        #search-container .sub-suggestions .suggestion-title { font-size: 0.9rem; }
    </style>
</head>
<body>
    <header>
        <svg class="logo" viewBox="0 0 250 250" xmlns="http://www.w3.org/2000/svg" aria-label="JuliaActuary logo">
            <path fill="#CB3C33" d="M 110 30 C 110 43.808594 98.808594 55 85 55 C 71.191406 55 60 43.808594 60 30 C 60 16.191406 71.191406 5 85 5 C 98.808594 5 110 16.191406 110 30"/>
            <path fill="#9558B2" d="M 185 30 C 185 43.808594 173.808594 55 160 55 C 146.191406 55 135 43.808594 135 30 C 135 16.191406 146.191406 5 160 5 C 173.808594 5 185 16.191406 185 30"/>
            <path fill="white" d="M 102.300781 229.199219 C 88.695313 229.195313 77.847656 225.449219 69.75 217.949219 C 61.648438 210.453125 57.597656 200.300781 57.601563 187.5 C 57.597656 175.300781 60.945313 165.851563 67.648438 159.152344 C 74.34375 152.453125 83.996094 147.605469 96.597656 144.601563 C 109.199219 141.605469 124.5 139.703125 142.5 138.898438 L 142.5 117 C 142.5 106.203125 140.398438 98.355469 136.199219 93.453125 C 131.996094 88.554688 125.394531 86.105469 116.398438 86.101563 C 111.59375 86.105469 106.894531 86.804688 102.296875 88.203125 C 97.695313 89.605469 93.796875 91.605469 90.601563 94.199219 C 95.597656 102.804688 98.097656 108.402344 98.101563 111 C 98.097656 115.601563 96.246094 119.304688 92.550781 122.101563 C 88.847656 124.90625 84 126.304688 78 126.300781 C 72 126.304688 67.296875 124.753906 63.898438 121.652344 C 60.496094 118.550781 58.796875 114.101563 58.800781 108.300781 C 58.796875 101.101563 61.699219 94.402344 67.5 88.199219 C 73.296875 82.003906 80.945313 77.003906 90.449219 73.199219 C 99.945313 69.402344 110.195313 67.5 121.199219 67.5 C 141.398438 67.5 156.199219 72.152344 165.597656 81.449219 C 174.996094 90.753906 179.695313 105.203125 179.699219 124.800781 L 179.699219 192.300781 C 179.695313 201.304688 183.796875 205.804688 192 205.800781 C 193.796875 205.804688 195.746094 205.605469 197.847656 205.203125 C 199.949219 204.804688 202.398438 204.203125 205.199219 203.398438 L 208.800781 216.898438 C 204.597656 220.703125 199.648438 223.699219 193.949219 225.898438 C 188.246094 228.09375 182.496094 229.195313 176.699219 229.199219 C 168.898438 229.195313 162.5 227.046875 157.5 222.75 C 152.5 218.453125 149.199219 212.40625 147.601563 204.601563 C 137.199219 221 122.097656 229.195313 102.300781 229.199219 Z M 117 204.601563 C 125 204.605469 131.25 202.152344 135.75 197.25 C 140.25 192.351563 142.5 185.703125 142.5 177.300781 L 142.5 156.601563 C 127.699219 156.605469 116.246094 158.605469 108.148438 162.601563 C 100.046875 166.605469 96 173.503906 96 183.300781 C 96 189.902344 97.847656 195.101563 101.550781 198.902344 C 105.246094 202.703125 110.398438 204.605469 117 204.601563 Z M 210 225"/>
        </svg>
        <h1>JuliaActuary Documentation</h1>
        <p>Unified documentation for the JuliaActuary open-source actuarial modeling ecosystem.</p>
        <div id="search-container">
            <input id="search-input" placeholder="Search all packages..." autocomplete="off">
            <ol id="search-result-container" class="suggestions hidden"></ol>
            <div class="search-keybinding">/</div>
        </div>
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
    <script>window.MULTIDOCUMENTER_ROOT_PATH = '/';</script>
    <script type="module">
    const MAX_RESULTS = 20;
    let FOCUSABLE_ELEMENTS = [];
    let FOCUSED_ELEMENT_INDEX = -1;

    const pagefind = await import(window.MULTIDOCUMENTER_ROOT_PATH + "pagefind/pagefind.js");

    function initialize() {
        pagefind.init();
        registerSearchListener();
        document.body.addEventListener('keydown', ev => {
            if (document.activeElement === document.body && (ev.key === '/' || ev.key === 's')) {
                document.getElementById('search-input').focus();
                ev.preventDefault();
            }
        });
    }

    function registerSearchListener() {
        const input = document.getElementById('search-input');
        const suggestions = document.getElementById('search-result-container');

        // Prevent mousedown inside the results from stealing focus away from
        // the input, which would hide the :focus-within dropdown before the
        // click event can fire and navigate.
        suggestions.addEventListener('mousedown', ev => { ev.preventDefault(); });

        async function runSearch() {
            const query = input.value;
            const search = await pagefind.debouncedSearch(query, {}, 300);
            if (search) { buildResults(search.results); }
        }

        input.addEventListener('keyup', ev => { runSearch(); });

        input.addEventListener('keydown', ev => {
            if (ev.key === 'ArrowDown') {
                FOCUSED_ELEMENT_INDEX = 0;
                if (FOCUSABLE_ELEMENTS.length > 0) FOCUSABLE_ELEMENTS[0].focus();
                ev.preventDefault();
            } else if (ev.key === 'ArrowUp') {
                FOCUSED_ELEMENT_INDEX = FOCUSABLE_ELEMENTS.length - 1;
                if (FOCUSABLE_ELEMENTS.length > 0) FOCUSABLE_ELEMENTS[FOCUSED_ELEMENT_INDEX].focus();
                ev.preventDefault();
            }
        });

        suggestions.addEventListener('keydown', ev => {
            if (ev.key === 'ArrowDown') {
                FOCUSED_ELEMENT_INDEX += 1;
                if (FOCUSED_ELEMENT_INDEX < FOCUSABLE_ELEMENTS.length) {
                    FOCUSABLE_ELEMENTS[FOCUSED_ELEMENT_INDEX].focus();
                } else {
                    FOCUSED_ELEMENT_INDEX = -1;
                    input.focus();
                }
                ev.preventDefault();
            } else if (ev.key === 'ArrowUp') {
                FOCUSED_ELEMENT_INDEX -= 1;
                if (FOCUSED_ELEMENT_INDEX >= 0) {
                    FOCUSABLE_ELEMENTS[FOCUSED_ELEMENT_INDEX].focus();
                } else {
                    FOCUSED_ELEMENT_INDEX = -1;
                    input.focus();
                }
                ev.preventDefault();
            }
        });

        input.addEventListener('focus', ev => { runSearch(); });
    }

    function renderResult(result) {
        const entry = document.createElement('li');
        entry.classList.add('suggestion');
        const linkContainer = document.createElement('a');
        linkContainer.classList.add('suggestion-header');
        linkContainer.setAttribute('href', result.url);
        const page = document.createElement('p');
        page.classList.add('suggestion-title');
        page.innerText = result.title ?? result.meta?.title ?? '';
        const excerpt = document.createElement('p');
        excerpt.classList.add('suggestion-excerpt');
        excerpt.innerHTML = result.excerpt;
        linkContainer.appendChild(page);
        linkContainer.appendChild(excerpt);
        entry.appendChild(linkContainer);
        return entry;
    }

    async function buildResults(results) {
        const suggestions = document.getElementById('search-result-container');
        const children = await Promise.all(results.slice(0, MAX_RESULTS - 1).map(async (r) => {
            const data = await r.data();
            const entry = renderResult(data);
            if (data.sub_results.length > 0) {
                const subResults = document.createElement('ol');
                subResults.classList.add('sub-suggestions');
                data.sub_results.forEach(subresult => {
                    subResults.appendChild(renderResult(subresult));
                });
                entry.appendChild(subResults);
            }
            return entry;
        }));
        if (results.length > 0) {
            suggestions.classList.remove('hidden');
        } else {
            suggestions.classList.add('hidden');
        }
        suggestions.replaceChildren(...children);
        FOCUSED_ELEMENT_INDEX = -1;
        FOCUSABLE_ELEMENTS = [...suggestions.querySelectorAll('a')];
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initialize);
    } else {
        initialize();
    }
    </script>
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

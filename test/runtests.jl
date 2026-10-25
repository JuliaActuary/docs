using Test
include("../docs/theme.jl")

@testset "Theme cache invalidation" begin
    mktempdir() do source
        write(joinpath(source, "cassette.css"), "body { color: navy; }")
        mkpath(joinpath(source, "webfonts"))
        write(joinpath(source, "webfonts", "font.woff2"), "font fixture")
        first = prepare_theme_assets(source)
        unchanged = prepare_theme_assets(source)
        @test first.stylesheet == unchanged.stylesheet
        @test read(joinpath(first.directory, basename(first.stylesheet)), String) == read(joinpath(source, "cassette.css"), String)
        @test isfile(joinpath(first.directory, "webfonts", "font.woff2"))
        write(joinpath(source, "cassette.css"), "body { color: red; }")
        changed = prepare_theme_assets(source)
        @test changed.stylesheet != first.stylesheet
    end
end

@testset "Aggregated page fonts and search" begin
    html = """
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lato-font/3.0.0/css/lato-font.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/juliamono/0.63.2/juliamono.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="assets/katex.min.css">
        <script src="../../pagefind/pagefind.js" type="text/javascript"></script>
        <script src="../../assets/default/pagefind_integration.js"></script>
    </head>
    <input id="search-input" placeholder="Search everywhere...">
    <button id="multidoc-toggler"><svg></svg></button>
    """
    result = apply_shared_theme(html)
    @test !occursin("lato-font", result)
    @test !occursin("juliamono.min.css", result)
    @test occursin("font-awesome/6.7.2", result)
    @test occursin("assets/katex.min.css", result)
    @test occursin("aria-label=\"Search all package documentation\"", result)
    @test occursin("aria-label=\"Choose a package\"", result)
    @test !occursin("src=\"../../pagefind/pagefind.js\"", result)
    @test occursin("pagefind_integration.js", result)
    @test apply_shared_theme(result) == result
end


include("../docs/links.jl")
@testset "Historical documentation links" begin
    old = "https://JuliaActuary.github.io/FinanceModels.jl/v4.3.0/interpolation/?mode=full#CubicSpline"
    current = "https://docs.juliaactuary.org/FinanceModels/v4.3.0/interpolation/?mode=full#CubicSpline"
    @test normalize_documentation_links("<a href=\"$old\">Guide</a>") == "<a href=\"$current\">Guide</a>"
    @test normalize_documentation_links(current) == current
    @test normalize_documentation_links("http://juliaactuary.github.io/Yields.jl/v1.1.2/") ==
          "https://docs.juliaactuary.org/FinanceModels/v1.1.2/"
    @test normalize_documentation_links("//JuliaActuary.github.io/MortalityTables.jl/stable/#MortalityTable") ==
          "https://docs.juliaactuary.org/MortalityTables/stable/#MortalityTable"
    @test normalize_documentation_links("<meta content=\"https://JuliaActuary.github.io/FinanceCore.jl/\">") ==
          "<meta content=\"https://docs.juliaactuary.org/FinanceCore/\">"
    for untouched in (
        "https://juliaactuary.github.io/ChainLadder.jl/stable/",
        "https://juliaactuary.github.io/LifeSimulator.jl/dev/",
        "https://juliaactuary.github.io/Learn/soa_life_meeting_2023/slides.html",
        "https://juliadocs.github.io/Documenter.jl/stable/",
        "https://github.com/JuliaActuary/FinanceModels.jl",
        "https://juliaactuary.github.io/FinanceModels.jl.example/",
    )
        @test normalize_documentation_links(untouched) == untouched
    end
end

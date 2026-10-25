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

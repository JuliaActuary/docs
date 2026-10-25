using SHA

const BRAND_FONT_STYLESHEET = "https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible:ital,wght@0,400;0,700;1,400;1,700&display=swap"

"Stage assets with a content-addressed stylesheet so theme updates bypass old caches."
function prepare_theme_assets(source = joinpath(@__DIR__, "assets"))
    directory = mktempdir()
    cp(source, directory; force = true)
    stylesheet = joinpath(directory, "cassette.css")
    filename = "cassette-$(bytes2hex(sha256(read(stylesheet)))[1:16]).css"
    mv(stylesheet, joinpath(directory, filename))
    return (; directory, stylesheet = "assets/$filename")
end

"Remove upstream font downloads replaced by the shared theme; label global search."
function apply_shared_theme(html)
    html = replace(html, r"<link\b[^>]*>" => link ->
        occursin(r"https://cdnjs\.cloudflare\.com/ajax/libs/(?:lato-font|juliamono)/", link) ? "" : link)
    html = replace(html, r"<input\b[^>]*\bid=[\"']search-input[\"'][^>]*>" => input ->
        occursin("aria-label=", input) ? input :
        replace(input, "<input" => "<input aria-label=\"Search all package documentation\""; count = 1))
    html = replace(html, r"<button\b[^>]*\bid=[\"']multidoc-toggler[\"'][^>]*>" => button ->
        occursin("aria-label=", button) ? button :
        replace(button, "<button" => "<button aria-label=\"Choose a package\""; count = 1))
    # PageFind is imported by pagefind_integration.js. MultiDocumenter also adds
    # a classic-script tag for that ES module, which produces a syntax error.
    html = replace(html, r"<script\b[^>]*\bsrc=[\"'][^\"']*/pagefind/pagefind\.js[\"'][^>]*>\s*</script>" => "")
    return html
end

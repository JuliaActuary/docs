# FinanceModels retains the published documentation from its former name, Yields.
const DOCUMENTATION_PATHS = (
    "ActuaryUtilities" => "ActuaryUtilities",
    "EconomicScenarioGenerators" => "EconomicScenarioGenerators",
    "ExperienceAnalysis" => "ExperienceAnalysis",
    "FinanceCore" => "FinanceCore",
    "FinanceModels" => "FinanceModels",
    "LifeContingencies" => "LifeContingencies",
    "MortalityTables" => "MortalityTables",
    "Yields" => "FinanceModels",
)

"Keep documentation links in historical releases on the unified portal."
function normalize_documentation_links(html)
    for (package, path) in DOCUMENTATION_PATHS
        old_url = Regex("(?:https?:)?//juliaactuary\\.github\\.io/$package\\.jl(?=[/?#\"'\\s<>]|\\z)", "i")
        html = replace(html, old_url => "https://docs.juliaactuary.org/$path")
    end
    return html
end

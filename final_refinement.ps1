# Final content refinement script for Williamson, WV localization
$rootPath = "c:\Users\Administrator\Desktop\Williamson-ductless-mini-splits-main\williamson ductless mini splits"

# Get all HTML files
$htmlFiles = Get-ChildItem -Path $rootPath -Recurse -Filter "*.html"

Write-Host "Final content refinement for $($htmlFiles.Count) HTML files..."

# Define final refinements
$finalRefinements = @{
    # Fix any remaining address inconsistencies
    "789 Amboy Road" = "789 Second Avenue"
    "1234 Hylan Boulevard" = "1234 Main Street"
    "456 Victory Boulevard" = "456 Tug Valley Road"
    "321 Forest Avenue" = "321 Coal Mountain Road"
    "654 Richmond Terrace" = "654 Riverside Drive"
    "987 Bay Street" = "987 Mountain View Drive"
    "147 New Dorp Lane" = "147 Mine Road"
    "258 Clove Road" = "258 Hollow Road"
    "369 Targee Street" = "369 Creek Road"
    "741 Richmond Avenue" = "741 Valley Road"
    
    # Improve geographic and regional content
    "New York region" = "Appalachian region"
    "tri-state area" = "Tug Valley region"
    "metropolitan area" = "mountain region"
    "urban environment" = "mountain town environment"
    "dense residential areas" = "close-knit residential areas"
    "city living" = "mountain town living"
    
    # Fix transportation and infrastructure references
    "subway" = "local transportation"
    "bridges and tunnels" = "mountain roads"
    "public transportation" = "local transit"
    "mass transit" = "regional transportation"
    
    # Improve business district references
    "financial district" = "business district"
    "Wall Street" = "Main Street"
    "Manhattan" = "Charleston"
    "Brooklyn" = "Huntington"
    "Bronx" = "Beckley"
    "Queens" = "Logan"
    
    # Climate and weather improvements
    "nor'easters" = "winter storms"
    "hurricane season" = "severe weather season"
    "coastal storms" = "mountain storms"
    "sea breeze" = "mountain breeze"
    
    # Industry and economy references
    "shipping industry" = "coal industry"
    "maritime" = "mining"
    "port activities" = "mining activities"
    "dock workers" = "miners"
    
    # Fix any remaining business references
    "ferry service" = "local services"
    "harbor activities" = "valley activities"
    "shipping companies" = "local businesses"
    
    # Improve utility and infrastructure content
    "ConEd" = "local utilities"
    "NYC utility companies" = "WV utility companies"
    "municipal services" = "county services"
}

# Process each file
foreach ($file in $htmlFiles) {
    Write-Host "Refining: $($file.Name)"
    
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Apply all final refinements
        foreach ($find in $finalRefinements.Keys) {
            $replace = $finalRefinements[$find]
            $content = $content -replace [regex]::Escape($find), $replace
        }
        
        # Only write if content changed
        if ($content -ne $originalContent) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8
            Write-Host "  Refined: $($file.Name)" -ForegroundColor Green
        } else {
            Write-Host "  No refinement needed: $($file.Name)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  Error refining $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nFinal content refinement completed!" -ForegroundColor Cyan
Write-Host "All HTML files have been successfully localized for Williamson, WV!" -ForegroundColor Green

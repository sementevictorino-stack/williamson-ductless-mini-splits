# PowerShell script to update all HTML files from Staten Island to Williamson, WV
# This script will perform bulk text replacements across all HTML files

$rootPath = "c:\Users\Administrator\Desktop\Williamson-ductless-mini-splits-main\williamson ductless mini splits"

# Get all HTML files
$htmlFiles = Get-ChildItem -Path $rootPath -Recurse -Filter "*.html"

Write-Host "Found $($htmlFiles.Count) HTML files to update..."

# Define replacement patterns
$replacements = @{
    "Staten Island" = "Williamson, WV"
    "Staten Island's" = "Williamson's"
    "Staten Island," = "Williamson,"
    "Staten Island area" = "Williamson area"
    "Staten Island residents" = "Williamson residents"
    "Staten Island properties" = "Williamson properties"
    "Staten Island homes" = "Williamson homes"
    "Staten Island businesses" = "Williamson businesses"
    "Staten Island communities" = "Williamson area communities"
    "Staten Island zip codes" = "Williamson and surrounding areas"
    "Staten Island NY" = "Williamson WV"
    "Staten Island, NY" = "Williamson, WV"
    "Staten Island, New York" = "Williamson, West Virginia"
    "SI Ductless Pro" = "Williamson Mini Split Pro"
    "statenislandductless" = "williamsonwvductless"
    "Staten Island Ductless Mini Splits" = "Williamson WV Ductless Mini Splits"
    "123 Victory Blvd" = "123 Main Street"
    "NY 10301" = "WV 25661"
    "10301" = "25661"
    "New York Harbor" = "Tug River"
    "waterfront" = "riverside"
    "island" = "mountain town"
    "ferry terminal" = "town center"
    "St. George" = "Downtown Williamson"
    "Stapleton" = "Delbarton"
    "Port Richmond" = "Matewan"
    "Tottenville" = "Red Jacket"
    "Great Kills" = "Kermit"
    "New Brighton" = "Crum"
    "West Brighton" = "Lenore"
    "South Beach" = "Naugatuck"
    "Castleton Corners" = "Gilbert"
    "New Dorp" = "Varney"
    "Oakwood" = "Coal Mountain"
    "Pleasant Plains" = "Borderland"
    "Richmond Valley" = "Chattaroy"
    "Eltingville" = "Rawl"
    "Mariners Harbor" = "Blackberry"
    "Willowbrook" = "Fedscreek"
    "Bay Terrace" = "Beauty"
    "Charleston" = "Lovely"
    "Grant City" = "Warfield"
    "Dongan Hills" = "Inez"
    "Clifton" = "Pilgrim"
    "latitude: 40.6282" = "latitude: 37.6737"
    "longitude: -74.0776" = "longitude: -82.2771"
    "info@statenislandductless.com" = "info@williamsonwvductless.com"
}

# Process each file
foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Apply all replacements
        foreach ($find in $replacements.Keys) {
            $replace = $replacements[$find]
            $content = $content -replace [regex]::Escape($find), $replace
        }
        
        # Only write if content changed
        if ($content -ne $originalContent) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8
            Write-Host "  Updated: $($file.Name)" -ForegroundColor Green
        } else {
            Write-Host "  No changes: $($file.Name)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nBulk replacement completed!" -ForegroundColor Cyan
Write-Host "Manual review and refinement may be needed for specific content." -ForegroundColor Yellow

# PowerShell script to clean up remaining issues from the bulk replacement
$rootPath = "c:\Users\Administrator\Desktop\Williamson-ductless-mini-splits-main\williamson ductless mini splits"

# Get all HTML files
$htmlFiles = Get-ChildItem -Path $rootPath -Recurse -Filter "*.html"

Write-Host "Cleaning up $($htmlFiles.Count) HTML files..."

# Define cleanup patterns
$cleanupReplacements = @{
    # Fix address and location issues
    "addressRegion`": `"NY`"" = "addressRegion`": `"WV`""
    "postalCode`": `"10301`"" = "postalCode`": `"25661`""
    "postalCode`": `"10302`"" = "postalCode`": `"25670`""
    "postalCode`": `"10303`"" = "postalCode`": `"25678`""
    "postalCode`": `"10304`"" = "postalCode`": `"25692`""
    "postalCode`": `"10305`"" = "postalCode`": `"25674`""
    "postalCode`": `"10306`"" = "postalCode`": `"25669`""
    "postalCode`": `"10307`"" = "postalCode`": `"25676`""
    "postalCode`": `"10308`"" = "postalCode`": `"25685`""
    
    # Fix schema data inconsistencies
    "Red Jacket, Williamson, WV, NY" = "Red Jacket, WV"
    "Delbarton, Williamson, WV, NY" = "Delbarton, WV"
    "Matewan, Williamson, WV, NY" = "Matewan, WV"
    "Kermit, Williamson, WV, NY" = "Kermit, WV"
    "Crum, Williamson, WV, NY" = "Crum, WV"
    "Lenore, Williamson, WV, NY" = "Lenore, WV"
    "Naugatuck, Williamson, WV, NY" = "Naugatuck, WV"
    "Gilbert, Williamson, WV, NY" = "Gilbert, WV"
    
    # Fix any remaining Staten Island references
    "serving all Williamson, WV zip codes" = "serving all Williamson area communities"
    "across all Williamson, WV zip codes" = "across the Williamson area"
    
    # Fix geographic references
    "New York's" = "West Virginia's"
    "NYC" = "WV"
    "borough" = "county"
    "boroughs" = "counties"
    "Mingo County" = "Mingo County"
    
    # Fix climate references
    "variable climate" = "variable mountain climate"
    "coastal" = "mountain"
    
    # Fix some business names that might be inconsistent
    "Williamson, WV Ductless Mini Splits - " = "Williamson WV Ductless Mini Splits - "
}

# Process each file
foreach ($file in $htmlFiles) {
    Write-Host "Cleaning up: $($file.Name)"
    
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Apply all cleanup replacements
        foreach ($find in $cleanupReplacements.Keys) {
            $replace = $cleanupReplacements[$find]
            $content = $content -replace [regex]::Escape($find), $replace
        }
        
        # Only write if content changed
        if ($content -ne $originalContent) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8
            Write-Host "  Cleaned up: $($file.Name)" -ForegroundColor Green
        } else {
            Write-Host "  No cleanup needed: $($file.Name)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  Error cleaning up $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nCleanup completed!" -ForegroundColor Cyan

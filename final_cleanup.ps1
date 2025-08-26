# Final cleanup script to fix all remaining issues
$rootPath = "c:\Users\Administrator\Desktop\Williamson-ductless-mini-splits-main\williamson ductless mini splits"
$htmlFiles = Get-ChildItem -Path $rootPath -Recurse -Filter "*.html"

Write-Host "Final cleanup of $($htmlFiles.Count) HTML files..."

# Define comprehensive cleanup patterns
$finalCleanups = @{
    # Fix duplicate WV
    "Williamson, WV, WV" = "Williamson, WV"
    
    # Fix old Staten Island zip codes - replace with proper WV zip codes
    "(10302)" = "(25678)"  # Matewan
    "(10304)" = "(25670)"  # Delbarton  
    "(10305)" = "(25685)"  # Naugatuck
    "(10306)" = "(25669)"  # Coal Mountain
    "(10307)" = "(25692)"  # Red Jacket
    "(10308)" = "(25674)"  # Kermit
    "(10309)" = "(25676)"  # Lovely
    "(10310)" = "(25676)"  # Lenore
    "(10311)" = "(25680)"  # Beauty
    "(10312)" = "(25681)"  # Rawl
    "(10313)" = "(25682)"  # Gilbert
    "(10314)" = "(25683)"  # Varney
    
    # Fix zip code lists in content
    "zip codes including 25661, 10302, 10303, 10304, 10305, 10306, 10307, 10308, 10309, 10310, 10311, 10312, 10313, and 10314" = "zip codes including 25661, 25670, 25674, 25676, 25678, 25680, 25685, and surrounding Mingo County areas"
    
    # Fix any remaining location schema issues
    "postalCode`": `"10309`"" = "postalCode`": `"25676`""
    "addressRegion`": `"NY`"" = "addressRegion`": `"WV`""
    
    # Fix any remaining service area issues
    "Lovely, Williamson, WV, NY" = "Lovely, WV"
    "Rosebank, Williamson, WV, NY" = "Rawl, WV"
    
    # Fix any remaining New Jersey references
    "New Jersey communities close to Williamson, WV" = "Pike County, KY communities close to Williamson, WV"
    "parts of Huntington, New Jersey" = "parts of Pike County, KY"
    
    # Fix any remaining link to non-existent Rosebank
    '<a href="../locations/rosebank.html">Rosebank</a>' = '<a href="../locations/eltingville.html">Rawl</a>'
    "Rosebank" = "Rawl"
}

# Process each file
foreach ($file in $htmlFiles) {
    Write-Host "Final cleanup: $($file.Name)"
    
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Apply all final cleanups
        foreach ($find in $finalCleanups.Keys) {
            $replace = $finalCleanups[$find]
            $content = $content -replace [regex]::Escape($find), $replace
        }
        
        # Only write if content changed
        if ($content -ne $originalContent) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8
            Write-Host "  Final cleanup applied: $($file.Name)" -ForegroundColor Green
        } else {
            Write-Host "  No final cleanup needed: $($file.Name)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  Error in final cleanup $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nFinal cleanup completed!" -ForegroundColor Cyan
Write-Host "All issues should now be resolved!" -ForegroundColor Green

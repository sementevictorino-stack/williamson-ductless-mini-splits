# Script to fix navigation links and remove non-existent location references
$rootPath = "c:\Users\Administrator\Desktop\Williamson-ductless-mini-splits-main\williamson ductless mini splits"

# Get all HTML files
$htmlFiles = Get-ChildItem -Path $rootPath -Recurse -Filter "*.html"

Write-Host "Fixing navigation links in $($htmlFiles.Count) HTML files..."

# Define navigation cleanup - remove links to non-existent files and fix existing ones
$navCleanups = @{
    # Remove non-existent location links from dropdowns
    '                        <a href="../locations/bayonne-nj.html">Bayonne, NJ</a>' = ''
    '                        <a href="../locations/jersey-city-nj.html">Jersey City, NJ</a>' = ''
    '                        <a href="../locations/hoboken-nj.html">Hoboken, NJ</a>' = ''
    '                        <a href="../locations/Huntington-ny.html">Huntington, NY</a>' = ''
    '                        <a href="../locations/Charleston-ny.html">Charleston, NY</a>' = ''
    '                        <a href="../locations/newark-nj.html">Newark, NJ</a>' = ''
    '                        <a href="../locations/elizabeth-nj.html">Elizabeth, NJ</a>' = ''
    '                        <a href="../locations/perth-amboy-nj.html">Perth Amboy, NJ</a>' = ''
    '                        <a href="../locations/union-city-nj.html">Union City, NJ</a>' = ''
    '                        <a href="../locations/weehawken-nj.html">Weehawken, NJ</a>' = ''
    '                        <a href="../locations/rosebank.html">Rosebank</a>' = ''
    
    # Fix location link text to match actual file content
    '<a href="../locations/st-george.html">Downtown Williamson</a>' = '<a href="../locations/st-george.html">Downtown Williamson</a>'
    '<a href="../locations/Delbarton.html">Delbarton</a>' = '<a href="../locations/stapleton.html">Delbarton</a>'
    '<a href="../locations/Red Jacket.html">Red Jacket</a>' = '<a href="../locations/tottenville.html">Red Jacket</a>'
    '<a href="../locations/new-brighton.html">Crum</a>' = '<a href="../locations/mariners-harbor.html">Crum</a>'
    
    # Clean up any remaining inconsistent location names in links
    'href="st-george.html">Downtown Williamson' = 'href="st-george.html">Downtown Williamson'
    'href="stapleton.html">Delbarton' = 'href="stapleton.html">Delbarton'
    'href="port-richmond.html">Matewan' = 'href="port-richmond.html">Matewan'
    'href="tottenville.html">Red Jacket' = 'href="tottenville.html">Red Jacket'
    'href="great-kills.html">Kermit' = 'href="great-kills.html">Kermit'
    'href="mariners-harbor.html">Crum' = 'href="mariners-harbor.html">Crum'
    'href="west-brighton.html">Lenore' = 'href="west-brighton.html">Lenore'
    'href="south-beach.html">Naugatuck' = 'href="south-beach.html">Naugatuck'
    'href="castleton-corners.html">Gilbert' = 'href="castleton-corners.html">Gilbert'
}

# Process each file
foreach ($file in $htmlFiles) {
    Write-Host "Fixing navigation in: $($file.Name)"
    
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Apply all navigation cleanups
        foreach ($find in $navCleanups.Keys) {
            $replace = $navCleanups[$find]
            $content = $content -replace [regex]::Escape($find), $replace
        }
        
        # Only write if content changed
        if ($content -ne $originalContent) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8
            Write-Host "  Fixed navigation: $($file.Name)" -ForegroundColor Green
        } else {
            Write-Host "  Navigation OK: $($file.Name)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  Error fixing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nNavigation cleanup completed!" -ForegroundColor Cyan

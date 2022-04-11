# Get commit descriptor
$descriptor = git describe --match v[0-9]*
$longDescriptor = git describe --long --match v[0-9]*
$longDescriptor -match '^(?<tag>.+)-(?<count>\d+)-g(?<hash>[0-9a-f]+)$' | Out-Null
$tag = $Matches.tag
$count = $Matches.count
$hash = $Matches.hash

Write-Host "git-describe returned $descriptor where:"
Write-Host "  tag is                  $tag"
Write-Host "  commit distance is      $count"
Write-Host "  commit hash starts with $hash"
Write-Host

# Construct assembly and package versions
$semVer = $tag.Substring(1)
$assemblyVersion = "$semVer.0"
$assemblyFileVersion = "$semVer.$count"
$assemblyInformationalVersion = $descriptor
$packageVersion = If ($count -gt 0) { "$semVer-$count-$hash" } Else { $semVer }

Write-Host "Assembly will have:"
Write-Host "  version               $assemblyVersion"
Write-Host "  file version          $assemblyFileVersion"
Write-Host "  informational version $assemblyInformationalVersion"
Write-Host

Write-Host "Package will have:"
Write-Host "  version               $packageVersion"
Write-Host

# Inject constructed versions into the build
dotnet build 'GitDescribeVersionDemo.sln' -c Release --no-incremental `
    -p:AssemblyVersion=$assemblyVersion `
    -p:FileVersion=$assemblyFileVersion `
    -p:InformationalVersion=$assemblyInformationalVersion `
    -p:PackageVersion=$packageVersion `
    -p:PackageTags=$descriptor

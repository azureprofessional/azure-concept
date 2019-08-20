param (
  $DocPath = "./",
  $TargetPDF = "./azure-concept.pdf"
)

$pathToPandoc = "pandoc" # "$Env:ProgramData\chocolatey\bin\pandoc.exe"

$Files = Get-ChildItem $DocPath -Filter *.md -Recurse | Select-Object Name, FullName | Sort-Object Name

$mdFiles = ''

ForEach ($File in $Files){

  If (([string]::IsNullOrEmpty($mdFiles))){
    $mdFiles = $mdFiles + ('"' + $File.FullName + '"')
  } Else {
    $mdFiles = $mdFiles + (' "' + $File.FullName + '"')
  }
}

$ArgumentList = ''
$ArgumentList = $ArgumentList + (' -o ' + "`"$TargetPDF`"")
$ArgumentList = $ArgumentList + (' -i ' + $mdFiles)

$ArgumentList = $ArgumentList + (' -s')
$ArgumentList = $ArgumentList + (' -f' + ' markdown_github')
$ArgumentList = $ArgumentList + (' --include-in-header' + ' pagebreak.tex')
$ArgumentList = $ArgumentList + (' --toc')
$ArgumentList = $ArgumentList + (' --pdf-engine=xelatex')
$ArgumentList = $ArgumentList + (' -V' + ' geometry:a4paper')
$ArgumentList = $ArgumentList + (' -V' + ' geometry:margin=1in')
$ArgumentList = $ArgumentList + (' -V' + ' linkcolor:blue')

#$ArgumentList = $ArgumentList + (' --reference-doc=' + $DocPath + '\custom-reference.docx')
#$ArgumentList = $ArgumentList + (' --metadata-file=' + $DocPath + '\metadata.yml')

Start-Process -Wait -NoNewWindow -FilePath $pathToPandoc -ArgumentList $ArgumentList

Write-Host "Process finished"

#Start-Process -Wait -NoNewWindow -FilePath "$Env:ProgramData\chocolatey\bin\pandoc.exe" -ArgumentList "-s -V geometry:margin=1in -o $TargetPDF $mdFiles"
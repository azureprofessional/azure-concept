$DocPath = "$Env:USERPROFILE\Documents\GitHub\mgessenay\azure-concept-priv"
$TargetPDF = "$Env:USERPROFILE\Documents\azure-concept.pdf"

$Files = Get-ChildItem $DocPath -Filter *.md -Recurse | Select-Object Name, FullName | Sort-Object Name

$mdFiles = ''

ForEach ($File in $Files){

  If (([string]::IsNullOrEmpty($mdFiles))){
    $mdFiles = $mdFiles + ('"' + $File.FullName + '"')
  } Else {
    $mdFiles = $mdFiles + (' "' + $File.FullName + '"')
  }
}

$ArgumentList = '-s -V geometry:margin=1in'
$ArgumentList = $ArgumentList + (' -o ' + "`"$TargetPDF`"")
$ArgumentList = $ArgumentList + (' -i ' + $mdFiles)
#$ArgumentList = $ArgumentList + (' --reference-doc=' + $DocPath + '\custom-reference.docx')
#$ArgumentList = $ArgumentList + (' --toc')
#$ArgumentList = $ArgumentList + (' --metadata-file=' + $DocPath + '\metadata.yml')

Start-Process -Wait -NoNewWindow -FilePath "$Env:ProgramData\chocolatey\bin\pandoc.exe" -ArgumentList $ArgumentList

#Start-Process -Wait -NoNewWindow -FilePath "$Env:ProgramData\chocolatey\bin\pandoc.exe" -ArgumentList "-s -V geometry:margin=1in -o $TargetPDF $mdFiles"
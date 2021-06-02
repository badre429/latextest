$Url = 'https://mirror.marwan.ma/ctan/systems/texlive/tlnet/install-tl.zip' 
$ZipFile = $(Split-Path -Path $Url -Leaf) 
 
#If the file does not exist, create it.
if (-not(Test-Path -Path $ZipFile  -PathType Leaf)) { 
    Invoke-WebRequest -Uri $Url -OutFile $ZipFile 
}
Expand-Archive -Path $ZipFile 
Move-Item .\install-tl\install-tl-*\*  .\install-tl\  -Force -ErrorAction SilentlyContinue
.\install-tl\install-tl-windows.bat     -no-gui  --profile  .\texlive_windows.profile
.\texlive\bin\win32\tlmgr.bat install latex-bin platex uplatex tex xetex  pdftex wintools.win32  collection-latexextra

.\texlive\bin\win32\tlmgr.bat install amsmath graphics tools import subfiles latexmk makeindex 

.\texlive\bin\win32\lualatex.exe  --synctex=1 --interaction=batchmode  --shell-escape --enable-installer index.tex
.\texlive\bin\win32\lualatex.exe  --synctex=1 --interaction=batchmode  --shell-escape --enable-installer sample.tex
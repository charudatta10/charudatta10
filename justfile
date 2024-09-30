#    GitHUb profile project  
#    Copyright © 2024 Charudatta
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#    email contact: 152109007c@gmailcom

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

env_path := "C:/Users/$env:username/Documents/GitHub"

default:
    @just --choose

# create files and directories
init:
    #!pwsh
    git init
    New-Item -ItemType "file" -Path ".env", ".gitattribute", "run.py", "requirements.txt"
    New-Item -ItemType "directory" -Path "docs", "src", "tests"
    gig gen python > .gitignore 
    Add-LicenseHeader
    7z a archives.7z .gitignore

# add documentation to repo
docs:
    #!pwsh
    conda activate blog
    python -m mkdocs new .

# generate and readme to repo    
readme:
    #!pwsh
    conda activate w
    python {{env_path}}/readmeGen/main.py

# version control repo with git
commit message="init":
    #!pwsh
    git add .
    git commit -m {{message}}

# create windows executable
exe file_name:
    #!pwsh
    pyinstaller src/{{file_name}} --onefile

# run python unit test 
tests:
    #!pwsh
    python -m unittest discover -s tests

# run project
run:
    #!pwsh
    python run.py

# exit just file
quit:
    #!pwsh
    write-Host "Copyright © 2024 Charudatta"
    Write-Host "email contact: 152109007c@gmailcom"
    Write-Host "Exiting Folder" 
    [System.IO.Path]::GetFileName($(Get-Location))

# install dependencies
install:
    #!pwsh
    pip install -r requirements.txt

# lint code
lint:
    #!pwsh
    pylint src/

# format code
format:
    #!pwsh
    black src/

# run security checks
security:
    #!pwsh
    bandit -r src/

# build documentation
build-docs:
    #!pwsh
    mkdocs build

# deploy application
deploy:
    #!pwsh
    scp -r src/ user@server:/path/to/deploy

# clean up
clean:
    #!pwsh
    Remove-Item -Recurse -Force dist, build, *.egg-info

# check for updates
update:
    #!pwsh
    pip list --outdated


# Add custom tasks, enviroment variables
cv:
    #!pwsh
    cd src/cv
    lualatex cv.tex

portfolio:
    #!pwsh
    cd src/portfolio
    marp portfolio.md
    marp --pdf portfolio.md --pdf-notes --pdf-outlines --allow-local-files
    marp --pptx portfolio.md  --allow-local-files

resume:
    #!pwsh
    cd src/resume
    pandoc resume.md -f markdown -t html -c resume.css -s -o resume.html
    wkhtmltopdf --enable-local-file-access resume.html resume.pdf




        
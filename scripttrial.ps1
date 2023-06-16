echo "# personalregistery1990" >> README.md

git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/AnshuDe/webapplication.git
git push -u origin main

git init
git remote -v

git config --global user.name "AnshuDe"
git config --global user.email "anshude1056@gmail.com"

git add .
git commit -m "update new file"

git push  -uf origin main

$v = Get-Date -Format "yyyyMMdd_hhmmss"
Write-Output $v

az login --service-principal -u "39c95471-bcfc-4bdc-b53d-eef346ab1a89" -p "YLx8Q~uJzzU4LUrX2G0hQsHZRVUv~f4lG.5.NcEt" --tenant "4ec9e9d4-1dad-427f-adf9-e774dca413d1"
az acr login -n azureregistery02

docker build . --file Dockerfile --tag azureregistery02.azurecr.io/webapp:$v
docker push azureregistery02.azurecr.io/webapp:$v
az acr repository list --name azureregistery02 --output table
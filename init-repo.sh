#/usr/bin/env bash

# Declare functions
# Given a string, apply yellow colouration and print to stdout
function p {
  echo -e "\033[33m${1}\033[0m"
}

# "Initialize a new git repository in the current directory."
git init

# "Create an empty 'Initial commit'."
git commit -m "Initial commit" --allow-empty

# "Create a boilerplate '.gitignore' file."
# "Commit the '.gitignore' file."
cat << EOF > .gitignore
node_modules/
**/*.swp
EOF

git add ./.gitignore
git commit -m "chore(gitignore): Add file"

# "Initialize the current repo as an npm package."
# "Commit the 'package.json'."
npm init -y
git add package.json
git commit -m "chore(npm): Initialize package"

# Install devDependencies
p "Would you like to install the default development dependencies? [Y/N]"
read install_dev_deps

if [ "${install_dev_deps}" = "Y" ]; then
  p "Installing development dependencies."
  npm install --save-dev mocha chai sinon sinon-chai
  git add . && git commit -m "chore(pkg): Add devDeps"
else
  p "Skipping development dependencies."
fi

# Setup dirs.
mkdir src test
touch {src,test}/.gitkeep
git add . && git commit -m "Setup dirs."

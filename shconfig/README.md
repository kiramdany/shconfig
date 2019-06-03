On initial setup need to set the following in `.git/config` file

```
[core]
    ...
	worktree = $HOME
```

replacing `$HOME` with the absolute path to your home directory ( where your .bashrc and other config files live. Which you should be able to find by doing `echo $HOME` into the terminal )

Then restructure files and folders ( the .git folder is originally in shconfig but gets moved when repo is pushed to a remote )
Something along the lines of

```
mkdir "$HOME"/shconfig
mv "$HOME"/shellconfig/{.git,shconfig/*} "$HOME"/shconfig
cd "$HOME"/shconfig 
git checkout -b intialConfig
git commit -am 'Initial config on this comp'
mv "$HOME"/shellconfig/* "$HOME"
```

VSCode
Once vscode is installed, including the command line helper `code`
Make sure initial vscode settings in the relevant config folder are being tracked before copying over the ones from the repo 

```
for i in $(cat vscode/extensions.txt); do code --install-extension "$i"; done
cp "$HOME"/shconfig/vscode/{settings,keybindings}.json "$HOME"/.config/Code/User/
```
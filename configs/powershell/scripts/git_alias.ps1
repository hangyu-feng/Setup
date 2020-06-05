# Here are some git aliases I borrowed from oh-my-zsh's git plugin:
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git

set-alias -name g -value git
function ga { git add }
function gaa { git add --all }
function gav { git add --verbose }
function gb { git branch }
function gc { git commit -v }
function gc! {  git commit --amend }
function gcam { git commit -a -m $args }
function gcb { git checkout -b }
function gcf { git config --list }
function gcm { git checkout master }
function gco { git checkout }
function gcp { git cherry-pick }
function gcpa {	git cherry-pick --abort }
function gcpc {	git cherry-pick --continue }
function gd { git diff }
function gf { git fetch }
function gfa { git fetch --all --prune }
function gpull { git pull }
function gm { git merge }
function gmom { git merge origin/master }
function gma { git merge --abort }
function gp { git push }
function grhh { git reset --hard }
function grs { git restore }
function gst { git status }
function gstc { git stash clear }
function gstd { git stash drop }
function gstl { git stash list }
function gstp { git stash pop }

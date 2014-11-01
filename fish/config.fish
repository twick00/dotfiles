# CD Helper
function cd --description "Change working directory"
  builtin cd $argv
  emit cwd
end


################################################################################
# PATHS

# Dotfiles bin
set PATH (dirname (status -f))"/../bin" $PATH
set PATH $HOME/local/bin $PATH

# Homebrew bin
set PATH /usr/local/sbin $PATH
set PATH /usr/local/bin $PATH

# Haskell bin
if test -d $HOME/.cabal/bin
  set PATH $HOME/.cabal/bin $PATH
end

# Go
if test -d /usr/local/opt/go/libexec
  set -x GOROOT /usr/local/opt/go/libexec
  mkdir -p $GOPATH
  set PATH $GOPATH/bin $GOROOT/bin $PATH

  function __check_go_path_on_cwd --on-event cwd
    set DIR (pwd)
    while not test -f $DIR/.gopath
      if test $DIR = /
        break
      end 
      set DIR (dirname $DIR)
    end

    if test -f $DIR/.gopath
      echo "GOPATH: $DIR"
      set -gx GOPATH $DIR
    end
  end
end

# Rbenv bin
if test -d $HOME/.rbenv
  set PATH $HOME/.rbenv/bin $PATH
  set PATH $HOME/.rbenv/shims $PATH
  set PATH ./bin $PATH
end

# Nimrod bin
if test -d $HOME/local/inst/nimrod
  set PATH $HOME/local/inst/nimrod/bin $PATH
end

# Babel bin
if test -d $HOME/.babel/bin
  set PATH $HOME/.babel/bin $PATH
end

# Android
set -x ANDROID_HOME /usr/local/opt/android-sdk

# Scala sbt opts
set -x SBT_OPTS "-Xms512M -Xmx2G -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"

################################################################################
# Make flags
set CPPFLAGS '-I$HOME/local/include'
set CFLAGS '-I$HOME/local/include'
set LDFLAGS '-L$HOME/local/lib'

################################################################################
# Environment variables

set -x GIT_SSH git-ssh

# Use vim as the default editor
if type vim 1>/dev/null
  set -x EDITOR 'vim'
end

################################################################################
# Aliases

alias g "git"
alias r "rails"
alias z "zeus"
alias b "bundle exec"


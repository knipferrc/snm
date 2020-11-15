import os, strformat

proc printSeparator() = 
  echo "############################################"

proc setupGit() = 
  echo "Setting up git"
  printSeparator()

  stdout.write "Enter your git username: "
  var username: string = readLine(stdin)
  let gitUserName: string = fmt"git config --global user.name {username}"

  stdout.write "Enter your git email: "
  var email: string = readLine(stdin)
  let gitEmail: string = fmt"git config --global user.email {email}"

  discard execShellCmd(gitUserName)
  discard execShellCmd(gitEmail)
  discard execShellCmd("git config --global credential.helper store")

proc setupSoftware() = 
  echo "\nSetting up software"
  printSeparator()

  stdout.write "Do you want to install nim, [y/N]? "
  var nimAnswer: string = readLine(stdin)

  case nimAnswer:
  of "y", "Y", "yes", "Yes":
    discard execShellCmd("curl https://nim-lang.org/choosenim/init.sh -sSf | sh")
  else:
    discard

  stdout.write "Do you want to install nvm, [y/N]? "
  var nvmAnswer: string = readLine(stdin)

  case nvmAnswer:
  of "y", "Y", "yes", "Yes":
    discard execShellCmd("curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash")
  else:
    discard

  stdout.write "Do you want to install rust, [y/N]? "
  var rustAnswer: string = readLine(stdin)

  case rustAnswer:
  of "y", "Y", "yes", "Yes":
    discard execShellCmd("curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh")
  else:
    discard

proc setupHomeDir() = 
  echo "\nSetting up home directory"
  printSeparator()

  stdout.write("Do you want to setup your home directory, [y/N]?")
  var homeDirAnswer: string = readLine(stdin)

  case homeDirAnswer:
  of "y", "Y", "Yes", "yes":
    setCurrentDir(getHomeDir())
    discard existsOrCreateDir("git")
  else: 
    discard
  

proc setupDotfiles() = 
  echo "\nSetting up dotfiles"
  printSeparator()

  stdout.write "Do you want to setup dotfiles, [y/N]? "
  var dotfilesAnswer: string = readLine(stdin)

  case dotfilesAnswer:
  of "y", "Y", "yes", "Yes":
    setCurrentDir(getHomeDir())
    setCurrentDir("git")
    discard execShellCmd("git clone https://github.com/knipferrc/dotfiles.git")
    setCurrentDir("dotfiles")

    let dest = fmt"{getHomeDir()}/.vimrc"

    copyFile(".vimrc", dest)
  else:
    discard

proc main() = 
  setupGit()
  setupSoftware()
  setupHomeDir()
  setupDotfiles()

when isMainModule:
  main()


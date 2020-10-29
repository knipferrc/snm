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
  of "n", "N", "No", "no":
    discard
  else:
    discard

  stdout.write "Do you want to install nvm, [y/N]? "
  var nvmAnswer: string = readLine(stdin)

  case nvmAnswer:
  of "y", "Y", "yes", "Yes":
    discard execShellCmd("curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash")
  of "n", "N", "No", "no":
    discard
  else:
    discard

proc main() = 
  setupGit()
  setupSoftware()

when isMainModule:
  main()

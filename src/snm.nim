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
  echo "\nSetting up software\n"
  printSeparator()

  stdout.write "Do you want to install nim, [y/N]? "
  var answer: char = readChar(stdin)

  if answer == 'y' or answer == 'Y':
    discard execShellCmd("curl https://nim-lang.org/choosenim/init.sh -sSf | sh")
  elif answer == 'n' or answer == 'N': 
    return
  else:
    return


proc main() = 
  setupGit()
  setupSoftware()

when isMainModule:
  main()

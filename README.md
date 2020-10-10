## CMake + VSCode boilerplate generator

This script will create a complete projekt setup for C++, inkluding Cmake, VSCode Build Configurations and VSCode+GDB Debug Configuration 

### Usage

- cd into an empty directory
```
mkdir my_amazing_project
cd my_amazing_project
```

- Execute this script with a name for the project
```
/path/to/script/cmake_init.sh my_amazing_project
```

- Open VSCode or Codium in that directory
```
code .
```
- Build the Project using Terminal->Run Build Task or use the Hotkey Ctrl+Shift+b. Use Run->Start Debugging or F5 to run and debug the program.
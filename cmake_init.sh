#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Please provide a name for your project"
    exit
fi

if ! [ -z "$(ls -A)" ]; then
    echo "Current directory is not empty. Exiting."
    exit
fi

PROJECT_NAME=$1
WORKSPACE_FOLDER=$(pwd)


mkdir -p .vscode
mkdir -p build
mkdir -p src
touch README.md
touch CMakeLists.txt
touch src/CMakeLists.txt
touch .gitignore
touch src/main.cpp
touch .vscode/tasks.json
touch .vscode/launch.json



cat >> .vscode/tasks.json <<EOL
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build Project",
            "type": "shell",
            "command": "cd build && cmake -DCMAKE_BUILD_TYPE=Debug .. && make",
            "problemMatcher": [
                "$gcc"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": true,
                "panel": "shared",
                "showReuseMessage": true,
                "clear": false
            }
        }
    ]
}
EOL

cat >> .vscode/launch.json <<EOL
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "start (gdb)",
            "type": "cppdbg",
            "request": "launch",
            "program": "\${workspaceFolder}/build/src/${PROJECT_NAME}",
            "args": [],
            "stopAtEntry": false,
            "cwd": "\${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty printing",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
EOL

echo "build" > .gitignore


cat >> CMakeLists.txt <<EOL
project(${PROJECT_NAME})

#C++ Standard 11
if (CMAKE_VERSION VERSION_LESS "3.1")
    if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set (CMAKE_CXX_FLAGS "\${CMAKE_CXX_FLAGS} -std=gnu++11")
    endif ()
else ()
    set (CMAKE_CXX_STANDARD 11)
endif ()


add_subdirectory(src)
EOL


README_HELPER='```'
cat >> README.md <<EOL
## ${PROJECT_NAME}

### Compile

#### Debug Version
Use VSCode Terminal->Run Build Task or 
${README_HELPER}
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Debug  ..
make
${README_HELPER}

#### Release Version

${README_HELPER}
mkdir -p build
cd build
cmake ..
make
${README_HELPER}


If successfull, the binary is at build/src
EOL


cat >> src/CMakeLists.txt <<EOL
#add more .cpp files here
add_executable(${PROJECT_NAME}
main.cpp
)
EOL

cat >> src/main.cpp <<EOL
#include <iostream>

int main(int argc, char const *argv[])
{
    std::cout << "Hello, Project ${PROJECT_NAME}" << std::endl;
    return 0;
}
EOL


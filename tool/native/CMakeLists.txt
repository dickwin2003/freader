cmake_minimum_required(VERSION 3.10)
project(freader_native C CXX)

# 同时编译 unRAR（rar 解压）和 sz7（7z 解压）两个 native 库
add_subdirectory(unrar)
add_subdirectory(lzma)

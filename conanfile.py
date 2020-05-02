from conans import ConanFile, CMake, tools

class NiobiumConan(ConanFile):
    requires = [
        "catch2/2.11.0",
        "fmt/6.0.0@bincrafters/stable",
        "spdlog/1.5.0",
        "docopt.cpp/0.6.2"
    ]
    generators = "cmake", "cmake_find_package", "cmake_paths"

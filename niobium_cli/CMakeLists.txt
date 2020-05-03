add_executable( niobium_cli src/main.cpp)
target_link_libraries( niobium_cli niobium
        Unicorn Capstone::Capstone Keystone::Keystone
        CONAN_PKG::fmt CONAN_PKG::spdlog CONAN_PKG::docopt.cpp
        )
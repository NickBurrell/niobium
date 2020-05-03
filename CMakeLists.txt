cmake_minimum_required(VERSION 3.15)

project(niobium CXX)
include(cmake/StandardProjectSettings.cmake)

include(ExternalProject)
include(FetchContent)

set(FETCH_MISSING On)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_17)

if(CMAKE_CXX_COMPIELR_ID MATCHES ".*Clang")
	option(ENABLE_BUILD_WITH_TIME_TRACE "Enable -ftime-trace" OFF)
	if(ENABLE_WITH_TIME_TRACE)
		add_compile_definitions(project_options INTERFACE -ftime-trace)
	endif()
endif()

add_library(project_warnings INTERFACE)

include(cmake/CompilerWarnings.cmake)
set_project_warnings(project_warnings)

include(cmake/Sanitizers.cmake)
enable_sanitizers(project_options)

include(cmake/Doxygen.cmake)
enable_doxygen()

include(cmake/StaticAnalyzers.cmake)

option(BUILD_SHARED_LIBS "Enable shared libraries" OFF)
option(ENABLE_TESTING "Enable test builds" ON)

option(ENABLE_PCH "Enable precompiled headers" OFF)
if(ENABLE_PCH)
	target_precompile_headers(project_options INTERFACE <vector> <string> <map> <utility>)
endif()

set(CONAN_EXTRA_REQUIRES "")
set(CONAN_EXTRA_OPTIONS "")

include(cmake/Conan.cmake)
run_conan()

if(ENABLE_TESTING)
	enable_testing()
	message(
		"Building tests."
		)
	add_subdirectory(test)
endif()

if(ENABLE_FUZZING)
	message(
		"Build fuzz tests"
		)
	add_directory(fuzz_tests)
endif()

find_package(Unicorn REQUIRED)
find_package(Capstone REQUIRED)
find_package(Keystone REQUIRED)

add_subdirectory(src)
add_subdirectory(niobium_cli)

option(ENABLE_UNITY "Enable Unity builds" OFF)
if(ENABLE_UNITY)
	set_target_properties(niobium PROPERTIES UNITY_BUILD ON)
	set_target_properties(niobium_cli PROPERTIES UNITY_BUILD ON)
endif()

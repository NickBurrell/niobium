if(BUILD_SHARED_LIBS)
	add_libary(niobium SHARED 
		niobium.cpp)
else()
	add_library(niobium STATIC
		niobium.cpp)
endif()
include_directories(${CMAKE_SOURCE_DIR}/include)
target_link_libraries(niobium PRIVATE
		Unicorn::Unicorn Capstone::Capstone Keystone::Keystone
		CONAN_PKG::fmt CONAN_PKG::spdlog
		)

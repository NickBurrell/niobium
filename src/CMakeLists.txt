set(NIOBIUM_SOURCE_FILES
		niobium.cpp loader/binary_loader.cpp system/runtime.cpp ../include/niobium-engine/runtime/runtime.h)
if(BUILD_SHARED_LIBS)
	add_libary(niobium SHARED 
		${NIOBIUM_SOURCE_FILES})
else()
	add_library(niobium STATIC
		${NIOBIUM_SOURCE_FILES})
endif()
include_directories(${CMAKE_SOURCE_DIR}/include)
target_link_libraries(niobium PRIVATE
		Unicorn Capstone::Capstone Keystone::Keystone
		CONAN_PKG::fmt CONAN_PKG::spdlog
		)

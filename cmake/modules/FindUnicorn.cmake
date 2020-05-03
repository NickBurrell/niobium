find_path(LIBUNICORN_INCLUDE_DIR
	unicorn/unicorn.h
	HINTS $ENV{UNICORNDIR}
	PATH_SUFFIXES include)

find_library(LIBUNICORN_LIBRARY
	NAMES unicorn
	HINTS $ENV{UNICORNDIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(unicorn DEFAULT_MSG LIBUNICORN_LIBRARY LIBUNICORN_INCLUDE_DIR)

if(UNICORN_FOUND)
	set(THREADS_PREFER_PTHREAD_FLAG ON)
	find_package(Threads REQUIRED)
	unset(THREADS_PREFER_PTHREAD_FLAG)

	add_library(Unicorn::Unicorn UNKNOWN IMPORTED)
	set_target_properties(Unicorn::Unicorn PROPERTIES
		IMPORTED_LOCATION ${LIBUNICORN_LIBRARY}
		INTERFACE_INCLUDE_DIRECTORIES ${LIBUNICORN_INCLUDE_DIR}
		INTERFACE_LINK_LIBRARIES Threads::Threads
		)
elseif(FETCH_MISSING)
	find_package(Patch)
	if(Patch_FOUND)
		message(STATUS "Patch found" )
	endif()

	set(UNICORN_VERSON "1.0.2-rc3")
	set(UNICORN_CONFIGURE_COMMAND "")
	set(UNICORN_BUILD_COMMAND "")
	if(WIN32)
		if(MSVC)
			set(UNICORN_CONFIGURE_COMMAND )
		else()

		endif()
	else()

	endif()
	FetchContent_Declare(
			unicorn
			GIT_REPOSITORY 		https://github.com/unicorn-engine/unicorn.git
			GIT_TAG 			${UNICORN_VERSION}
			PATCH_COMMAND       ${Patch_EXECUTABLE} ${FETCHCONTENT_BASE_DIR}/unicorn-src/CMakeLists.txt < ${PROJECT_SOURCE_DIR}/patches/unicorn-git.patch
			CONFIGURE_COMMAND 	${UNICORN_CONFIGURE_COMMAND}
			BUILD_COMMAND 		${UNICORN_BUILD_COMMAND}
	)
	FetchContent_MakeAvailable(unicorn)
	add_library(Unicorn::Unicorn INTERFACE)
	set_target_properties(Unicorn::Unicorn PROPERTIES
			INTERFACE_LINK_LIBRARIES unicorn Threads::Threads)
endif()

mark_as_advanced(LIBUNICORN_INCLUDE_DIR LIBUNICORN_LIBRARY)

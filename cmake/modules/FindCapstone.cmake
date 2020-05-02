find_path(LIBCAPSTONE_INCLUDE_DIR
        capstone/capstone.h
        HINTS $ENV{CAPSTONEDIR}
        PATH_SUFFIXES include)

find_library(LIBCAPSTONE_LIBRARY
        NAMES capstone
        HINTS $ENV{CAPSTONEDIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(capstone DEFAULT_MSG LIBCAPSTONE_LIBRARY LIBCAPSTONE_INCLUDE_DIR)

if(CAPSTONE_FOUND)
    set(THREADS_PREFER_PTHREAD_FLAG ON)
    find_package(Threads REQUIRED)
    unset(THREADS_PREFER_PTHREAD_FLAG)

    add_library(Capstone::Capstone UNKNOWN IMPORTED)
    set_target_properties(Capstone::Capstone PROPERTIES
            IMPORTED_LOCATION ${LIBCAPSTONE_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${LIBCAPSTONE_INCLUDE_DIR}
            )
endif()

mark_as_advanced(LIBCAPSTONE_INCLUDE_DIR LIBCAPSTONE_LIBRARY)

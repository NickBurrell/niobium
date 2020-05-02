find_path(LIBKEYSTONE_INCLUDE_DIR
        keystone/keystone.h
        HINTS $ENV{KEYSTONEDIR}
        PATH_SUFFIXES include)

find_library(LIBKEYSTONE_LIBRARY
        NAMES keystone
        HINTS $ENV{KEYSTONEDIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(keystone DEFAULT_MSG LIBKEYSTONE_LIBRARY LIBKEYSTONE_INCLUDE_DIR)

if(KEYSTONE_FOUND)
    set(THREADS_PREFER_PTHREAD_FLAG ON)
    find_package(Threads REQUIRED)
    unset(THREADS_PREFER_PTHREAD_FLAG)

    add_library(Keystone::Keystone UNKNOWN IMPORTED)
    set_target_properties(Keystone::Keystone PROPERTIES
            IMPORTED_LOCATION ${LIBKEYSTONE_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${LIBKEYSTONE_INCLUDE_DIR}
            )
endif()

mark_as_advanced(LIBKEYSTONE_INCLUDE_DIR LIBKEYSTONE_LIBRARY)

function(enable_doxygen)
	option(ENABLE_DOXYGEN "Enable doxygen builds" OFF)
	if(ENABLE_DOXYGEN)
		set(DOXYGEN_CALLER_GRAPH ON)
		set(DOXYGEN_CALL_GRAPH ON)
		set(DOXYGEN_EXTRACT_ALL ON)

		set(DOXYGEN_PROJECT_NAME "${PROJECT_NAME}")
		set(DOXYGEN_PROJET_BRIEF "${PROJECT_BRIEF}")

		set(DOXYGEN_GENERATE_HTML YES)
		set(DOXYGEN_GENERATE_XML YES)

		find_package(Doxygen REQUIRED dot)
		doxygen_add_docs(doxygen-docs ${PROJECT_SOURCE_DIR})
	endif()
endfunction()

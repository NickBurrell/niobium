function(enable_doxygen)
	option(ENABLE_DOXYGEN "Enbale doxygen builds" OFF)
	if(ENABLE_DOXYGEN)
		set(DOXYGEN_CALLER_GRAPH ON)
		set(DOXYGEN_CALL_GRAPH ON)
		set(DOXYGEN_EXTRACT_ALL ON)
		find_package(Doxygen REQUIRED dot)
		doxygen_add_docs(doxygen-docs ${PROJECT_SOURCE_DIR})
	endif()
endfunction()

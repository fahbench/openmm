file(GLOB SOURCE_FILES
    src/*.cpp
)

add_library(openmm-cpu SHARED ${SOURCE_FILES})
target_link_libraries(openmm-cpu openmm)
target_include_directories(openmm-cpu
    PRIVATE
    include
    src
)
target_compile_definitions(openmm-cpu PRIVATE OPENMM_CPU_BUILDING_SHARED_LIBRARY)

if(${WIN32})
set_property(TARGET openmm-cpu
	PROPERTY RUNTIME_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/openmm")
else()
set_property(TARGET openmm-cpu
    PROPERTY LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/openmm")
endif()

if(${WIN32})
install(TARGETS openmm-cpu RUNTIME DESTINATION openmm)
else()
install(TARGETS openmm-cpu LIBRARY DESTINATION lib/openmm)
endif()

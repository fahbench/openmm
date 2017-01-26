file(GLOB SOURCE_FILES
	src/*.cpp
	)

file(GLOB OPENCL_KERNELS
	src/kernels/*.cl
	)
add_custom_command(OUTPUT OpenCLKernelSources.cpp OpenCLKernelSources.h
    COMMAND ${CMAKE_COMMAND}
    ARGS -D SRC_DIR="${CMAKE_CURRENT_SOURCE_DIR}" -P "${CMAKE_CURRENT_SOURCE_DIR}/EncodeCLFiles.cmake"
    DEPENDS ${OPENCL_KERNELS}
)
set(SOURCE_FILES ${SOURCE_FILES} OpenCLKernelSources.cpp)

add_library(openmm-opencl SHARED ${SOURCE_FILES})
target_link_libraries(openmm-opencl openmm ${OpenCL_LIBRARIES})

target_include_directories(openmm-opencl
	PRIVATE
	include
	src
	${CMAKE_CURRENT_BINARY_DIR}
	${OpenCL_INCLUDE_DIRS}
	)

target_compile_definitions(openmm-opencl
	PRIVATE
	OPENMM_OPENCL_BUILDING_SHARED_LIBRARY
	)

if(${WIN32})
set_property(TARGET openmm-opencl
	PROPERTY RUNTIME_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/openmm")
else()
	set_property(TARGET openmm-opencl
				 PROPERTY LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/openmm")
endif()
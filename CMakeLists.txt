
file(GLOB SOURCE_FILES
	openmmapi/src/*.cpp
	olla/src/*.cpp
	serialization/src/*.cpp
	platforms/reference/src/*.cpp
	platforms/reference/src/gbsa/*.cpp
	platforms/reference/src/SimTKReference/*.cpp
	platforms/reference/src/SimTKUtilities/*.cpp
	libraries/asmjit/base/*.cpp
	libraries/asmjit/x86/*.cpp
	libraries/csha1/src/*.cpp
	libraries/hilbert/src/*.cpp
	libraries/lbfgs/src/*.cpp
	libraries/lepton/src/*.cpp
	libraries/quern/src/*.cpp
	libraries/sfmt/src/*.cpp
	)

file(GLOB SOURCE_FILES_WIN
	 libraries/pthreads/src/*.cpp
	 )

if(MSVC)
	set(SOURCE_FILES ${SOURCE_FILES} ${SOURCE_FILES_WIN})
endif()

add_library(openmm SHARED ${SOURCE_FILES})
target_include_directories(openmm
	PRIVATE
	platforms/reference/include
	libraries/asmjit
	libraries/csha1/include
	libraries/hilbert/include
	libraries/jama/include
	libraries/lbfgs/include
	libraries/lepton/include
	libraries/quern/include
	libraries/sfmt/include
	PUBLIC
	openmmapi/include
	olla/include
	serialization/include
)
if(MSVC)
	target_include_directories(openmm
							   PRIVATE
							   libraries/pthreads/include
							   )
endif()

target_compile_definitions(openmm
	PRIVATE
	OPENMM_BUILDING_SHARED_LIBRARY
	LEPTON_BUILDING_SHARED_LIBRARY
	TIXML_USE_STL
	IEEE_8087
	LEPTON_USE_JIT
	ASMJIT_EMBED
	)
if(MSVC)
	target_compile_definitions(openmm
							   PRIVATE
							   PTHREAD_BUILDING_SHARED_LIBRARY
							   )
endif()


if(MSVC)
    target_compile_options(openmm PUBLIC /wd4267)
endif()

install(TARGETS openmm
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        )
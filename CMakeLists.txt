
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
	libraries/pthreads/src/*.cpp
	libraries/quern/src/*.cpp
	libraries/sfmt/src/*.cpp
	#libraries/validate/src/*.cpp
	)

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
	libraries/pthreads/include
	libraries/quern/include
	libraries/sfmt/include
	#libraries/validate/include
	PUBLIC
	openmmapi/include
	olla/include
	serialization/include
)
target_compile_definitions(openmm
	PRIVATE
	OPENMM_BUILDING_SHARED_LIBRARY
	LEPTON_BUILDING_SHARED_LIBRARY
	PTHREAD_BUILDING_SHARED_LIBRARY
	TIXML_USE_STL
	IEEE_8087
	LEPTON_USE_JIT
	)
target_compile_options(openmm PUBLIC /wd4267)

install(TARGETS openmm
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        )
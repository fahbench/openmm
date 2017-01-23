FILE(GLOB OPENCL_KERNELS ${SRC_DIR}/src/kernels/*.cl)
CONFIGURE_FILE(${SRC_DIR}/src/OpenCLKernelSources.cpp.in OpenCLKernelSources.cpp)
FOREACH(file ${OPENCL_KERNELS})
    # Load the file contents and process it.
    FILE(STRINGS ${file} file_content NEWLINE_CONSUME)
    # Replace all backslashes by double backslashes as they are being put in a C string.
    # Be careful not to replace the backslash before a semicolon as that is the CMAKE
    # internal escaping of a semicolon to prevent it from acting as a list seperator.
    STRING(REGEX REPLACE "\\\\([^;])" "\\\\\\\\\\1" file_content "${file_content}")
    # Escape double quotes as being put in a C string.
    STRING(REPLACE "\"" "\\\"" file_content "${file_content}")
    # Split in separate C strings for each line.
    STRING(REPLACE "\n" "\\n\"\n\"" file_content "${file_content}")

    # Determine a name for the variable that will contain this file's contents
    FILE(RELATIVE_PATH filename ${SRC_DIR}/src/kernels ${file})
    STRING(LENGTH ${filename} filename_length)
    MATH(EXPR filename_length ${filename_length}-3)
    STRING(SUBSTRING ${filename} 0 ${filename_length} variable_name)

    # Record the variable declaration and definition.
	SET(CL_FILE_DECLARATIONS ${CL_FILE_DECLARATIONS}static\ const\ std::string\ ${variable_name};\n)
    FILE(APPEND OpenCLKernelSources.cpp const\ string\ OpenCLKernelSources::${variable_name}\ =\ \"${file_content}\"\;\n)
ENDFOREACH(file)

CONFIGURE_FILE(${SRC_DIR}/src/OpenCLKernelSources.h.in OpenCLKernelSources.h)

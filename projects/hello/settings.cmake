cmake_minimum_required(VERSION 3.7.2)

set(project_dir "${CMAKE_CURRENT_LIST_DIR}/../../")
file(GLOB project_modules ${project_dir}/projects/*)

list(
    APPEND
        CMAKE_MODULE_PATH
        ${project_dir}/kernel
        ${project_dir}/tools/seL4/cmake-tool/helpers/
        ${project_dir}/tools/seL4/elfloader-tool/
        ${project_modules}
)

# set(SEL4_CONFIG_DEFAULT_ADVANCED ON)
if(SIMULATION)
	include(simulation)
endif()
include(rootserver)
include(application_settings)
include(${CMAKE_CURRENT_LIST_DIR}/easy-settings.cmake)

correct_platform_strings()

find_package(seL4 REQUIRED)
find_package(musllibc REQUIRED)
find_package(util_libs REQUIRED)
find_package(seL4_libs REQUIRED)
find_package(elfloader-tool REQUIRED)

# Platform config
sel4_configure_platform_settings()

# Import kernel, elfloader
sel4_import_kernel()
elfloader_import_project()

# Import libraries
sel4_import_libsel4()
util_libs_import_libraries()
sel4_libs_import_libraries()

# Set up environment build flags and imports musllibc and runtime libraries
musllibc_setup_build_environment_with_sel4runtime()


cmake_minimum_required(VERSION 3.7.2)

project(helloworld C CXX ASM) # create a new C project called 'Hello' 

include(settings.cmake)

# We must build the debug kernel because the tutorials rely on seL4_DebugPutChar
# and they don't initialize a platsupport driver.
ApplyCommonReleaseVerificationSettings(FALSE FALSE)

add_executable(helloworld src/main.c) # add files to our project. Paths are relative to this file.

target_link_libraries(helloworld sel4muslcsys  muslc) # we need to link against the standard C lib for printf

# Set this image as the rootserver
DeclareRootserver(helloworld)

if(SIMULATION)
        ApplyCommonSimulationSettings(${KernelSel4Arch})
        GenerateSimulateScript()
else()
        if(KernelArchX86)
                set(KernelIOMMU ON CACHE BOOL "" FORCE)
        endif()
endif()

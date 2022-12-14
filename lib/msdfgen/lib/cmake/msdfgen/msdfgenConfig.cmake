
include(CMakeFindDependencyMacro)

set(MSDFGEN_CORE_ONLY OFF)
set(MSDFGEN_USE_OPENMP OFF)
set(MSDFGEN_USE_SKIA OFF)
set(MSDFGEN_STANDALONE_AVAILABLE ON)

if(NOT MSDFGEN_CORE_ONLY)
    find_dependency(Freetype REQUIRED)
endif()
if(MSDFGEN_USE_SKIA)
    find_dependency(Skia REQUIRED)
endif()
if(MSDFGEN_USE_OPENMP)
    find_dependency(OpenMP REQUIRED COMPONENTS CXX)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/msdfgenTargets.cmake")

if(NOT MSDFGEN_CORE_ONLY)
    if(${CMAKE_VERSION} VERSION_LESS "3.18.0")
        set_target_properties(msdfgen::msdfgen-all PROPERTIES IMPORTED_GLOBAL TRUE)
    endif()
    add_library(msdfgen::msdfgen ALIAS msdfgen::msdfgen-all)
endif()

if(MSDFGEN_STANDALONE_AVAILABLE)
    include("${CMAKE_CURRENT_LIST_DIR}/msdfgenBinaryTargets.cmake")
    if(${CMAKE_VERSION} VERSION_LESS "3.18.0")
        set_target_properties(msdfgen-standalone::msdfgen PROPERTIES IMPORTED_GLOBAL TRUE)
    endif()
    add_executable(msdfgen::msdfgen-run ALIAS msdfgen-standalone::msdfgen)
    set(MSDFGEN_EXECUTABLE "/usr/local/bin/msdfgen")
endif()

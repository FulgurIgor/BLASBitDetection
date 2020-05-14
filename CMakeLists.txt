cmake_minimum_required(VERSION 3.17)

project(BlasBit)

enable_language(Fortran)

set(SOURCES
src/main.F90
)

option(USE_STATIC "Build static DDOT_BLAS library" OFF)
message(STATUS "Build static DDOT_BLAS library: " ${USE_STATIC})

if(USE_STATIC)
  set(LIBRARY_TYPE "static")
else()
  set(LIBRARY_TYPE "shared")
endif()

add_subdirectory(BLAS)
link_directories(${CMAKE_BINARY_DIR}/BLAS)

foreach(PROGRAM_BIT 32 64)
  foreach(LIBRARY_BIT 32 64)
    add_executable       (${PROJECT_NAME}${PROGRAM_BIT}_${LIBRARY_BIT} ${SOURCES})
    target_link_libraries(${PROJECT_NAME}${PROGRAM_BIT}_${LIBRARY_BIT} DDOT_BLAS${LIBRARY_BIT})
    add_dependencies     (${PROJECT_NAME}${PROGRAM_BIT}_${LIBRARY_BIT} DDOT_BLAS${LIBRARY_BIT}-${LIBRARY_TYPE})
    set_target_properties(${PROJECT_NAME}${PROGRAM_BIT}_${LIBRARY_BIT} PROPERTIES COMPILE_FLAGS "-DIP=4 -DLIBRARY=${LIBRARY_BIT} -DPROGRAM=${PROGRAM_BIT}")
  endforeach()
endforeach()

cmake_minimum_required(VERSION 3.9)

project(BlasBit)

enable_language(Fortran)

set(SOURCES
src/main.F90
)

option(USE_BLAS "Linking with BLAS or with DDOT_BLAS" OFF)
message(STATUS "Linking with BLAS or with DDOT_BLAS: " ${USE_BLAS})

if("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "GNU")
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fno-backtrace")
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fno-range-check")
endif()

if(USE_BLAS)

  find_package(BLAS REQUIRED)

  message(STATUS "BLAS LIBRARY: " ${BLAS_LIBRARIES})

  foreach(PROGRAM_BIT 32 64)
    math(EXPR IP "${PROGRAM_BIT} / 8")
    add_executable       (${PROJECT_NAME}${PROGRAM_BIT}_BLAS ${SOURCES})
    target_link_libraries(${PROJECT_NAME}${PROGRAM_BIT}_BLAS ${BLAS_LIBRARIES})
    set_target_properties(${PROJECT_NAME}${PROGRAM_BIT}_BLAS PROPERTIES COMPILE_FLAGS "-DIP=${IP} -DLIBRARY=0 -DPROGRAM=${PROGRAM_BIT}")
  endforeach()

else()

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
    math(EXPR IP "${PROGRAM_BIT} / 8")
    foreach(LIBRARY_BIT 32 64)
      add_executable       (${PROJECT_NAME}${PROGRAM_BIT}_${LIBRARY_BIT} ${SOURCES})
      target_link_libraries(${PROJECT_NAME}${PROGRAM_BIT}_${LIBRARY_BIT} DDOT_BLAS${LIBRARY_BIT})
      add_dependencies     (${PROJECT_NAME}${PROGRAM_BIT}_${LIBRARY_BIT} DDOT_BLAS${LIBRARY_BIT}-${LIBRARY_TYPE})
      set_target_properties(${PROJECT_NAME}${PROGRAM_BIT}_${LIBRARY_BIT} PROPERTIES COMPILE_FLAGS "-DIP=${IP} -DLIBRARY=${LIBRARY_BIT} -DPROGRAM=${PROGRAM_BIT}")
    endforeach()
  endforeach()

endif()

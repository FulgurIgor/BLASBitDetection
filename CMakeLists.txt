cmake_minimum_required(VERSION 3.17)

project(BlasBit)

enable_language(Fortran)

set(SOURCES
src/main.F90
)

add_subdirectory(BLAS)

link_directories(${CMAKE_BINARY_DIR}/BLAS)

add_executable(${PROJECT_NAME}32_32 ${SOURCES})
target_link_libraries(${PROJECT_NAME}32_32 DDOT_BLAS32)
set_target_properties(${PROJECT_NAME}32_32 PROPERTIES COMPILE_FLAGS "-DIP=4 -DLIBRARY=32 -DPROGRAM=32")

add_executable(${PROJECT_NAME}32_64 ${SOURCES})
target_link_libraries(${PROJECT_NAME}32_64 DDOT_BLAS64)
set_target_properties(${PROJECT_NAME}32_64 PROPERTIES COMPILE_FLAGS "-DIP=4 -DLIBRARY=64 -DPROGRAM=32")

add_executable(${PROJECT_NAME}64_32 ${SOURCES})
target_link_libraries(${PROJECT_NAME}64_32 DDOT_BLAS32)
set_target_properties(${PROJECT_NAME}64_32 PROPERTIES COMPILE_FLAGS "-DIP=8 -DLIBRARY=32 -DPROGRAM=64")

add_executable(${PROJECT_NAME}64_64 ${SOURCES})
target_link_libraries(${PROJECT_NAME}64_64 DDOT_BLAS64)
set_target_properties(${PROJECT_NAME}64_64 PROPERTIES COMPILE_FLAGS "-DIP=8 -DLIBRARY=64 -DPROGRAM=64")


cmake_minimum_required(VERSION 3.10)

project(DDOT_BLAS)
enable_language(Fortran)

set(SOURCES
DDOT.F)

add_library(${PROJECT_NAME}32Static STATIC ${SOURCES})
add_library(${PROJECT_NAME}32Shared SHARED ${SOURCES})

set_target_properties(${PROJECT_NAME}32Static PROPERTIES COMPILE_FLAGS "-DIP=4")
set_target_properties(${PROJECT_NAME}32Shared PROPERTIES COMPILE_FLAGS "-DIP=4")

set_target_properties(${PROJECT_NAME}32Static PROPERTIES OUTPUT_NAME ${PROJECT_NAME}32)
set_target_properties(${PROJECT_NAME}32Shared PROPERTIES OUTPUT_NAME ${PROJECT_NAME}32)

add_library(${PROJECT_NAME}64Static STATIC ${SOURCES})
add_library(${PROJECT_NAME}64Shared SHARED ${SOURCES})

set_target_properties(${PROJECT_NAME}64Static PROPERTIES COMPILE_FLAGS "-DIP=8")
set_target_properties(${PROJECT_NAME}64Shared PROPERTIES COMPILE_FLAGS "-DIP=8")

set_target_properties(${PROJECT_NAME}64Static PROPERTIES OUTPUT_NAME ${PROJECT_NAME}64)
set_target_properties(${PROJECT_NAME}64Shared PROPERTIES OUTPUT_NAME ${PROJECT_NAME}64)

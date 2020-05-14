cmake_minimum_required(VERSION 3.10)

project(DDOT_BLAS)
enable_language(Fortran)

set(SOURCES
DDOT.F)

add_library(${PROJECT_NAME}32-static STATIC ${SOURCES})
add_library(${PROJECT_NAME}32-shared SHARED ${SOURCES})

set_target_properties(${PROJECT_NAME}32-static PROPERTIES COMPILE_FLAGS "-DIP=4")
set_target_properties(${PROJECT_NAME}32-shared PROPERTIES COMPILE_FLAGS "-DIP=4")

set_target_properties(${PROJECT_NAME}32-static PROPERTIES OUTPUT_NAME ${PROJECT_NAME}32)
set_target_properties(${PROJECT_NAME}32-shared PROPERTIES OUTPUT_NAME ${PROJECT_NAME}32)

add_library(${PROJECT_NAME}64-static STATIC ${SOURCES})
add_library(${PROJECT_NAME}64-shared SHARED ${SOURCES})

set_target_properties(${PROJECT_NAME}64-static PROPERTIES COMPILE_FLAGS "-DIP=8")
set_target_properties(${PROJECT_NAME}64-shared PROPERTIES COMPILE_FLAGS "-DIP=8")

set_target_properties(${PROJECT_NAME}64-static PROPERTIES OUTPUT_NAME ${PROJECT_NAME}64)
set_target_properties(${PROJECT_NAME}64-shared PROPERTIES OUTPUT_NAME ${PROJECT_NAME}64)

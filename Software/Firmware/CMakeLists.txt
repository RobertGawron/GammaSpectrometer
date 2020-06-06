cmake_minimum_required(VERSION 3.2)
set(CMAKE_C_OUTPUT_EXTENSION ".rel")
set(CMAKE_C_COMPILER sdcc)
set(CMAKE_SYSTEM_NAME Generic) # No linux target etc

# Prevent default configuration
set(CMAKE_C_FLAGS_INIT "")
set(CMAKE_EXE_LINKER_FLAGS_INIT "")
project(STM8Blink C)
SET(CMAKE_C_FLAGS "-mstm8 -DSTM8S003 -D__SDCC__ -DUSE_STDPERIPH_DRIVER")

# Flash targets
#add_custom_target(flash ALL COMMAND stm8flash -c stlink -p stm8s105c6 -w main.ihx)

set(CMAKE_STATIC_LIBRARY_PREFIX "")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".lib")
set(CMAKE_SHARED_LIBRARY_PREFIX "")          # lib
set(CMAKE_SHARED_LIBRARY_SUFFIX ".lib")          # .so
set(CMAKE_IMPORT_LIBRARY_PREFIX )
set(CMAKE_IMPORT_LIBRARY_SUFFIX )
set(CMAKE_EXECUTABLE_SUFFIX ".ihx")          # intel hex file
set(CMAKE_LINK_LIBRARY_SUFFIX ".lib")
set(CMAKE_DL_LIBS "")

include_directories(${CMAKE_SOURCE_DIR}/Inc)
include_directories(${CMAKE_SOURCE_DIR}/STM8S_StdPeriph_Lib/inc)

add_executable(PhotomultiplierRadioactivityDetector
        Src/main.c
        Src/ApplicationBuilder.c
        Src/ClockConfigurator.c
        Src/MeasurementFrame
        Src/UserInterface.c
        Src/stm8s_it.c
        Src/Logger.c
        Src/MeasurementCollector.c
        Src/TimerConfigurator.c
        Src/VoltageSensorActualValue.c

        STM8S_StdPeriph_Lib/src/stm8s_gpio.c
        STM8S_StdPeriph_Lib/src/stm8s_i2c.c
        STM8S_StdPeriph_Lib/src/stm8s_tim1.c
        STM8S_StdPeriph_Lib/src/stm8s_clk.c
        STM8S_StdPeriph_Lib/src/stm8s_uart1.c)

# flash targets
#add_custom_target(flash ALL COMMAND stm8flash -c stlink -p stm8s003f3  -w PhotomultiplierRadioactivityDetector.ihx)


# generate doxygen docs and dependency graphs
#add_custom_target(doc ALL COMMAND doxygen doxygen.cfg)

# format source code
#add_custom_target(formatting ALL COMMAND uncrustify -c uncrustify.cfg --no-backup Src/*.c  Inc/*.h)


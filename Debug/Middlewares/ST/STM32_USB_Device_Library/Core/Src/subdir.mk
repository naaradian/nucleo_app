################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.c \
../Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.c \
../Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.c 

OBJS += \
./Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.o \
./Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.o \
./Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.o 

C_DEPS += \
./Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.d \
./Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.d \
./Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.d 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/ST/STM32_USB_Device_Library/Core/Src/%.o: ../Middlewares/ST/STM32_USB_Device_Library/Core/Src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -D_TIMEVAL_DEFINED -D_SYS_TIME_H_ '-D__weak=__attribute__((weak))' '-D__packed=__attribute__((__packed__))' -DUSE_HAL_DRIVER -DSTM32F429xx -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Inc" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/system" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Drivers/STM32F4xx_HAL_Driver/Inc" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Drivers/STM32F4xx_HAL_Driver/Inc/Legacy" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include/netif/ppp" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/ST/STM32_USB_Device_Library/Core/Inc" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Drivers/CMSIS/Device/ST/STM32F4xx/Include" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/FreeRTOS/Source/include" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include/lwip" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include/lwip/apps" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include/lwip/priv" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include/lwip/prot" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include/netif" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include/posix" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/src/include/posix/sys" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Middlewares/Third_Party/LwIP/system/arch" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Drivers/CMSIS/Include" -I"D:/Users/user/keil/stm32cubemx/three_discav/nucleo144_tcp_udp_uart/Inc"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '



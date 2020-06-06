/*
 * ClockConfigurator.c
 *
 *  Created on: 03.07.2019
 *      Author: robert
 */

#include "ClockConfigurator.h"
#include "stm8s_clk.h"

void ClockConfigurator_Init()
{
    CLK_DeInit();

    CLK_HSECmd(DISABLE);
    CLK_LSICmd(DISABLE);
    CLK_HSICmd(ENABLE);
    while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);

    CLK_ClockSwitchCmd(ENABLE);
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
    //CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);

    CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO,
                          CLK_SOURCE_HSI,
                          DISABLE,
                          CLK_CURRENTCLOCKSTATE_ENABLE);

    CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
}


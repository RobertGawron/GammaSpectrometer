/*
 * UserInterface.c
 *
 *  Created on: 30.06.2019
 *      Author: robert
 */

#include "UserInterface.h"

#include "PinoutConfiguration.h"

#define GPIO_LED_PINS (PIN_GPIO_LED_GREEN | PIN_GPIO_LED_RED)

void UserInterface_Init()
{
    GPIO_Init(PORT_GPIO_LED, GPIO_LED_PINS,  GPIO_MODE_OUT_PP_LOW_SLOW);
    GPIO_WriteLow(PORT_GPIO_LED, GPIO_LED_PINS);
}


void UserInterface_Tick()
{
}


void UserInterface_ShowMessage(UserInterface_Status status)
{
    switch(status)
    {
        case USER_INTERFACE_COLLECTING_DATA_MSG:
        {
            GPIO_WriteHigh(PORT_GPIO_LED, PIN_GPIO_LED_RED);
            break;
        }

        case USER_INTERFAE_STATE_OK_MSG:
        {
            GPIO_WriteHigh(PORT_GPIO_LED, PIN_GPIO_LED_GREEN);
            break;
        }
    }
}


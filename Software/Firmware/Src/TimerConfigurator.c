/*
 * TimerConfigurator.c
 *
 *  Created on: 06.07.2019
 *      Author: robert
 */

#include "TimerConfigurator.h"
#include "stm8s_tim1.h"

void TimerConfigurator_Init()
{
    TIM1_TimeBaseInit(512, TIM1_COUNTERMODE_UP, 65535, 0);
    TIM1_Cmd(ENABLE);
    TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE);
}


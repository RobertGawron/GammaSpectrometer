/*
 * ApplicationBuilder.c
 *
 *  Created on: 15 cze 2019
 *      Author: robert
 */

#include "ApplicationBuilder.h"
#include "PinoutConfiguration.h"
#include "ClockConfigurator.h"
#include "TimerConfigurator.h"
#include "Logger.h"
#include "UserInterface.h"
#include "VoltageSensorActualValue.h"
#include "MeasurementCollector.h"

void ApplicationBuilder_Init()
{
    ClockConfigurator_Init();
    TimerConfigurator_Init();
    Logger_Init();
    UserInterface_Init();
    VoltageSensorActualValue_Init();
    MeasurementCollector_Init();

    enableInterrupts();

    UserInterface_ShowMessage(USER_INTERFAE_STATE_OK_MSG);
}


void ApplicationBuilder_Run()
{
    while(TRUE)
    {
        /* Wait in idle state. Business logic is triggered via interrupt. */
        wfi();
    }
}


void ApplicationBuilder_Tick()
{
    MeasurementCollector_Tick();
    UserInterface_Tick();
}


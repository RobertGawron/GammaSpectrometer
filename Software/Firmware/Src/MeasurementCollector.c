/*
 * MeasurementCollector.c
 *
 *  Created on: 15 cze 2019
 *      Author: robert
 */

#include "MeasurementCollector.h"
#include "VoltageSensorActualValue.h"
#include "MeasurementFrame.h"
#include "Logger.h"


void MeasurementCollector_Init()
{
}


void MeasurementCollector_Tick()
{
    uint8_t configuration = VoltageSensorActualValue_GetConfiguration();

    VoltageSensorActualValue_MeasurementData_t sample;
    VoltageSensorActualValue_MeasureValue(&sample);

    MeasurementFrame_Create(configuration, sample);
    MeasurementFrame_Send(&Logger_Print);
}


/*
 * MeasurementFrame.c
 *
 *  Created on: 06.07.2019
 *      Author: robert
 */

#include "MeasurementFrame.h"
#include "BitHandler.h"

#define MAX_FRAME_LENGTH 5
#define FRAME_SEND_MEASSUREMENT_ID 1

#define GET_CRC(configuration, data) (configuration ^ GET_MSB(data) ^ GET_LSB(data))


enum Frameffsets { FRAME_PREAMBLE=0,
                   FRAME_CONFIGURATION=1,
                   FRAME_DATA_MSB=2,
                   FRAME_DATA_LSB=3,
                   FRAME_CRC=4 };

static uint8_t buffer[MAX_FRAME_LENGTH];


void MeasurementFrame_Create(uint8_t configuration, uint16_t data)
{
    buffer[FRAME_PREAMBLE] = (FRAME_SEND_MEASSUREMENT_ID << 4) | MAX_FRAME_LENGTH;
    buffer[FRAME_CONFIGURATION] = configuration;
    buffer[FRAME_DATA_MSB] = GET_MSB(data);
    buffer[FRAME_DATA_LSB] = GET_LSB(data);
    buffer[FRAME_CRC] = GET_CRC(configuration, data);
}


bool MeasurementFrame_Send(void (*sendFunction)(uint8_t))
{
    uint8_t i = 0; 
    for(i = 0; i < MAX_FRAME_LENGTH; i++)
    {
        sendFunction(buffer[i]);
    }

    // TODO this should return status of sending data
    return TRUE;
}


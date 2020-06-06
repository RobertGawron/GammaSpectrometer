/*
 * MCP3425A0T.c
 *
 *  Created on: 04.06.2019
 *      Author: robert
 */

#include "VoltageSensorActualValue.h"
#include "PinoutConfiguration.h"
#include "UserInterface.h"
#include "stm8s_i2c.h"


#define I2C_MASTER_ADDRESS 0x10
// MCP3425 I2C address is 0x68(104), this 7 bits, they need to be
// shifted by one, to make 8 bits variable, where less signifant bit
// is used to signalize communication direction (rx or tx)
#define I2C_SLAVE_ADDRESS (0x68u << 1)

#define MCP3425_REG_BIT_READY             (1 << 7)
#define MCP3425_REG_BIT_CONVERSION        (1 << 4)
#define MCP3425_REG_BIT_SAMPLE_RATE_UPPER (1 << 3)
#define MCP3425_REG_BIT_SAMPLE_RATE_LOWER (1 << 2)
#define MCP3425_REG_BIT_GAIN_UPPER        (1 << 1)
#define MCP3425_REG_BIT_GAIN_LOWER        (1 << 0)

#define MCP3425_CONFIGURATION (MCP3425_REG_BIT_READY | MCP3425_REG_BIT_SAMPLE_RATE_UPPER)
#define MCP3425_READ_MEASSUREMENT 0x10

static void GPIO_setup(void);
static void I2C_setup(void);
static void write(uint8_t registerId);
static uint16_t read(uint8_t registerId);


void VoltageSensorActualValue_Init()
{
    GPIO_setup();
    I2C_setup();
}


bool VoltageSensorActualValue_MeasureValue(VoltageSensorActualValue_MeasurementData_t *measurementData)
{
    // select adc configuration and start measurement
    write(MCP3425_CONFIGURATION);

    *measurementData = read(0);

    // getRegisterValue should return false on timeout and this should be later propagated to GUI component
    return TRUE;
}


uint8_t VoltageSensorActualValue_GetConfiguration()
{
    return MCP3425_CONFIGURATION;
}


void GPIO_setup(void)
{
    GPIO_Init(PORT_I2C, PIN_I2C_SCL, GPIO_MODE_OUT_OD_HIZ_FAST);
    GPIO_Init(PORT_I2C, PIN_I2C_SDA, GPIO_MODE_OUT_OD_HIZ_FAST);
}


void I2C_setup(void)
{
    // TODO magic numbers
    I2C_DeInit();
    I2C_Init(100000,
             I2C_MASTER_ADDRESS,
             I2C_DUTYCYCLE_2,
             I2C_ACK_CURR,
             I2C_ADDMODE_7BIT,
             (CLK_GetClockFreq() / 1000000));
    I2C_Cmd(ENABLE);
}


static void write(uint8_t registerId)
{
    I2C_GenerateSTART(ENABLE);
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));

    I2C_Send7bitAddress(I2C_SLAVE_ADDRESS, I2C_DIRECTION_TX);
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));

    I2C_SendData(registerId);
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_TRANSMITTED));

    I2C_GenerateSTOP(ENABLE);
    while(I2C_GetFlagStatus(I2C_FLAG_BUSBUSY));
}


static uint16_t read(uint8_t registerId)
{
    uint16_t registerMSB = 0; 
    uint16_t registerLSB = 0;
    uint16_t registerValue = 0;

    I2C_GenerateSTART(ENABLE);
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));

    I2C_Send7bitAddress(I2C_SLAVE_ADDRESS, I2C_DIRECTION_RX);
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED));
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED));


    registerMSB = I2C_ReceiveData();
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED));

    registerLSB = I2C_ReceiveData();
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED));

    I2C_ReceiveData();
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED));

    I2C_ReceiveData();
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED));

    I2C_ReceiveData();
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED));

    I2C_ReceiveData();
    while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED));


    I2C_AcknowledgeConfig(DISABLE);
    I2C_GenerateSTOP(ENABLE);

    I2C_AcknowledgeConfig(ENABLE);

    registerValue = (registerMSB << 8) +  registerLSB;

    return registerValue;
}


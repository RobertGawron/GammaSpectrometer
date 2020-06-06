/*
 * PinoutConfiguration.h
 *
 *  Created on: 15 cze 2019
 *      Author: robert
 */
#include "CommonDataTypes.h"

#ifndef INC_PINOUTCONFIGURATION_H_
#define INC_PINOUTCONFIGURATION_H_

#define PIN_ADC_CHIP_1    1
#define PIN_ADC_CHIP_2    2

#define PIN_PULSE_COUNTER 3

#define PORT_UART GPIOD
#define PIN_TX    GPIO_PIN_5
#define PIN_RX    GPIO_PIN_6

#define PORT_GPIO_LED       GPIOD
#define PIN_GPIO_LED_GREEN  GPIO_PIN_2
#define PIN_GPIO_LED_RED    GPIO_PIN_3

#define PORT_I2C GPIOB
#define PIN_I2C_SCL GPIO_PIN_4
#define PIN_I2C_SDA GPIO_PIN_5

#endif /* INC_PINOUTCONFIGURATION_H_ */

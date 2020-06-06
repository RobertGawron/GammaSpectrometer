/*
 * DataLogger.c
 *
 *  Created on: 16.06.2019
 *      Author: robert
 */

#include "Logger.h"
#include "stm8s_uart1.h"
#include "PinoutConfiguration.h"


//#define USE_PRINTF
#if defined USE_PRINTF
    #include <stdio.h>
#endif

#define UART_SPEED 9600


static void GPIO_setup(void);
static void UART1_setup(void);


#if defined USE_PRINTF
int putchar(int c)
#else
void putchar(char c)
#endif
{
    /* Write a character to the UART1 */
    UART1_SendData8(c);
    /* Loop until the end of transmission */
    while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
}


void Logger_Init()
{
    GPIO_setup();
    UART1_setup();
}


void Logger_Print(Logger_DataFormat_t data)
{
#if defined USE_PRINTF
    printf("%d\n\r", data);
#else
    putchar(data);
#endif
}

#ifdef USE_FULL_ASSERT
// cppcheck-suppress unusedFunction
void assert_failed(uint8_t* file, uint32_t line)
{
    (void)file;
    (void)line;

#if defined USE_PRINTF
    printf("[error] asset failed %s %u\r\n", file, line);
#endif

    while(TRUE);
}
#endif


void GPIO_setup(void)
{
    GPIO_DeInit(PORT_UART);

    GPIO_Init(PORT_UART, PIN_TX, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(PORT_UART, PIN_RX, GPIO_MODE_IN_PU_NO_IT);
}


void UART1_setup(void)
{
    UART1_DeInit();

    UART1_Init(UART_SPEED,
               UART1_WORDLENGTH_8D,
               UART1_STOPBITS_1,
               UART1_PARITY_NO,
               UART1_SYNCMODE_CLOCK_DISABLE,
               UART1_MODE_TXRX_ENABLE);

    UART1_Cmd(ENABLE);
}


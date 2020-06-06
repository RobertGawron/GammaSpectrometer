/*
 * main.c
 *
 *  Created on: 04.06.2019
 *  Author: robert. Based on stm8s-sdcc-template.
 */
#include "stm8s.h"
#include "stm8s_it.h"
#include "ApplicationBuilder.h"

int main( void )
{
    ApplicationBuilder_Init();
    ApplicationBuilder_Run();

    return 0;
}


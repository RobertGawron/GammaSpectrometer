/*
 * UserInterface.h
 *
 *  Created on: 30.06.2019
 *      Author: robert
 */

#ifndef SRC_GUI_H_
#define SRC_USER_INTERFACE_H_

typedef enum UserInterface_Status { USER_INTERFACE_COLLECTING_DATA_MSG, USER_INTERFAE_STATE_OK_MSG } UserInterface_Status;

void UserInterface_Init();

void UserInterface_Tick();

void UserInterface_ShowMessage(UserInterface_Status status);

#endif /* SRC_GUI_H_ */

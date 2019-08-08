# UVM

Yapp Project : Lab01
---------------------
Contains only yapp package's initial sequence item and environment and it's being tested by 
creating an instance of env in yapp_basic_testcase. 

To test the Yapp UVC created,Yapp_basic_testcase is being invoked in top file and the sequence item 
has been randomized and its content printed. Basic hierarchy checked in this lab is :

TB_Top -> Yapp_Testcase -> Yapp_Env -> Yapp_sequence

Sequence and driver for Yapp UVC have not been created yet. Other UVCs such as HBUS UVC and Channel's
reactive UVCs will be constructed in the upcoming Labs. 

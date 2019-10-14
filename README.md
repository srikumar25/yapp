# UVM

Yapp Project : Lab04
---------------------
Contains yapp,hbus active UVC on the master side and channels 0,1 & 2 reactive UVC on the slave side.

To test the Yapp UVC created,Yapp_basic_testcase is being invoked in top file and the sequence item 
has been randomized and its content printed. 

Currently all the different channels are being tested by writing to the different channel interfaces 
through addresses. Currently all the writes which are being sent from the input side are being tapped 
through the output interface of different channels and they're checked for validity through the scoreboard.

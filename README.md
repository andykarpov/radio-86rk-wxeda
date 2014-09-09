# Radio-86RK FPGA replica on ZR-TECH WXEDA board

## Overview

This project is a **Radio-86RK** port of the original Altera DE1 project by Dmitry Tselikov aka **b2m** on *Zr-Tech WXEDA board*.

All copyrights are going to Dmitry Tselikov <http://bashkiria-2m.narod.ru/>. 

Please see LICENSE.TXT for more information.

SD card mod for WXEDA board are going to Viacheslav Slavinsky aka **svofski** <http://sensi.org/~svo>

SVGA 800x600 implementation is going to Andy Karpov <andy.karpov@gmail.com>

Discussion about this project (including Altera DE1 implementation) is located here: <http://zx-pk.ru/showthread.php?t=12985>

## Hardware part

This port is designed to run on cheap (under $50 with free shimpent) chinese Cyclone IV (EP4CE6E22C8) development board, like this one: <http://www.aliexpress.com/item/New-Arrival-Altera-Cyclone-IV-FPGA-EP4CE6E22C8N-Chipset-Development-Board-USB-Cable-Remote-Control-P0013160-Free/1795346213.html>. 

![image](http://i01.i.aliimg.com/wsphoto/v0/1795346213_1/New-Arrival-Altera-Cyclone-IV-FPGA-EP4CE6E22C8N-Chipset-Development-Board-USB-Cable-Remote-Control-P0013160-Free.jpg)

To use an SD card a hardware mod is required. You need to solder down an sd card connector to some free pins, like described here: <http://zx-pk.ru/showthread.php?t=8635&page=31> 

![image](https://farm6.staticflickr.com/5538/14605123051_f9a3cf9b69_m.jpg)

SD card should be formatted as FAT16 filesystem. Place *.RKA files in the root of the filesystem.

Sound output uses internal buzzer.

## Software part

To compile the project, you need at least Quartus II v 13.0sp1 Web Edition <http://dl.altera.com/13.0sp1/?edition=web> with Cyclone IV support. 

To run confifuration automatially when board powering on, you need to perform the following steps:

1. Convert *sof*-firmware into *jic* using rk_wxeda_epcs4_jic.cof convertor config;
2. Upload it via JTAG to the on-board EPCS4 serial flash memory. 

### Plans for the nearest future

1. Make tape in / tape out working;
2. Make S-Video signal generation;
3. Design a "shield" to apply SD card and audio / video connectors to this board.


### Contribution

Please feel free to ask a questions as well as help and support to this project. Please send your bug-reports and pull-requests via github project <https://github.com/andykarpov/radio-86rk-wxeda>

-._

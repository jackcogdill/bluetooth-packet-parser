# Bluetooth Packet Parser

## About

This bluetooth packet parser is written in [Octave](https://www.gnu.org/software/octave/) (an open source clone of Matlab) for security research at the [Hume Center](http://hume.vt.edu/) at Virginia Tech.

## Usage

Use `src/test_parse.m` to test parsing a bluetooth packet

Use `src/demodulate.m` to demodulate binary data file into a vector of 1s and 0s  
Use `src/convert_data.m` to convert the 1s and 0s into a string  
Use `find_packets.m` to find the packets within the string data and parse them to the terminal

## Sample output

![Image](http://i.imgur.com/FZEddcM.png)

/*
Description:	Interfacing a NES controller with a PC with an Arduino.
Coded by:	Prodigity
Date:		1 December 2011
Revision:	V0.93 (beta)
Modified by:    Matt Booth (20 December 2014)
*/

const int latch = 2;
const int clock = 3;
const int data  = 4;

#define latchlow digitalWrite(latch, LOW)
#define latchhigh digitalWrite(latch, HIGH)
#define clocklow digitalWrite(clock, LOW)
#define clockhigh digitalWrite(clock, HIGH)
#define dataread digitalRead(data)

// http://www.mit.edu/~tarvizo/nes-controller.html
#define wait delayMicroseconds(12)

byte output;

void setup() {
	Serial.begin(9600);
	pinMode(latch, OUTPUT);
        pinMode(clock, OUTPUT);
        pinMode(data, INPUT);
}

void loop() {
  output = 0;
  ReadNESjoy();
  Serial.write(output);
}


void ReadNESjoy() {
  latchlow;
  clocklow;
  latchhigh;
  wait;
  latchlow;
 
  for (int i = 0; i < 8; i++) {
     output += dataread * (1 << i);
     clockhigh;
     wait;
     clocklow;
     wait;
  }
}

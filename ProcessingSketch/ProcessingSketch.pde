/*
Description:	Interfacing a NES controller with a PC with an Arduino.
Coded by:	Prodigity
Date:		1 December 2011
Revision:	V0.91 (beta)
Modified by:    Matt Booth (20 December 2014)
*/

import processing.serial.*;
import java.awt.*;
import java.awt.event.KeyEvent;

Serial arduino;

Robot VKey;

PImage bgImage;

byte recvout;
byte prevout;
byte deltaout;

void setup() {
  size(434,180);
  frameRate(60);
  println("Here is your list of COM ports:");
  println(Serial.list());
  arduino = new Serial(this, Serial.list()[0], 9600); // ATTENTION!!!
  bgImage = loadImage("NEScontroller.jpg");
  try
  {
    VKey = new Robot();
  }
  catch(AWTException a){}
  prevout = 0;
}

void draw() {
  if (bgImage != null) { background(bgImage); }
  fill(255, 255, 0);
  serialRead();
  deltaout = (byte)(recvout ^ prevout);
  emulateKeyboard();
  prevout = recvout;
}

void serialRead() {
  while (arduino.available() > 0) {
    recvout = (byte)arduino.read();
  }
}

void emulateKeyboard() {
  if ((deltaout & 1) != 0)   { if ((recvout & 1) == 0)   {VKey.keyPress(KeyEvent.VK_L);} else {VKey.keyRelease(KeyEvent.VK_L);}}
  if ((deltaout & 2) != 0)   { if ((recvout & 2) == 0)   {VKey.keyPress(KeyEvent.VK_K);} else {VKey.keyRelease(KeyEvent.VK_K);}}
  if ((deltaout & 4) != 0)   { if ((recvout & 4) == 0)   {VKey.keyPress(KeyEvent.VK_G);} else {VKey.keyRelease(KeyEvent.VK_G);}}
  if ((deltaout & 8) != 0)   { if ((recvout & 8) == 0)   {VKey.keyPress(KeyEvent.VK_H);} else {VKey.keyRelease(KeyEvent.VK_H);}}
  if ((deltaout & 16) != 0)  { if ((recvout & 16) == 0)  {VKey.keyPress(KeyEvent.VK_W);} else {VKey.keyRelease(KeyEvent.VK_W);}}
  if ((deltaout & 32) != 0)  { if ((recvout & 32) == 0)  {VKey.keyPress(KeyEvent.VK_S);} else {VKey.keyRelease(KeyEvent.VK_S);}}
  if ((deltaout & 64) != 0)  { if ((recvout & 64) == 0)  {VKey.keyPress(KeyEvent.VK_A);} else {VKey.keyRelease(KeyEvent.VK_A);}}
  if ((deltaout & 128) != 0) { if ((recvout & 128) == 0) {VKey.keyPress(KeyEvent.VK_D);} else {VKey.keyRelease(KeyEvent.VK_D);}}
}

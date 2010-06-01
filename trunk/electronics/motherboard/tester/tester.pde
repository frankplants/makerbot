//X axis pins
#define X_STEP_PIN      28
#define X_DIR_PIN       27
#define X_ENABLE_PIN    26
#define X_MIN_PIN       12
#define X_MAX_PIN       11

//Y axis pins
#define Y_STEP_PIN      25
#define Y_DIR_PIN       24
#define Y_ENABLE_PIN    23
#define Y_MIN_PIN       10
#define Y_MAX_PIN       9

//Z axis pins
#define Z_STEP_PIN      22
#define Z_DIR_PIN       17
#define Z_ENABLE_PIN    16
#define Z_MIN_PIN       8
#define Z_MAX_PIN       7

//A axis pins
#define A_STEP_PIN      15
#define A_DIR_PIN       14
#define A_ENABLE_PIN    3

//B axis pins
#define B_STEP_PIN      4
#define B_DIR_PIN       5
#define B_ENABLE_PIN    6

//our pin for debugging.
#define DEBUG_PIN        13

//our SD card pins
#define SD_CARD_WRITE    21
#define SD_CARD_DETECT   20
#define SD_CARD_SELECT   53

//our RS485 pins
#define TX_ENABLE_PIN    32
#define RX_ENABLE_PIN    30

//pin for controlling the PSU.
#define PS_ON_PIN        29

//pins for all the peripherals
#define INTERFACE_3      33
#define INTERFACE_4      34
#define INTERFACE_5      35
#define INTERFACE_6      36
#define INTERFACE_7      37
#define INTERFACE_8      38
#define INTERFACE_9      39
#define INTERFACE_10     40
#define INTERFACE_11     41
#define INTERFACE_12     42
#define INTERFACE_13     43
#define INTERFACE_14     44
#define INTERFACE_15     45
#define INTERFACE_16     46
#define INTERFACE_17     47
#define INTERFACE_18     48
#define INTERFACE_19     49
#define INTERFACE_20     13

byte LCD_RS_PIN 		= INTERFACE_3;
byte LCD_ENABLE_PIN 	= INTERFACE_4;
byte OK_PIN 			= INTERFACE_5;
byte CANCEL_PIN 		= INTERFACE_6;
byte FOO_PIN 			= INTERFACE_7;
byte LCD_D4_PIN 		= INTERFACE_8;
byte LCD_D5_PIN 		= INTERFACE_9;
byte LCD_D6_PIN 		= INTERFACE_10;
byte LCD_D7_PIN 		= INTERFACE_11;
byte X_PLUS_PIN 		= INTERFACE_12;
byte X_MINUS_PIN 		= INTERFACE_13;
byte Y_PLUS_PIN 		= INTERFACE_14;
byte Y_MINUS_PIN 		= INTERFACE_15;
byte Z_PLUS_PIN 		= INTERFACE_16;
byte Z_MINUS_PIN 		= INTERFACE_17;
byte ZERO_PIN 			= INTERFACE_18;
byte BAR_PIN 			= INTERFACE_19;

//our kill switch aka estop
#define KILL_SWITCH      2

//our buzzer for alerts.
#define BUZZER_PIN       31

#include <LiquidCrystal.h>
LiquidCrystal lcd(LCD_RS_PIN, LCD_ENABLE_PIN, LCD_D4_PIN, LCD_D5_PIN, LCD_D6_PIN, LCD_D7_PIN);

void setup()
{
  lcd.begin(16, 4);

  pinMode(X_STEP_PIN, OUTPUT);
  pinMode(X_DIR_PIN, OUTPUT);
  pinMode(X_ENABLE_PIN, OUTPUT);
  pinMode(X_MIN_PIN, INPUT);
  pinMode(X_MAX_PIN, INPUT);

  pinMode(Y_STEP_PIN, OUTPUT);
  pinMode(Y_DIR_PIN, OUTPUT);
  pinMode(Y_ENABLE_PIN, OUTPUT);
  pinMode(Y_MIN_PIN, INPUT);
  pinMode(Y_MAX_PIN, INPUT);

  pinMode(Z_STEP_PIN, OUTPUT);
  pinMode(Z_DIR_PIN, OUTPUT);
  pinMode(Z_ENABLE_PIN, OUTPUT);
  pinMode(Z_MIN_PIN, INPUT);
  pinMode(Z_MAX_PIN, INPUT);

  pinMode(A_STEP_PIN, OUTPUT);
  pinMode(A_DIR_PIN, OUTPUT);
  pinMode(A_ENABLE_PIN, OUTPUT);

  pinMode(B_STEP_PIN, OUTPUT);
  pinMode(B_DIR_PIN, OUTPUT);
  pinMode(B_ENABLE_PIN, OUTPUT);

  pinMode(DEBUG_PIN, OUTPUT);

  pinMode(SD_CARD_WRITE, INPUT);
  pinMode(SD_CARD_DETECT, INPUT);
  pinMode(SD_CARD_SELECT, OUTPUT);

  digitalWrite(SD_CARD_WRITE, HIGH);
  digitalWrite(SD_CARD_DETECT, HIGH);

  pinMode(TX_ENABLE_PIN, OUTPUT);
  pinMode(RX_ENABLE_PIN, OUTPUT);

  pinMode(LCD_RS_PIN, OUTPUT);
  pinMode(LCD_ENABLE_PIN, OUTPUT);
  pinMode(LCD_D4_PIN, OUTPUT);
  pinMode(LCD_D5_PIN, OUTPUT);
  pinMode(LCD_D6_PIN, OUTPUT);
  pinMode(LCD_D7_PIN, OUTPUT);
  pinMode(OK_PIN, INPUT);
  pinMode(CANCEL_PIN, INPUT);
  pinMode(FOO_PIN, OUTPUT);
  pinMode(X_PLUS_PIN, INPUT);
  pinMode(X_MINUS_PIN, INPUT);
  pinMode(Y_PLUS_PIN, INPUT);
  pinMode(Y_MINUS_PIN, INPUT);
  pinMode(Z_PLUS_PIN, INPUT);
  pinMode(Z_MINUS_PIN, INPUT);
  pinMode(ZERO_PIN, INPUT);
  pinMode(BAR_PIN, OUTPUT);
  pinMode(DEBUG_PIN, OUTPUT);

  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(KILL_SWITCH, INPUT);

  pinMode(PS_ON_PIN, OUTPUT);

  //start our serial console
  Serial.begin(57600);
  Serial.println("Motherboard v2.2 Tester Started");

  //start our rs485 comms port
  Serial1.begin(38400);
  digitalWrite(RX_ENABLE_PIN, LOW); //always listen
  digitalWrite(TX_ENABLE_PIN, HIGH); //always transmit

  digitalWrite(A_ENABLE_PIN, HIGH);
  digitalWrite(B_ENABLE_PIN, HIGH);
  digitalWrite(X_ENABLE_PIN, HIGH);
  digitalWrite(Y_ENABLE_PIN, HIGH);
  digitalWrite(Z_ENABLE_PIN, HIGH);

  digitalWrite(X_DIR_PIN, LOW);
  digitalWrite(Y_DIR_PIN, LOW);
  digitalWrite(Z_DIR_PIN, LOW);
  digitalWrite(A_DIR_PIN, LOW);
  digitalWrite(B_DIR_PIN, LOW);

  digitalWrite(ZERO_PIN, LOW);
  digitalWrite(BAR_PIN, LOW);
  digitalWrite(DEBUG_PIN, LOW);
  digitalWrite(PS_ON_PIN, LOW);
}

void chirp()
{
  playNote(1000, 1000);
  playNote(500, 1000);
  playNote(750, 1000);

  delay(500);
}

void loop()
{
  Serial.println("Motherboard v2.2 Tester Begin");

  chirp();

  prompter("Lets get testy.");

  //test_interface();
  //test_endstops();
  //test_steppers();
  //test_rs485();
  test_sd_card();
  //test_piezo();
}

void test_interface()
{
  prompter("Press OK to begin Interface testing.");
  while(!confirm(OK_PIN))
    true;

  prompter("Press Zero on Interface");
  while(!confirm(ZERO_PIN))
    true;

  prompter("Press X+ on Interface");
  while(!confirm(X_PLUS_PIN))
    true;

  prompter("Press X- on Interface");
  while(!confirm(X_MINUS_PIN))
    true;

  prompter("Press Y+ on Interface");
  while(!confirm(Y_PLUS_PIN))
    true;

  prompter("Press Y- on Interface");
  while(!confirm(Y_MINUS_PIN))
    true;

  prompter("Press Z+ on Interface");
  while(!confirm(Z_PLUS_PIN))
    true;

  prompter("Press Z- on Interface");
  while(!confirm(Z_MINUS_PIN))
    true;

  digitalWrite(FOO_PIN, HIGH);
  prompter("Press OK if FOO LED is on");
  while(!confirm(OK_PIN))
    true;
  digitalWrite(FOO_PIN, LOW);

  digitalWrite(BAR_PIN, HIGH);
  prompter("Press OK if BAR LED is on");
  while(!confirm(OK_PIN))
    true;
  digitalWrite(BAR_PIN, LOW);

  digitalWrite(DEBUG_PIN, HIGH);
  prompter("Press OK if DEBUG LED is on");
  while(!confirm(OK_PIN))
    true;
  digitalWrite(DEBUG_PIN, LOW);

  prompter("Press Cancel on Interface.");
  while(!confirm(CANCEL_PIN))
    true;

  lcd.clear();
  lcd.print("Interface Testing Complete");
  chirp();
}

void test_endstops()
{
  prompter("Please X Minimum Switch");
  while(!confirm(X_MIN_PIN))
    true;

  prompter("Please X Maximum Switch");
  while(!confirm(X_MAX_PIN))
    true;

  prompter("Please Y Minimum Switch");
  while(!confirm(Y_MIN_PIN))
    true;

  prompter("Please Y Maximum Switch");
  while(!confirm(Y_MAX_PIN))
    true;

  prompter("Please Z Minimum Switch");
  while(!confirm(Z_MIN_PIN))
    true;

  prompter("Please Z Maximum Switch");
  while(!confirm(Z_MAX_PIN))
    true;

  prompter("Please Trigger Emergency Stop");
  while(!confirm(KILL_SWITCH))
    true;

  lcd.clear();
  lcd.print("Endstop Testing Complete");
  chirp();
}

void test_steppers()
{
  digitalWrite(X_DIR_PIN, HIGH);
  digitalWrite(X_ENABLE_PIN, LOW);
  prompter("Press OK if X motor is rotating CW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(X_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(X_STEP_PIN, LOW);
    delay(1);
  }

  digitalWrite(X_DIR_PIN, LOW);
  prompter("Press OK if X motor is rotating CCW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(X_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(X_STEP_PIN, LOW);
    delay(1);
  }
  digitalWrite(X_ENABLE_PIN, HIGH);

  digitalWrite(Y_DIR_PIN, HIGH);
  digitalWrite(Y_ENABLE_PIN, LOW);
  prompter("Press OK if Y motor is rotating CW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(Y_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(Y_STEP_PIN, LOW);
    delay(1);
  }

  digitalWrite(Y_DIR_PIN, LOW);
  prompter("Press OK if Y motor is rotating CCW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(Y_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(Y_STEP_PIN, LOW);
    delay(1);
  }
  digitalWrite(Y_ENABLE_PIN, HIGH);

  digitalWrite(Z_DIR_PIN, HIGH);
  digitalWrite(Z_ENABLE_PIN, LOW);
  prompter("Press OK if Z motor is rotating CW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(Z_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(Z_STEP_PIN, LOW);
    delay(1);
  }

  digitalWrite(Z_DIR_PIN, LOW);
  prompter("Press OK if Z motor is rotating CCW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(Z_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(Z_STEP_PIN, LOW);
    delay(1);
  }
  digitalWrite(Z_ENABLE_PIN, HIGH);

  digitalWrite(A_DIR_PIN, HIGH);
  digitalWrite(A_ENABLE_PIN, LOW);
  prompter("Press OK if A motor is rotating CW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(A_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(A_STEP_PIN, LOW);
    delay(1);
  }

  digitalWrite(A_DIR_PIN, LOW);
  prompter("Press OK if A motor is rotating CCW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(A_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(A_STEP_PIN, LOW);
    delay(1);
  }
  digitalWrite(A_ENABLE_PIN, HIGH);

  digitalWrite(B_DIR_PIN, HIGH);
  digitalWrite(B_ENABLE_PIN, LOW);
  prompter("Press OK if B motor is rotating CW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(B_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(B_STEP_PIN, LOW);
    delay(1);
  }

  digitalWrite(B_DIR_PIN, LOW);
  prompter("Press OK if B motor is rotating CCW");
  while(!confirm(OK_PIN))
  {
    digitalWrite(B_STEP_PIN, HIGH);
    delay(1);
    digitalWrite(B_STEP_PIN, LOW);
    delay(1);
  }
  digitalWrite(B_ENABLE_PIN, HIGH);

  lcd.clear();
  lcd.print("Stepper Testing Complete");
  chirp();
}

void test_rs485()
{
  int fails = 0;

  for (char i='a'; i<='z'; i++)
  {
    lcd.clear();
    lcd.print("Testing ");
    lcd.print(i);

    Serial1.print(i, BYTE);

    while(Serial1.read() != i)
    {
      fails++;
      delay(1);

      if (fails >= 1000)
        break;
    }

    while (fails >= 1000)
    {
      lcd.clear();
      lcd.print("RS485 FAIL.");
    }
  }

  lcd.clear();
  lcd.print("RS485 Comms Testing Complete");
  chirp();
}

void test_sd_card()
{
  while(!confirm(OK_PIN))
  {
    if (confirm(SD_CARD_DETECT))
    {
      lcd.clear();
      lcd.print("NO SD CARD");   
    }
    else
    {
      if (confirm(SD_CARD_WRITE))
      {
        lcd.clear();
        lcd.print("SD CARD LOCKED");
      }
      else
      {
        lcd.clear();
        lcd.print("SD CARD UNLOCKED");
      }
    }
    
    delay(100);
  }
  
  /*
	prompter("Remove SD Card\nPress OK");
   	while(!confirm(OK_PIN))
   {
   delay(1);
   }
   
   
   	prompter("Lock and Insert SD Card\nPress OK");
   	while(!confirm(OK_PIN))
   {
   delay(1);
   }
   	while (digitalRead(SD_CARD_DETECT) && digitalRead(SD_CARD_WRITE))
   	{
   		delay(1);
   	}
   
   	prompter("Remove SD Card\nPress OK");
   	while(!confirm(OK_PIN))
   {
   delay(1);
   }
   	while (!digitalRead(SD_CARD_DETECT))
   	{
   		delay(1);
   	}
   
   	prompter("Insert Unlocked SD Card\nPress OK");
   	while(!confirm(OK_PIN))
   {
   delay(1);
   }
   	while (digitalRead(SD_CARD_DETECT))
   	{
   		if (digitalRead(SD_CARD_WRITE))
   			break;
   			
   		delay(1);
   	}
   
   	prompter("TODO: Test SD Read/Write");
   	delay(1500);
   
   */

  lcd.clear();
  lcd.print("SD Card Testing Complete");
  chirp();
}

void test_piezo()
{
  prompter("Press OK if is beeping.");
  while(!confirm(OK_PIN))
  {
    playNote(1000, 1000);
    delay(500);
  }

  lcd.clear();
  lcd.print("Piezo Testing Complete");
}

void prompter(char* str)
{
  playNote(750, 1000);
  playNote(500, 1000);
  playNote(1000, 1000);

  lcd.clear();
  lcd.print(str);
}

bool confirm(byte pin)
{
  if (!digitalRead(pin))
  {
    delay(250);
    while(!digitalRead(pin))
      delay(1);

    delay(100);

    return true;
  }
  else
    return false;
}

void playNote(int delayTime, int duration)
{
  int steps = duration*1000 / delayTime;
  int halfTime = delayTime/2;

  for (int i=0; i<steps; i++)
  {
    digitalWrite(BUZZER_PIN, HIGH);
    delayMicroseconds(halfTime);
    digitalWrite(BUZZER_PIN, LOW);
    delayMicroseconds(halfTime);
  }
}


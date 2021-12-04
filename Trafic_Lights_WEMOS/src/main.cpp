#include <Arduino.h>
#define RED     1
#define YELLOW  2
#define GREEN   3

//const int red_pin     = 13; // D7
//const int yellow_pin  = 12; // D6
//const int green_pin   = 14; // D5

const int red_pin     = 4 ; // D2
const int yellow_pin  = 0 ; // D3
const int green_pin   = 2 ; // D4

//const int button_pin  = 5 ; // D1
const int button_pin  = 14; // D5    // was: 16 ; // D0

const int millies_delay = 400; // to prevent bouncing
static unsigned long last_interrupt_time = 0;

class trafic_light {

  public:
  int current_light;

  void change_light() {
    digitalWrite(red_pin, LOW); // 
    digitalWrite(yellow_pin, LOW); // 
    digitalWrite(green_pin, LOW); // 
    delay(500);

    switch (current_light) {
      case RED:    // your hand is on the sensor
        current_light = YELLOW;
        digitalWrite(yellow_pin, HIGH); // 
        delay(500);
        break;
      case YELLOW:    // your hand is close to the sensor
        current_light = GREEN;
        digitalWrite(green_pin, HIGH); // 
        delay(500);
        break;
      case GREEN:    // your hand is a few inches from the sensor
        current_light = RED;
        digitalWrite(red_pin, HIGH); // 
        delay(500);
        break;
    } // of switch

  } // of change_light()
}; // of class trafic_light

trafic_light myLight;
//ICACHE_RAM_ATTR void switch_routine();
IRAM_ATTR void switch_routine();




// ******************* SETUP
void setup() {
  Serial.begin(9600);
  //Serial.println("Staring setup");

  //pinMode(LED_BUILTIN, OUTPUT);
  pinMode(red_pin, OUTPUT);
  pinMode(yellow_pin, OUTPUT);
  pinMode(green_pin, OUTPUT);
  pinMode(button_pin, INPUT ); // INPUT_PULLUP

  digitalWrite(red_pin, LOW); // start with red
  digitalWrite(yellow_pin, LOW); // start with red
  digitalWrite(green_pin, LOW); // start with red
  delay(1000);

  //Serial.println("RED");
  digitalWrite(red_pin, HIGH); // start with red
  delay(500);
  digitalWrite(red_pin, LOW); // start with red

  //Serial.println("YELLOW");
  digitalWrite(yellow_pin, HIGH); // start with red
  delay(500);
  digitalWrite(yellow_pin, LOW); // start with red

  //Serial.println("GREEN");
  digitalWrite(green_pin, HIGH); // start with red
  delay(500);
  digitalWrite(green_pin, LOW); // start with red

  attachInterrupt(digitalPinToInterrupt(button_pin), switch_routine,CHANGE ); //FALLING 

  myLight.current_light = GREEN;
  myLight.change_light(); // start with RED (next after GREEN)
  //Serial.println("Finished setup");
  
  
} // end of SETUP() 

void loop() {
  // put your main code here, to run repeatedly:
}


// the "ICACHE_RAM_ATTR" enables run from the ISR
// without it the ISR is crashing


//ICACHE_RAM_ATTR void switch_routine() {
IRAM_ATTR void switch_routine() {

   
  unsigned long interrupt_time = millis();
  // If interrupts come faster than 200ms, assume it's a bounce and ignore
 if (interrupt_time - last_interrupt_time > millies_delay)
 {
  //Serial.print("button pressed  ..  ");
  //Serial.print("Light was: ");
  //Serial.print(myLight.current_light);
  myLight.change_light();
  //Serial.print("  ... changed to: ");
  //Serial.println(myLight.current_light);
 }
 last_interrupt_time = interrupt_time;
  
} // of switch_routine()


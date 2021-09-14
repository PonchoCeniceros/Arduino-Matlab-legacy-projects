#include "Components.h"

ECGsensor* ad8232;
 
void setup( ) {
  Serial.begin(9600);
  ad8232 = new AD8232(A0, 10, 11);
  ad8232 = new Filter(ad8232, 0.90);
  ad8232 = new Servomotor(ad8232, 9);
}

void loop( ) {
  auto signalValue = ad8232->readingSignal();
  Serial.println(signalValue - 300.0);
  delay(1);
}

#include "EMGcomponents.h"

class AD8232: public ECGsensor
{
  int loPlus, loMinus, in;
public:  
  AD8232(int in, int loPlus, int loMinus): in(in), loPlus(loPlus), loMinus(loMinus)
  {
    pinMode(loPlus, INPUT);  // LO+
    pinMode(loMinus, INPUT); // LO-    
  }

  float readingSignal()
  {
    if(!(digitalRead(10) == 1)||(digitalRead(11) == 1))
      return analogRead(in);    
  } 
};

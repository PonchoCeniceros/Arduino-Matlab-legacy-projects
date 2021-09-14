#ifndef _EMG_SENSOR_H_
#define _EMG_SENSOR_H_

class EMGsensor
{
public:
  virtual float readingSignal() = 0;
};

class EMGcomponent: public EMGsensor
{ 
  EMGsensor* wrapper;  
public:
  EMGcomponent(EMGsensor* wrapper)
  {
    this->wrapper = wrapper;
  }
  
  float readingSignal()
  {
    return wrapper->readingSignal();
  }     
};

#endif //_EMG_SENSOR_H_

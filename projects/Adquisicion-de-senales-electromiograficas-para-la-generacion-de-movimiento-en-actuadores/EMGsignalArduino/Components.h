#include <Servo.h>
#include <EMGsensors.h>
#include <ComplementaryFilter.h>

/**
 * @decorator Filter
 */
struct Filter: public EMGcomponent {  
  Filter(EMGsensor* sensor, float setpoint): EMGcomponent(sensor) {
    filter = new ComplementaryFilter(setpoint);  
  }
  
  float readingSignal() {
    return filter->compute(EMGcomponent::readingSignal());
  }
private:
  ComplementaryFilter* filter;
};

/**
 * @decorator Servomotor
 */
struct Servomotor: public EMGcomponent {  
  Servomotor(EMGsensor* sensor, int attachedPin): EMGcomponent(sensor) {
    servoMotor = new Servo();
    servoMotor->attach(attachedPin);  
  }
  
  float readingSignal() {
    auto value = EMGcomponent::readingSignal();
    auto mapped = map(value, 0, 659, 30, 160);
    servoMotor->write(mapped);
    return value;
  }
private:
  Servo* servoMotor;
};

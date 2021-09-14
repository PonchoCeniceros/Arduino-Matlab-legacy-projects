# Adquisición de señales electromiográficas para la generación de movimiento en actuadores

![](https://github.com/NinoRataDeCMasMas/Adquisicion-de-senales-electromiograficas-para-la-generacion-de-movimiento-en-actuadores/blob/master/schematics/A1.jpeg)

## Introducción
En el presente repositorio se centra el material para el sistema de captación de señales provenientes de los músculos para generación de movimientos con cierto grado de libertad desarrollado para la materia de desarrollo basado en plataformas.

## Implementación de Hardware

![](https://github.com/NinoRataDeCMasMas/Adquisicion-de-senales-electromiograficas-para-la-generacion-de-movimiento-en-actuadores/blob/master/schematics/A2.png)

Se desarrolló un prototipo para la adquisición de señales electromiográficas. Dicho desarrollo consta de cuatro partes diferenciadas: un transductor que capta la señal generada de los músculos del usuario, un dispositivo que actúa como un acondicionador y amplificador de la señal, un dispositivo microcontrolador que procesa la señal obtenida y por último un actuador que refleje la señal en movimiento.

![](https://github.com/NinoRataDeCMasMas/Adquisicion-de-senales-electromiograficas-para-la-generacion-de-movimiento-en-actuadores/blob/master/schematics/A3.jpg)

El sistema esta completamente basado en el dispositivo AD8232, el cual es un bloque de acondicionamiento de señal integrado para EMG, ECG y otras aplicaciones de medición de biopotencial. Está diseñado para extraer, amplificar y filtrar pequeñas señales biopotenciales en presencia de condiciones ruidosas, como las creadas por el movimiento o la colocación remota de electrodos. Este diseño permite que un convertidor analógico a digital de potencia baja (ADC) o un microcontrolador incorporado adquiera la señal de salida fácilmente.

## Implementación de Software

Una vez construida la implementación de Hardware se desarrollo una serie de programas para la funcionalidad del sistema. Se implemento la [Programacion Orientada a Objetos](https://es.wikipedia.org/wiki/Programaci%C3%B3n_orientada_a_objetos) por lo que partes del sistema fueron abstraídas en clases, como se muestra en el siguiente diagrama en UML:

![](https://github.com/NinoRataDeCMasMas/Adquisicion-de-senales-electromiograficas-para-la-generacion-de-movimiento-en-actuadores/blob/master/schematics/A5.png)

## Instalación del proyecto
Descarga los contenidos de este repositorio en tu computadora. Mueva los directorios localizados en la carpeta _libraries_

 * _ComplementaryFilter_
 * _EMGsensors_

al directorio de librerias de Arduino. El directorio llamado _EMGsignalArduino_ contiene el programa principal asi como las clases _components/Filter_ y _components/Servomotor_. Modifique dichas clases a sus necesidades y cargue en el arduino el archivo _EMGsignalArduino.ino_. 

## Implementando una adquisicion simple

```C++
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
```

```C++
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
```

```C++
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
```

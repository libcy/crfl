# crfl

An experimental program for the inversion of 1D velocity structure based on the records of Ms5.6 Minxian earthquake. [A Previous study](https://www.researchgate.net/publication/317559025_Crustal_velocity_structure_of_central_Gansu_Province_from_regional_seismic_waveform_inversion_using_firework_algorithm) using firework algorithm gave a velocity structure that seems to fit pretty well with the observed data, and I wanted to figure out whether gradient based FWI could do the same thing.

![Epicenter and station position](https://raw.githubusercontent.com/libcy/crfl/master/img/position.png)

The forward modeling is done by reflectivity method, parameters to be inverted are the velocity of five layers(5) and the depth of each layer(4). Inversion workflow:

1. Invert the velocity of each layer
2. Invert the depth of the first layer
3. Invert the depth of other layers
4. Repeat the process if necessary

Synthetic study (r: initial model  g: inverted model  b: true model)

* Inversion of velocity (fixed depth)<br>
  ![](https://raw.githubusercontent.com/libcy/crfl/master/img/syn1.png)

* Inversion of velocity<br>
  ![](https://raw.githubusercontent.com/libcy/crfl/master/img/syn2.png)

* Inversion of depth (first layer)<br>
  ![](https://raw.githubusercontent.com/libcy/crfl/master/img/syn3.png)

* Inversion of depth (other layers)<br>
  ![](https://raw.githubusercontent.com/libcy/crfl/master/img/syn4.png)

Inversion of observed data

* Velocity structure<br>
  ![](https://raw.githubusercontent.com/libcy/crfl/master/img/obs1.png)

* Waveform misfit<br>
  ![](https://raw.githubusercontent.com/libcy/crfl/master/img/obs2.png)

The result doesn't seem to be satisfying according to the waveform comparison, but the total waveform misfit does decrease significantly after the inversion process. A better objective function choice (e.g. envelope misfit) will perhaps lead to a much better result. Although the gradient based method which involves ~200 forward calculation is not a perfect alternative to some global search methods that require ~50000 forward calculations, there are some potential that it could be used to improve the result of an existing search.

# RSKtools

RSKtools is a simple Matlab toolbox to open RSK SQLite files generated
by RBR instruments. This repository is for the development version of
the toolbox -- for the "officially" distributed version go to:

[http://www.rbr-global.com/support/matlab-tools](http://www.rbr-global.com/support/matlab-tools)

## What does RSKtools do?

* Open RSK files:
```matlab
r = RSKopen('sample.rsk');
```

* Plot a thumbnail:
```matlab
RSKplotthumbnail(r);
```

* And lots of other stuff.  Read the Matlab help (by typing `help RSKtools`) once you've installed it!

## How do I get set up?

* Unzip the archive (to `~/matlab/RSKtools`, for instance)
* Add the folder to your path inside matlab (`addpath
  ~/matlab/RSKtools` or some nifty GUI thing)
* type `help RSKtools` to get an overview and take a look at the examples.

## A note on calculation of Seawater properties

A typical RBR CTD (e.g. Concerto or Maestro) has sensors to measure *in situ* pressure, temperature, and electrical conductivity. These three variables are required to calculate seawater salinity, either using the Practical Salinity Scale (PSS-78, see [Unesco, 1981](http://unesdoc.unesco.org/images/0004/000461/046148eb.pdf)), or Absolute salinity based on the Thermodynamic Equation of Seawater 2010 (see [IOC, SCOR and IAPSO, 2010](http://www.teos-10.org)). Note that to calculate Absolute salinity the latitude and longitude are also required.

If the [TEOS-10](http://www.teos-10.org/software.htm) matlab toolbox is installed, `RSKtools` will take advantage of it to calculate Practical salinity for RSK objects which contain pressure, temperature, and conductivity channels, using the `gsw_SP_from_C()` function.

## Contribution guidelines

* Feel free to add improvements at any time:
  * by forking and sending a pull request
  * by emailing patches or changes to `support@rbr-global.com`
* Write to `support@rbr-global.com` if you need help


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

## Contribution guidelines

* Feel free to add improvements at any time:
  * by forking and sending a pull request
  * by emailing patches or changes to `support@rbr-global.com`
* Write to `support@rbr-global.com` if you need help


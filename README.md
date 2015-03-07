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

* Feel free to add improvements at any time
* Write to support @ rbr-global.com if you need a hand or would like special recognition for an awesome addition

## Who wrote this?

Well, Greg Johnson wrote the first few versions, and then Jean-Michel kicked in some patches, and now Clark Richards seems to be in charge ...

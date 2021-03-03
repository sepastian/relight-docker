# Purpose

Docker container for building RTI models using [relight](https://github.com/cnr-isti-vclab/relight).

![Screenshot](examples/screenshot.jpg)

# Building

``` shell
docker build -t sepastian/relight-docker .
```

# Usage

This repository includes test images in `exmaples/ring`.
An RTI model has been build and placed in `web`.
To rebuid the model follow these steps.

Prerequisite: build the Docker container first, see _Building_ above.

Inside `examples/ring` are 64 images taken with an RTI dome and a corresponding `lights.lp` file, describing light positions.
Note that the number of images must match with the number of lines in `lights.lp`;
file names inside `lights.lp` must match with names of image files.

Next, use the container to build an RTI model from the images in `examples/ring`, save the results in `web`.

``` shell
$ docker run -it --rm \
  -v $(pwd)/examples/ring:/data \
  -v $(pwd)/web:/out \
  sepastian/relight-docker \
  relight-cli /data /out
Nsamples: 160000
Done in: 6927ms
```

This creates the following new files in `web`.

``` shell
$ ls web
info.json
materials.png
plane_0.jpg
plane_1.jpg
plane_2.jpg
```

Run an HTTP Server to view the resulting RTI model.

``` shell
# For example, using Python 3's built-in HTTP server.
python -m http.server
```

Open `http://localhost:8000` in a browser. Firefox in Linux may not be able to display the results, use Chrome instead.

## Options

To display relight's help message, run:

```shell
$ docker run -it --rm sepastian/relight-docker relight-cli
Create an RTI from a set of images and a set of light directions (.lp) in a folder.
It is also possible to convert from .ptm or .rti to relight format and viceversa.

Usage: relight-cli [-mrdqp]<input folder> [output folder]

       relight-cli [-q]<input.ptm|.rti> [output folder]

       relight-cli [-q]<input.json> [output.ptm]

	input folder containing a .lp with number of photos and light directions
	optional output folder (default ./)

	-b <basis>: rbf(default), ptm, lptm, hsh, yrbf, bilinear
	-p <int>  : number of planes (default: 9)
	-q <int>  : jpeg quality (default: 95)
	-y <int>  : number of Y planes in YCC

	-n        : extract normals
	-m        : extract mean image
	-M        : extract median image (7/8th quantile) 
	-k <int>x<int>+<int>+<int>: Kropping extracts only the widthxheight+offx+offy part

Ignore exotic parameters below here

	-r <int>  : side of the basis function (default 8, 0 means rbf interpolation)
	-s <int>  : sampling RAM for pca  in MB (default 500MB)
	-S <float>: sigma in rgf gaussian interpolation default 0.125 (~100 img)
	-R <float>: regularization coeff for bilinear default 0.1
	-B <float>: range compress bits for planes (default 0.0) 1.0 means compress
	-c <float>: coeff quantization (to test!) default 1.5
	-C        : apply chroma subsampling 
	-e        : evaluate reconstruction error (default: false)
	-E <int>  : evaluate error on a single image (but remove it for fitting)


Testing options, will use the input folder as an RTI source: 
	-D <path> : directory to store rebuilt images
	-L <x:y:z> : reconstruct only one image from light parameters, output is the filename
```

For further information, consult the [relight project](https://github.com/cnr-isti-vclab/relight).

# Credits

RTI viewer website based on the original [relight project](https://github.com/cnr-isti-vclab/relight).
Images in `examples/ring` produced by Nina Kunze, Uni Passau.

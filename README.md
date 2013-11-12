# generator-prototyping

[![Build Status](https://travis-ci.org/sasaplus1/generator-prototyping.png)](https://travis-ci.org/sasaplus1/generator-prototyping)
[![Dependency Status](https://gemnasium.com/sasaplus1/generator-prototyping.png)](https://gemnasium.com/sasaplus1/generator-prototyping)

Yeoman generator for client side webapp prototyping

## Installation

```sh
$ npm install -g yo generator-prototyping
```

## Usage

### scaffolding

```sh
$ mkdir prototyping && cd $_
$ yo prototyping
```

### run

```sh
$ grunt
```

1. start server at `localhost:3000`
1. compile Jade, Stylus, Less and CoffeeScript
1. start watching for files, and start livereload
  1. recompile for file when file updated
  1. reload browser with auto when file updated

### install libraries

```sh
$ grunt install
```

download libraries using bower, and put to `public/lib/`.

## License

The MIT license. Please see LICENSE file.

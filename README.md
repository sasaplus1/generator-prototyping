# generator-prototyping

[![Build Status](https://travis-ci.org/sasaplus1/generator-prototyping.png)](https://travis-ci.org/sasaplus1/generator-prototyping)
[![Dependency Status](https://gemnasium.com/sasaplus1/generator-prototyping.png)](https://gemnasium.com/sasaplus1/generator-prototyping)

Yeoman generator for client side webapp prototyping

## Installation

```sh
$ npm install -g yo generator-prototyping
```

## Usage

```sh
$ mkdir prototyping && cd $_
$ yo prototyping
```

## grunt aliases

### develop

```sh
$ grunt develop
```

1. start server at `localhost:8000`
1. start watch files and start livereload

### install

```sh
$ grunt install
```

download libraries using bower, and put to `public/lib/`.

### rebuild

```sh
$ grunt rebuild
```

1. clean `public/` directory
1. compile Jade, Stylus, Less and CoffeeScript

## License

The MIT license. Please see LICENSE file.

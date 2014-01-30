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

### compile

```sh
$ grunt compile
```

1. remove files and directories in `public/`, without `public/lib/`
1. copy to `public/` from `assets/`
1. compile files for Jade, Stylue, Less and CoffeeScript

### develop

```sh
$ grunt develop
```

1. start server at `localhost:8000`
1. start watch to files and start livereload

watch to files below.

- `jade/**/*.jade`
- `stylus/**/*.styl`
- `less/**/*.less`
- `js/**/*.js`
- `coffee/**/*.coffee`
- `assets/**/*`

### install

```sh
$ grunt install
```

download libraries using bower, and put to `public/lib/`.

### rebuild

```sh
$ grunt rebuild
```

it similar to `compile` alias. but clean `public/`, and install libraries with bower.

## License

The MIT license. Please see LICENSE file.

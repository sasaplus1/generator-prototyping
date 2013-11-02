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

### run start script

```sh
$ npm start
```

1. start server at `localhost:3000`
1. compile Jade, Stylus and CoffeeScript
1. concatenate compiled CoffeeScript(`index.coffee.js`) and JavaScript(`index.js`)
1. start watch for file and start livereload
1. recompile file each time if updated file.

## License

The MIT license. Please see LICENSE file.

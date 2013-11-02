#!/usr/bin/env node

/*!
 * generator-prototyping Copyright(c) 2013 sasa+1
 * https://github.com/sasaplus1/generator-prototyping
 * Released under the MIT license.
 */

var path = require('path'),
    util = require('util'),
    yeoman = require('yeoman-generator');

util.inherits(PrototypingGenerator, yeoman.generators.Base);

function PrototypingGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function() {
    this.installDependencies({
      bower: false,
      npm: true,
      skipInstall: false
    });
  });

  this.pkg = require(path.join(__dirname, '..', 'package.json'));
}

PrototypingGenerator.prototype.app = function() {
  this.mkdir('js');
  this.copy('js/index.js', 'js/index.js');

  this.mkdir('jade');
  this.copy('jade/index.jade', 'jade/index.jade');
  this.copy('jade/_livereload.jade', 'jade/_livereload.jade');

  this.mkdir('stylus');
  this.copy('stylus/index.stylus', 'stylus/index.stylus');

  this.mkdir('coffee');
  this.copy('coffee/index.coffee', 'coffee/index.coffee');

  this.copy('_package.json', 'package.json');
  this.copy('_bower.json', 'bower.json');

  this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
};

module.exports = PrototypingGenerator;

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
  this.mkdir('assets');
  this.mkdir('coffee');
  this.mkdir('jade');
  this.mkdir('js');
  this.mkdir('less');
  this.mkdir('stylus');
  this.mkdir('public');

  this.copy('_bower.json', 'bower.json');
  this.copy('_package.json', 'package.json');

  this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
};

module.exports = PrototypingGenerator;

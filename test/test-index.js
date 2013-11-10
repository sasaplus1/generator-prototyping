var path = require('path'),
    helpers = require('yeoman-generator').test,
    rimraf = require('rimraf');

describe('prototyping generator', function() {

  var temp = path.join(__dirname, 'temp');

  beforeEach(function(done) {
    helpers.testDirectory(temp, function(err) {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator('prototyping:app', [
        '../../app'
      ]);

      done();
    }.bind(this));
  });

  afterEach(function(done) {
    rimraf(temp, function(err) {
      done(err);
    });
  });

  it('create expected files', function(done) {
    // cancel npm install
    this.app.removeAllListeners('end');
    this.app.run({}, function() {
      helpers.assertFiles([
        'package.json',
        'bower.json',
        'Gruntfile.coffee',
        'jade/index.jade'
      ]);
      done();
    });
  });

});

module.exports = (grunt) ->

  grunt.initConfig
    concat:
      dist:
        src: ['index.coffee.js', 'js/*.js']
        dest: 'index.js'
    connect:
      server:
        options:
          port: 3000
    jade:
      compile:
        files:
          'index.html': 'jade/!(_)*.jade'
    stylus:
      compile:
        files:
          'index.css': 'stylus/!(_)*.stylus'
    coffee:
      options:
        bare: true
      compile:
        files:
          'index.coffee.js': 'coffee/*.coffee'
    esteWatch:
      options:
        dirs: ['js/**', 'jade/**', 'stylus/**', 'coffee/**']
        livereload:
          enabled: true
          port: 35729
          extensions: ['js', 'jade', 'stylus', 'coffee']
      js: (filepath) ->
        grunt.config 'concat.dist.src', ['index.coffee.js', 'js/*.js']
        grunt.config 'concat.dist.dest', 'index.js'
        'concat'
      jade: (filepath) ->
        grunt.config 'jade.compile.files',
          'index.html': 'jade/!(_)*.jade'
        'jade'
      stylus: (filepath) ->
        grunt.config 'stylus.compile.files',
          'index.css': 'stylus/!(_)*.stylus'
        'stylus'
      coffee: (filepath) ->
        grunt.config 'coffee.options.bare', true
        grunt.config 'coffee.compile.files',
          'index.coffee.js': 'coffee/*.coffee'
        grunt.config 'concat.dist.src', ['index.coffee.js', 'js/*.js']
        grunt.config 'concat.dist.dest', 'index.js'
        ['coffee', 'concat']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-este-watch'

  grunt.registerTask 'default', ['connect', 'jade', 'stylus', 'coffee', 'concat', 'esteWatch']

  return

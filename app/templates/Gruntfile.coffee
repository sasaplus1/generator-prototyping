module.exports = (grunt) ->

  grunt.initConfig
    connect:
      server:
        options:
          base: 'public/'
          livereload: 35729
          port: 3000
    copy:
      main:
        files: [
          dest: 'public/'
          expand: true
          filter: 'isFile'
          flatten: true
          src: ['js/*', 'output/jade/*', 'output/stylus/*', 'output/coffee/*']
        ]
    jade:
      compile:
        files: [
          dest: 'output/'
          expand: true
          ext: '.html'
          src: 'jade/!(_)*.jade'
        ]
    stylus:
      compile:
        files: [
          dest: 'output/'
          expand: true
          ext: '.css'
          src: ['stylus/!(_)*.styl', 'stylus/!(_)*.stylus']
        ]
    coffee:
      options:
        bare: true
      compile:
        files: [
          dest: 'output/'
          expand: true
          ext: '.js'
          src: 'coffee/*.coffee'
        ]
    esteWatch:
      options:
        dirs: ['js/**', 'jade/**', 'stylus/**', 'coffee/**']
        livereload:
          enabled: true
          extensions: ['js', 'jade', 'stylus', 'coffee']
          port: 35729
      js: (filepath) ->
        grunt.config 'copy.main.files', [
          dest: 'public/'
          expand: true
          filter: 'isFile'
          flatten: true
          src: filepath
        ]
        'copy'
      jade: (filepath) ->
        return if /_[^\/]*\.jade$/.test filepath
        grunt.config 'jade.compile.files', [
          dest: 'output/'
          expand: true
          ext: '.html'
          src: filepath
        ]
        grunt.config 'copy.main.files', [
          dest: 'public/'
          expand: true
          filter: 'isFile'
          flatten: true
          src: filepath
            .replace(/^jade\//, 'output/jade/')
            .replace(/\.jade$/, '.html')
        ]
        ['jade', 'copy']
      stylus: (filepath) ->
        return if /_[^\/]*\.styl(?:us)?$/.test filepath
        grunt.config 'stylus.compile.files', [
          dest: 'output/'
          expand: true
          ext: '.css'
          src: filepath
        ]
        grunt.config 'copy.main.files', [
          dest: 'public/'
          expand: true
          filter: 'isFile'
          flatten: true
          src: filepath
            .replace(/^stylus\//, 'output/stylus/')
            .replace(/\.styl(?:us)?$/, '.css')
        ]
        ['stylus', 'copy']
      coffee: (filepath) ->
        grunt.config 'coffee.options.bare', true
        grunt.config 'coffee.compile.files', [
          dest: 'output/'
          expand: true
          ext: '.js'
          src: filepath
        ]
        grunt.config 'copy.main.files', [
          dest: 'public/'
          expand: true
          filter: 'isFile'
          flatten: true
          src: filepath
            .replace(/^coffee\//, 'output/coffee/')
            .replace(/\.coffee$/, '.js')
        ]
        ['coffee', 'copy']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-este-watch'

  grunt.registerTask 'default', ['connect', 'jade', 'stylus', 'coffee', 'copy', 'esteWatch']

  return

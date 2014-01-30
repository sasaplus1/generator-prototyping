module.exports = (grunt) ->

  path = require 'path'

  grunt.initConfig

    bower:
      install:
        options:
          layout: 'byType'
          targetDir: 'public/lib/'

    clean:
      main:
        files: [
          src: 'public/**/*'
        ]

    coffee:
      compile:
        files: [
          dest: 'public/js/'
          expand: true
          ext: '.js'
          rename: (dest, matchSrcPath, options) ->
            path.join dest, matchSrcPath.replace 'coffee/', ''
          src: 'coffee/**/*.coffee'
        ]
      options:
        bare: true
        sourceMap: true

    connect:
      server:
        options:
          base: 'public/'
          livereload: 35729

    copy:
      coffee:
        files: [
          dest: 'public/'
          expand: true
          src: 'coffee/**/*.coffee'
        ]
      js:
        files: [
          dest: 'public/'
          expand: true
          src: 'js/**/*.js'
        ]

    jade:
      compile:
        files: [
          dest: 'public/'
          expand: true
          ext: '.html'
          rename: (dest, matchSrcPath, options) ->
            path.join dest, matchSrcPath.replace 'jade/', ''
          src: 'jade/**/!(_)*.jade'
        ]
      options:
        pretty: true

    less:
      compile:
        files: [
          dest: 'public/css/'
          expand: true
          ext: '.css'
          rename: (dest, matchSrcPath, options) ->
            path.join dest, matchSrcPath.replace 'less/', ''
          src: 'less/**/!(_)*.less'
        ]

    stylus:
      compile:
        files: [
          dest: 'public/css/'
          expand: true
          ext: '.css'
          rename: (dest, matchSrcPath, options) ->
            path.join dest, matchSrcPath.replace 'stylus/', ''
          src: 'stylus/**/!(_)*.styl'
        ]
      options:
        compress: false

    esteWatch:
      coffee: (filepath) ->
        # copy to public dir
        conf = grunt.config('copy.coffee.files')[0]
        conf.src = filepath
        grunt.config 'copy.coffee.files', [conf]
        # compile copied file
        conf = grunt.config('coffee.compile.files')[0]
        conf.src = filepath.replace 'coffee/', 'public/coffee/'
        grunt.config 'coffee.compile.files', [conf]
        ['copy:coffee', 'coffee']
      jade: (filepath) ->
        return if /_[^\/]*\.jade$/.test filepath
        conf = grunt.config('jade.compile.files')[0]
        conf.src = filepath
        grunt.config 'jade.compile.files', [conf]
        'jade'
      js: (filepath) ->
        conf = grunt.config('copy.js.files')[0]
        conf.src = filepath
        grunt.config 'copy.js.files', [conf]
        'copy:js'
      less: (filepath) ->
        return if /_[^\/]*\.less$/.test filepath
        conf = grunt.config('less.compile.files')[0]
        conf.src = filepath
        grunt.config 'less.compile.files', [conf]
        'less'
      styl: (filepath) ->
        return if /_[^\/]*\.styl$/.test filepath
        conf = grunt.config('stylus.compile.files')[0]
        conf.src = filepath
        grunt.config 'stylus.compile.files', [conf]
        'stylus'
      options:
        dirs: ['coffee/**', 'jade/**', 'js/**', 'less/**', 'stylus/**']
        livereload:
          enabled: true
          extensions: ['coffee', 'jade', 'js', 'less', 'styl']
          port: 35729

  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-este-watch'

  grunt.registerTask 'develop', ['connect', 'esteWatch']
  grunt.registerTask 'install', ['bower']
  grunt.registerTask 'rebuild', ['clean', 'copy', 'jade', 'stylus', 'less', 'coffee']

  return

module.exports = (grunt) ->

  grunt.initConfig
    bower:
      install:
        options:
          layout: 'byComponent'
          targetDir: 'public/lib/'
    connect:
      server:
        options:
          base: 'public/'
          livereload: 35729
          port: 3000
    copy:
      main:
        files: [
          dest: 'public/js/'
          expand: true
          filter: 'isFile'
          flatten: true
          src: 'js/*'
        ]
    jade:
      compile:
        files: [
          dest: 'public/'
          expand: true
          ext: '.html'
          flatten: true
          src: 'jade/!(_)*.jade'
        ]
      options:
        pretty: true
    stylus:
      compile:
        files: [
          dest: 'public/css/'
          expand: true
          ext: '.css'
          flatten: true
          src: 'stylus/!(_)*.{styl,stylus}'
        ]
      options:
        compress: false
    less:
      compile:
        files: [
          dest: 'public/css/'
          expand: true
          ext: '.css'
          flatten: true
          src: 'less/!(_)*.less'
        ]
    coffee:
      compile:
        files: [
          dest: 'public/coffee/'
          expand: true
          ext: '.js'
          flatten: true
          src: 'coffee/*.coffee'
        ]
      options:
        bare: true
        sourceMap: true
    esteWatch:
      options:
        dirs: ['js/**', 'jade/**', 'stylus/**', 'less/**', 'coffee/**']
        livereload:
          enabled: true
          extensions: ['js', 'jade', 'styl', 'stylus', 'less', 'coffee']
          port: 35729
      js: (filepath) ->
        conf = grunt.config('copy.main.files')[0]
        conf.src = filepath
        grunt.config 'copy.main.files', [conf]
        'copy'
      jade: (filepath) ->
        return if /_[^\/]*\.jade$/.test filepath
        conf = grunt.config('jade.compile.files')[0]
        conf.src = filepath
        grunt.config 'jade.compile.files', [conf]
        'jade'
      styl: '<%= esteWatch.stylus %>'
      stylus: (filepath) ->
        return if /_[^\/]*\.styl(?:us)?$/.test filepath
        conf = grunt.config('stylus.compile.files')[0]
        conf.src = filepath
        grunt.config 'stylus.compile.files', [conf]
        'stylus'
      less: (filepath) ->
        return if /_[^\/]*\.less$/.test filepath
        conf = grunt.config('less.compile.files')[0]
        conf.src = filepath
        grunt.config 'less.compile.files', [conf]
        'less'
      coffee: (filepath) ->
        conf = grunt.config('coffee.compile.files')[0]
        conf.src = filepath
        grunt.config 'coffee.compile.files', [conf]
        'coffee'

  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-este-watch'

  grunt.registerTask 'default', ['connect', 'jade', 'stylus', 'less', 'coffee', 'copy', 'esteWatch']
  grunt.registerTask 'install', ['bower:install']

  return

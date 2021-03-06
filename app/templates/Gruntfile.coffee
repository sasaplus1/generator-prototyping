module.exports = (grunt) ->

  path = require 'path'

  grunt.initConfig

    bower:
      install:
        options:
          layout: 'byType'
          targetDir: 'public/lib/'

    clean:
      all:
        files:
          src: [
            'public/**/*'
            'public/**/.*'
          ]
      main:
        files:
          src: [
            'public/**/*'
            'public/**/.*'
            '!public/lib/**'
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
      assets:
        files: [
          dest: 'public/'
          src: [
            'assets/**/*'
            'assets/**/.*'
          ]
        ]
      coffee:
        files: [
          dest: 'public/'
          expand: true
          src: 'coffee/**/*.coffee'
        ]
      css:
        files: [
          dest: 'public/'
          expand: true
          src: 'css/**/*.css'
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
        conf.src = filepath
        grunt.config 'coffee.compile.files', [conf]
        # replace sourceMap path
        conf = grunt.config('string-replace.dist.files')[0]
        conf.src = filepath.replace /coffee\/(.*)\.coffee$/, 'public/js/$1.js'
        grunt.config 'string-replace.dist.files', [conf]
        grunt.log.writeln conf.src
        ['copy:coffee', 'coffee', 'string-replace']
      css: (filepath) ->
        conf = grunt.config('copy.css.files')[0]
        conf.src = filepath
        grunt.config 'copy.css.files', [conf]
        'copy:css'
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
      '*': (filepath) ->
        return unless /^assets\//.test filepath
        conf = grunt.config('copy.assets.files')[0]
        conf.src = filepath
        grunt.config 'copy.assets.files', [conf]
        'copy:assets'
      options:
        dirs: ['assets/**', 'coffee/**', 'css/**', 'jade/**', 'js/**', 'less/**', 'stylus/**']
        livereload:
          enabled: true
          extensions: ['coffee', 'css', 'jade', 'js', 'less', 'styl']
          port: 35729

    'string-replace':
      dist:
        files: [
          dest: 'public/js/'
          src: 'public/js/**/*.js'
        ]
        options:
          replacements: [
            pattern: /\/\/# sourceMappingURL=.*\//
            replacement: '//# sourceMappingURL=./'
          ]

  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-este-watch'
  grunt.loadNpmTasks 'grunt-string-replace'

  grunt.registerTask 'compile', ['clean:main', 'copy', 'jade', 'stylus', 'less', 'coffee', 'string-replace']
  grunt.registerTask 'develop', ['connect', 'esteWatch']
  grunt.registerTask 'install', ['bower']
  grunt.registerTask 'rebuild', ['clean:all', 'bower', 'copy', 'jade', 'stylus', 'less', 'coffee', 'string-replace']

  return

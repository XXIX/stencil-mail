module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    autoprefixer:
      options:
        silent: false
        browsers: ['last 2 versions', 'ie 8', 'ie 9']
      single_file:
        src: '.build/application.css'
        dest: '_build/application.css'

    copy:
      main:
        files: [
          { expand: true, src: ['assets/*'], dest: '_build/', filter: 'isFile' }
        ]

    connect:
      server:
        options:
          port: 8000
          hostname: 'localhost'
          open: true
          base: '_build'
          livereload: true

    premailer:
      main:
        options:
          verbose: true
        files:
          '_build/index-inline.html': ['_build/index.html']

    liquid:
      options:
        includes: './includes'
      pages:
        files: [
          { expand: true, flatten: true, src: 'templates/*', dest: '_build/', ext: '.html' }
        ]

    sass:
      dist:
        options:
          style: 'expanded'
          sourcemap: 'none'
        files:
          '.build/application.css': ['sass/application.sass' ]

    uncss:
      dist:
        src: [ '_build/index.html' ]
        dest: '_build/application.css'
        options:
          report: 'min'

    watch:
      copy:
        files: [ 'assets/**/*', 'assets/*' ]
        tasks: [ 'copy' ]

      liquid:
        files: [ 'includes/*', 'templates/*' ]
        tasks: [ 'liquid' ]

      sass:
        files: [ 'sass/*', 'sass/**/*' ]
        tasks: [ 'sass', 'autoprefixer', 'copy' ]

      livereload:
        files: [ '_build/**/*' ]
        options:
          livereload: true

    notify:
      options:
        title: "Stencil"
        success: true
        duration: 3

  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-concurrent"
  grunt.loadNpmTasks "grunt-notify"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks 'grunt-liquid'
  grunt.loadNpmTasks 'grunt-exec'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-premailer'
  grunt.loadNpmTasks 'grunt-uncss'

  grunt.registerTask "default", [
    'notify'
    'liquid'
    'sass'
    'copy'
    'connect'
    'watch'
  ]

  grunt.registerTask "inline", [
    'liquid'
    'sass'
    'autoprefixer'
    'uncss'
    'premailer'
  ]

  return

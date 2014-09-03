module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

  grunt.appDir = 'app'
  grunt.publicDir = 'public'
  grunt.ports =
    livereload: 35729
    connect: 8000

  require('load-grunt-config')(grunt)

  grunt.registerTask 'development', [
    'build:development'
    'server:development'
  ]

  grunt.registerTask 'default', [
    'development'
  ]

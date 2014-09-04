module.exports = (grunt) ->
  options:
    linenos: true
    compress: false
    urlfunc: 'embedurl'
    paths: [
      'bower_components'
      'vendor'
      'node_modules/jeet/stylus'
    ]
    use: [
      () -> require('autoprefixer-stylus')('last 2 versions', 'ie 8', 'ie 9')
    ]
  development:
    files:
      '<%= grunt.publicDir %>/stylesheets/style.css': '<%= grunt.appDir %>/stylesheets/application.styl'
  watch:
    files: {}

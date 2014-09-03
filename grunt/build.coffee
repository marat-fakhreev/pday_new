module.exports = (grunt) ->
  grunt.registerTask 'build', (target) ->
    if target is 'development'
      grunt.task.run [
        'clean:development'
        'stylus:development'
        'coffee:development'
        'coffeelint:development'
        'jade:html'
        'copy:development'
      ]

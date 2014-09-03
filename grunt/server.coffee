module.exports = (grunt) ->
  grunt.registerTask 'server', (target) ->
    if target is 'development'
      grunt.task.run [
        'connect:development'
        # 'configureProxies:server'
        'watch:development'
      ]

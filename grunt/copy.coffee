module.exports = (grunt) ->
  development:
    files: [
      { expand: true, cwd: '<%= grunt.appDir %>/php', dest: '<%= grunt.publicDir %>/php', src: '**' }
      { expand: true, cwd: '<%= grunt.appDir %>/images', dest: '<%= grunt.publicDir %>/images', src: '**' }
      { expand: true, cwd: '<%= grunt.appDir %>/fonts', dest: '<%= grunt.publicDir %>/fonts', src: '**' }
      { expand: true, cwd: '<%= grunt.appDir %>/stylesheets', dest: '<%= grunt.publicDir %>/stylesheets', src: '*.css' }
      { expand: true, cwd: '<%= grunt.appDir %>/scripts/libs', dest: '<%= grunt.publicDir %>/scripts/libs', src: '**' }
    ]
  production:
    files: [
      { expand: true, cwd: '<%= grunt.publicDir %>', dest: '<%= grunt.publicDir %>/../../pday-test', src: '**' }
    ]

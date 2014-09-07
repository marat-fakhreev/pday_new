module.exports = (grunt) ->
  html:
    options:
      pretty: true
      client: false
    files: [
      '<%= grunt.publicDir %>/index.html': ['<%= grunt.appDir %>/index.jade']
      '<%= grunt.publicDir %>/partners.html': ['<%= grunt.appDir %>/partners.jade']
      '<%= grunt.publicDir %>/reviews.html': ['<%= grunt.appDir %>/reviews.jade']
    ]

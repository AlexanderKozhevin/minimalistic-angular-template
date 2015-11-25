var gulp = require('gulp');

var $ = require('gulp-load-plugins')();

var connect = $.connect;
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var gzip = require('gulp-gzip');
var templateCache = require('gulp-angular-templatecache');


var jslibs = [
  "bower_components/lodash/lodash.min.js",
  "bower_components/angular/angular.min.js",
  "bower_components/angular-route/angular-route.min.js",
  "bower_components/angular-sanitize/angular-sanitize.min.js",
  "bower_components/angular-ui-router/release/angular-ui-router.min.js",
  "bower_components/angular-material/angular-material.min.js",
  "bower_components/angular-animate/angular-animate.min.js",
  "bower_components/angular-aria/angular-aria.min.js",
  "bower_components/angular-material-icons/angular-material-icons.min.js",
  "bower_components/angular-simple-logger/dist/angular-simple-logger.min.js",
  "bower_components/restangular/dist/restangular.min.js"
];

var csslibs = [
  "bower_components/angular-material/angular-material.min.css",
  "bower_components/angular-material-icons/angular-material-icons.css"
];


gulp.task('connect', function() {
  connect.server({
    root: 'production',
    livereload: true,
    fallback: 'production/assets/index.html',
    port: 8081
  });
});

gulp.task('testconnect', function() {
  connect.server({
    root: 'production',
    livereload: true,
    fallback: 'production/assets/test.html'
  });
});

gulp.task('watch', function(){
  gulp.watch('source/style/**/*.scss', ['sass']);
  gulp.watch(['source/view/**/*.jade'], ['templates']);
  gulp.watch(['source/*.jade'], ['jade']);
  gulp.watch('source/app/**/*.coffee', ['coffee']);
});

//////////////////////////////////////////////////////
// Compile

gulp.task('templates', function() {
	return gulp.src(['source/view/**/*.jade'])
	.pipe($.jade())
  .pipe(templateCache({standalone: true}))
	.pipe(gulp.dest('production/assets/js'))
	.pipe(connect.reload());
});

gulp.task('jade', function() {
  return gulp.src(['source/*.jade'])
  .pipe($.jade())
  .pipe(gulp.dest('production/assets'))
  .pipe(connect.reload());
});


gulp.task('sass',  function() {
	return gulp.src('source/style/**/*.scss')
	.pipe($.sass({ errLogToConsole: true, sourceComments: 'map', sourceMap: 'sass'}))
	.pipe(gulp.dest('production/assets/css'))
	.pipe(connect.reload());
});


gulp.task('uglify', function() {
  gulp.src(['production/assets/**/*.js'])
    .pipe($.ngAnnotate())
    .pipe(uglify({output: {ascii_only: true}}))
    .pipe(gulp.dest('production/assets'))
});

gulp.task('gzip', function() {
  gulp.src(['production/assets/**/*.js','production/assets/**/*.css'])
    .pipe(gzip())
    .pipe(gulp.dest('production/assets'))
});

gulp.task('coffee', function() {
  gulp.src('source/app/**/*.coffee')
    .pipe($.coffee())
    .pipe(concat('app.js'))
    .pipe(gulp.dest('production/assets/js'))
    .pipe(connect.reload());
});

gulp.task('jslibs', function() {
  gulp.src(jslibs)
    .pipe(concat('libs.js'))
    .pipe(gulp.dest('production/assets/js'))
});



gulp.task('csslibs', function() {
  gulp.src(csslibs)
    .pipe(concat('libs.css'))
    .pipe(gulp.dest('production/assets/css'))
});


//////////////////////////////////////////////////////
// All project compilation
gulp.task('libs', ['jslibs', 'csslibs'])
gulp.task('compile', ['libs', 'sass', 'jade', 'templates', 'coffee'])
gulp.task('production', ['compile', 'uglify', 'gzip'])

//////////////////////////////////////////////////////
// Servers
gulp.task('server', ['compile', 'watch', 'connect']);

//////////////////////////////////////////////////////
// Default task
gulp.task('default', ['server'])

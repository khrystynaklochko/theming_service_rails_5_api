var gulp = require('gulp');
var plumber = require('gulp-plumber');
var less = require('gulp-less');
var LessAutoprefix = require('less-plugin-autoprefix');
var lessAutoprefix = new LessAutoprefix({
    browsers: ['last 2 versions']
});
var sourcemaps = require('gulp-sourcemaps');
var minifycss = require('gulp-minify-css');

// CONSTANTS
var LESS_PATH = 'public/less/**/*.less';
var DIST_PATH = 'public/dist';

// Styles for Less
gulp.task('styles', function(){
    console.log('starting styles task');
    return gulp.src(LESS_PATH)
           .pipe(sourcemaps.init())
                      .pipe(plumber(function(err){
               console.log('Styles Task Error');
               console.log(err);
               this.emit('end');
           }))
           .pipe(less({
              plugins: [lessAutoprefix]
           }))
           .pipe(minifycss())
           .pipe(sourcemaps.write())
           .pipe(gulp.dest(DIST_PATH))
});

gulp.task('default', function () {
  console.log('Starting default task');
});

gulp.task('watch', function () {
  console.log('Starting watch task');
  gulp.watch('public/less/**/*.less', ['styles']);
});
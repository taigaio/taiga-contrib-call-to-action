var gulp = require('gulp');
var $ = require('gulp-load-plugins')();

var paths = {
    styles: 'styles/*.scss',
    coffee: 'coffee/*.coffee',
    images: 'images/**/*',
    dist: 'dist/'
};

gulp.task('copy-config', function() {
    return gulp.src('call-to-action.json')
        .pipe(gulp.dest(paths.dist));
});

gulp.task('copy-images', function() {
    return gulp.src(paths.images)
        .pipe(gulp.dest(paths.dist + "images"));
});

gulp.task('compile-coffee', function() {
    return gulp.src(paths.coffee)
        .pipe($.plumber())
        .pipe($.cached('coffee'))
        .pipe($.coffee())
        .pipe($.remember('coffee'))
        .pipe($.concat('call-to-action.js'))
        .pipe($.uglify({mangle:false, preserveComments: false}))
        .pipe(gulp.dest(paths.dist));
});

gulp.task('compile-styles', function() {
    return gulp.src(paths.styles)
        .pipe($.sass({outputStyle: 'compressed'}).on('error', $.sass.logError))
        .pipe(gulp.dest(paths.dist));
});

gulp.task('watch', function() {
    gulp.watch([paths.styles, paths.images, paths.coffee], ['compile-coffee', 'compile-styles']);
});

gulp.task('default', ['copy-config', 'copy-images', 'compile-coffee', 'compile-styles', 'watch']);

gulp.task('build', ['copy-config', 'copy-images', 'compile-coffee', 'compile-styles']);

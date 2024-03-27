/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright (c) 2021-present Kaleidos INC
 */

var gulp = require('gulp'),
  coffee = require("gulp-coffee"),
  concat = require("gulp-concat"),
  uglify = require("gulp-uglify"),
  plumber = require("gulp-plumber"),
  sass = require('gulp-sass')(require('node-sass')),
  cached = require("gulp-cached"),
  remember = require('gulp-remember');

var paths = {
  styles: 'styles/*.scss',
  coffee: 'coffee/*.coffee',
  images: 'images/**/*',
  dist: 'dist/'
};

gulp.task('copy-config', function () {
  return gulp
    .src('call-to-action.json')
    .pipe(gulp.dest(paths.dist));
});

gulp.task('copy-images', function () {
  return gulp
    .src(paths.images)
    .pipe(gulp.dest(paths.dist + "images"));
});

gulp.task('compile-coffee', function () {
  return gulp
    .src(paths.coffee)
    .pipe(plumber())
    .pipe(cached('coffee'))
    .pipe(coffee())
    .pipe(remember('coffee'))
    .pipe(concat('call-to-action.js'))
    .pipe(uglify({ mangle: false, annotations: false }))
    .pipe(gulp.dest(paths.dist));
});

gulp.task('compile-styles', function () {
  return gulp
    .src(paths.styles)
    .pipe(sass({ outputStyle: 'compressed' }))
    .pipe(gulp.dest(paths.dist));
});

gulp.task('watch', function (cb) {
  gulp.watch(paths.styles, gulp.parallel(['compile-styles']));
  gulp.watch(paths.coffee, gulp.parallel(['compile-coffee']));
  gulp.watch(paths.images, gulp.parallel(['copy-images']));
  cb();
});

gulp.task('default', gulp.series(
  'copy-config',
  'copy-images',
  'compile-coffee',
  'compile-styles',
  'watch'
));

gulp.task('build', gulp.series(
  'copy-config',
  'copy-images',
  'compile-coffee',
  'compile-styles'
));

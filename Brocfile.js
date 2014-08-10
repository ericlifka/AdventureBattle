/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');
var pickFiles = require('broccoli-static-compiler');
var mergeTrees = require('broccoli-merge-trees');

var app = new EmberApp();

app.import('vendor/lodash/dist/lodash.js');

app.import('vendor/bootstrap/dist/js/bootstrap.js');

var fonts = pickFiles('vendor/bootstrap/dist/fonts', {
    srcDir: '/',
    files: ['**/*'],
    destDir: '/fonts'
});

var bootstrapCssMap = pickFiles('vendor/bootstrap/dist/css/', {
    srcDir: '/',
    files: ['bootstrap.css.map'],
    destDir: '/assets'
});

var tree = mergeTrees([app.toTree(), fonts, bootstrapCssMap]);

module.exports = tree;


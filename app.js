// Generated by CoffeeScript 1.8.0
(function() {
  var Promise, WP, adj, animal, fs, name, path, wp, _;

  WP = require('wordpos');

  wp = new WP();

  Promise = require('bluebird');

  fs = require('fs');

  _ = require('lodash');

  path = require('path');

  Promise.promisifyAll(fs);

  animal = function() {
    return fs.readFileAsync(path.join(__dirname, 'animals.json'), 'utf8').then(JSON.parse).then(_.sample);
  };

  adj = function(letter) {
    return new Promise(function(resolve, reject) {
      if (letter != null) {
        return wp.randAdjective({
          startsWith: letter.toLowerCase()
        }, resolve);
      } else {
        return wp.randAdjective({}, resolve);
      }
    });
  };

  name = function() {
    var ad, an;
    ad = '';
    an = '';
    return animal().then(function(result) {
      an = result;
      return adj(an[0]);
    }).get(0).then(function(ad) {
      ad = ad[0].toUpperCase() + ad.slice(1, +ad.length + 1 || 9e9);
      return ad + ' ' + an;
    });
  };

  module.exports = {
    animal: animal,
    adj: adj,
    name: name
  };

}).call(this);

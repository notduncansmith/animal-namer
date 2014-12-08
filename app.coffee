WP = require 'wordpos'
wp = new WP()
Promise = require 'bluebird'
fs = require 'fs'
_ = require 'lodash'
path = require 'path'

defaultPath = path.join(__dirname, 'animals.json')

Promise.promisifyAll fs

capitalize = (s) ->
  s[0].toUpperCase() + s[1..s.length]

class AnimalNamer
  constructor: (animalPath) ->
    @path = animalPath or defaultPath
    @animals = []
    @indexed = {}
    @loaded = false

  # Get an animal (optionally starting with a letter)
  animal: (letter) -> @_maybeLoad().then =>
    new Promise (resolve, reject) =>
      if letter?
        resolve _.sample(@indexed[letter.toLowerCase()])
      else
        resolve _.sample(@animals)

  # Get an adjective (optionally starting with a letter)
  adj: (letter) -> @_maybeLoad().then =>
    promise = new Promise (resolve, reject) ->
      if letter?
        wp.randAdjective {startsWith: letter.toLowerCase()}, resolve
      else
        wp.randAdjective resolve

    promise
    .get 0
    .then capitalize

  # Alias
  adjective: (letter) -> @adj letter
      
  # Get a name (optionally starting with a letter)
  name: (letter) -> @_maybeLoad().then =>
    animal = ''

    @animal letter
    .then (result) => 
      animal = result
      @adj animal[0]
    .then (adjective) -> 
      "#{adjective} #{animal}"

  load: (filePath) ->
    fs.readFileAsync (filePath or @path), 'utf8'
    .then JSON.parse
    .then (data) =>
      @animals = data
      @indexed = @_index data
      @loaded = true
      return this

  loadSync: (filePath) ->
    data = fs.readFileSync (filePath or @path), 'utf8'
    data = JSON.parse animals

    @animals = data
    @indexed = @_index data
    @loaded = true
    return this

  _index: (animals) ->
    _.groupBy(animals, (s) -> s[0].toLowerCase())

  _maybeLoad: ->
    if @loaded
      return Promise.resolve(this)
    else
      return @load()

module.exports = AnimalNamer
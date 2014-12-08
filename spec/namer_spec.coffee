AnimalNamer = require '../app.coffee'
namer = new AnimalNamer()
path = require 'path'

describe 'AnimalNamer', ->

  # Load specs

  # These specs MUST RUN FIRST, because
  # they set up the namer instance 
  # to be used in the rest of the tests
  describe '#load', ->
    it 'loads and indexes the animal dictionary', (done) ->
      namer.load().then (result) ->
        expect(namer.animals[0]).toEqual 'Adelie'
        expect(namer.indexed.a[0]).toEqual 'Adelie'
        done()

    it 'loads a custom animal dictionary from a file path in the constructor', (done) ->
      loadPath = path.join __dirname, 'test.json'
      customNamer = new AnimalNamer(loadPath)    

      customNamer.load().then (result) ->
        expect(customNamer.animals[0]).toEqual 'Foo'
        done()
  
  # Name Specs
  describe '#name', ->
    it 'returns an alliterative name', (done) ->
      namer.name().then (result) ->
        [adjective, animal] = result.split ' '
        expect(adjective[0]).toEqual animal[0]
        done()

    it 'returns an alliterative name starting with the specified letter', (done) ->
      namer.name('a').then (result) ->
        [adjective, animal] = result.split ' '
        expect(animal[0]).toEqual 'A'
        done()

  # Adjective Specs
  describe '#adj', ->
    it 'returns an adjective', (done) ->
      namer.adj().then (result) ->
        expect(result).toEqual jasmine.any(String)
        done()

    it 'returns an adjective starting with the specified letter', (done) ->
      namer.adj('a').then (result) ->
        expect(result[0]).toEqual 'A'
        done()

  # Animal Specs
  describe '#animal', ->
    it 'returns an animal', (done) ->
      namer.animal().then (result) ->
        expect(result).toEqual jasmine.any(String)
        done()

    it 'returns an animal starting with the specified letter', (done) ->
      namer.animal('a').then (result) ->
        expect(result[0]).toEqual 'A'
        done()

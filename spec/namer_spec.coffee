AnimalNamer = require '../app.coffee'
namer = new AnimalNamer()
path = require 'path'

describe 'AnimalNamer', ->

  # Helper to generate checkForLoad tests
  checkForLoad = (method, it) ->
    it 'loads the animal list if it hasn\'t already been loaded', (done) ->
      unloaded = new AnimalNamer()
      spyOn(unloaded, 'load').andCallThrough()

      unloaded[method]().then -> unloaded[method]()
      .then ->
        expect(unloaded.load.calls.length).toEqual 1  
        done()

  # Load specs

  # These specs MUST RUN FIRST, because
  # they set up the namer instance 
  # to be used in the rest of the tests
  describe '#load', ->
    it 'loads the animal dictionary', (done) ->
      namer.load().then (result) ->
        expect(namer.animals[0]).toEqual 'Adelie'
        done()

    it 'indexes the animal dictionary', (done) ->
      namer.load().then (result) ->
        expect(namer.indexed.a[0]).toEqual 'Adelie'
        done()

    it 'loads a custom animal dictionary from a file path in the constructor', (done) ->
      loadPath = path.join __dirname, 'test.json'
      customNamer = new AnimalNamer(loadPath)    

      customNamer.load().then (result) ->
        expect(customNamer.animals[0]).toEqual 'Foo'
        done()

    it 'marks the namer as loaded', (done) ->
      unloaded = new AnimalNamer()
      unloaded.load().then -> 
        expect(unloaded.loaded).toEqual true
        done()

  # Synchronous Loading Specs
  describe '#loadSync', ->
    it 'loads the animal dictionary', ->
      unloaded = new AnimalNamer()
      unloaded.loadSync()
      expect(unloaded.animals[0]).toEqual 'Adelie'

    it 'indexes the animal dictionary', ->
      unloaded = new AnimalNamer()
      unloaded.loadSync()
      expect(unloaded.indexed.a[0]).toEqual 'Adelie'

    it 'loads a custom animal dictionary from a file path in the constructor', ->
      loadPath = path.join __dirname, 'test.json'
      customNamer = new AnimalNamer(loadPath)    

      customNamer.loadSync()
      expect(customNamer.animals[0]).toEqual 'Foo'

    it 'marks the namer as loaded', ->
      unloaded = new AnimalNamer()
      unloaded.loadSync()
      expect(unloaded.loaded).toEqual true

  
  # Name Specs
  describe '#name', ->
    checkForLoad('name', it)

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
    checkForLoad('adj', it)

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
    checkForLoad('animal', it)

    it 'returns an animal', (done) ->
      namer.animal().then (result) ->
        expect(result).toEqual jasmine.any(String)
        done()

    it 'returns an animal starting with the specified letter', (done) ->
      namer.animal('a').then (result) ->
        expect(result[0]).toEqual 'A'
        done()

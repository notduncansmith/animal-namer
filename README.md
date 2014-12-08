# Animal-Namer

Animal names for everybody!

```
npm install animal-namer
```

# What?

This module generates alliterative phrases in the following format: `{adjective} {animalName}`

Examples:

```
  Overfull Okapi
  Decrepit Donkey
  Minuscule Mongoose
```


# Why?

I wanted a way to generate simple, fun, ephemeral usernames.


# How? (Usage)

## Setup

```javascript
var AnimalNamer = require('animal-namer');
namer = new AnimalNamer();

// You can use your own file instead
// Just put an array of strings into the file
customNamer = new AnimalNamer('path/to/my/animals.json'); 
```

## Get a name

All public methods return Promises (see the [Bluebird](https://github.com/petkaantonov/bluebird) docs for more info).

```javascript
namer.name().then(console.log); // => "Exemplary Elephant"
```

## Other Stuff
You can also use the `adj` or `animal` methods to get just an animal or adjective.
Either of these methods optionally take a single-letter argument, which the returned value will start with.

```javascript
namer.adj('s').then(console.log); // => "Salacious"
namer.animal().then(console.log); // => "Aardvark"
namer.adjective('s').then(console.log); // alias for `adj`
```

**Note that the list of animals is not immediately loaded.**

When you call one of `animal`, `name`, or `adj` for the first time, AnimalNamer will read the animal list from the configured file. The result will be stored, so subsequent calls will not trigger a file-system read.

However, you can explicitly load them in advance:

```javascript
// Use the packaged animal file
namer.load();

// Or use your own file
namer.load('path/to/my/animals.json');

// You can also load synchronously
namer.loadSync();

// And yes, you can still use your own file
namer.loadSync('path/to/my/animals.json');
```


# Contributors

Duncan Smith ([notduncansmith](https://github.com/notduncansmith))
Nicole Whitehead ([ncwhitehead](https://github.com/ncwhitehead))



# Contributing

I'm happy to review any pull requests!  

I just ask that you follow a few guidelines before submitting:

- All tests must pass
- Add tests for any new features
- Remember to compile to Javascript


# License and stuff

MIT License

Copyright 2014 Duncan Smith
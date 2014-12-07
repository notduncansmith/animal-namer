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
  Liveborn Lemur
  Decrepit Donkey
  Minuscule Mongoose
  Sculptural Salamander
```

# Why?

I wanted a way to generate simple, fun, ephemeral usernames.


# How? (Usage)

All methods return Promises (see the [Bluebird](https://github.com/petkaantonov/bluebird) docs for more info).


```javascript
var namer = require('animal-namer');
```

## Get a name
```javascript
namer.name().then(console.log); // => "Exemplary Elephant"
```

## Other stuff
You can also use the `adj` or `animal` methods to get just an animal or adjective.

```javascript
namer.adj('s').then(console.log); // => "salacious"
namer.animal().then(console.log); // => "Aardvark"
```


MIT License

Copyright 2014 Duncan Smith
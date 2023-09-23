---
title: "JS: Check if an object is empty"
date: 2023-07-02T17:34:52+03:00
draft: false
images: [/js/js-is-object-empty/thumbnail.png]
tags: [js, programming]
---

The problem: we want to check if an object is empty.
Spoiler: simply checking for `null` is not enough.

<!--more-->

## Null and undefined

First thing we can do for all types of object is to check if
a variable contains `null` or `undefined`:

```
if (a === null || a === undefined) {
	return true
}
```

## Check if an object has any properties

Then, we need to check most obvious case - our object is
not null or undefined, but it is has a `{}` form. The problem is
that we can't check for `{}` directly, because javascript
compares objects by their reference:

```
// Prints "Not empty!"
const a = {}
if (a == {}) {
	console.log("Empty")
} else {
	console.log("Not empty!")
}
```

To check if an object has a property, we can iterate over all
its properties (including prototype chain) and use `Object.hasOwnProperty`
to check if a property is a target object's property:

```
for (key in a) {
	if (Object.hasOwnProperty(key)) {
		return false;
	}
}
```

We need to find at least one own property to know that the object
is not empty, so we return false as soon as we find one.

We can also use `Object.keys()` function to get object's own keys:

```
if (Object.keys(a).length === 0) {
	return false;
}
```
## Arrays

Well done with "classic" objects, but arrays are objects too, and
our previous method doesn't work:

```
let a = [];
// Prints "[]"
console.log(Object.keys(a));

// Prints nothing
for (key in a) {
	console.log(key)
}
```

Instead, we can check Array's `length` property:

```
if (Array.isArray(a) && a.length === 0) {
	return true
}
```

We used [isArray](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/isArray)
function to check if the target object is an array.


## Maps and Sets

Maps and Sets are also objects, and they have a `size` function that
returns the count of elements they contain, but they don't have something like
`isArray`, so we're going to use [Object.prototype.toString](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/toString).

>Object.prototype.toString() returns "[object Type]", 
>where Type is the object type. If the object has a 
>`Symbol.toStringTag` property whose value is a string,
>that value will be used as the Type.
>Many built-in objects, including Map and Symbol, have a `Symbol.toStringTag`

`Object.prototype.toString().call()` returns the object's type, and we
can use it for maps and sets:

```
const tag = Object.prototype.toString().call(a);
if (a === "[object Set]" || a === "[object Map"]) {
	return a.size() === 0;
}
```

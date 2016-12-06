Title: Notes on Porting Python2 to Python3
Date: 06/27/2016

While I've been writing Python on and off for scientific applications for about ten years now, I have not moved to python 3. The reason is basically because I haven't ever needed to use it. Numpy and Maptlotlib largely consists of everything I need. I'd like to be able to do more things for hobby projects so let's just get the transition over with.

# Porting Python 2.x to Python 3.x

## Automated tools

`2to3` is a builtin tool in Python 2 which will automatically convert the easiest transitions on Python2 code automatically. It creates a basic diff file, but to overwrite on a file instead add the `-w -n` flags.

[futurize](http://python-future.org) is a tool which is mainly for updating your Python2 code into Python3 code which will continue to run under Python2.

## Types

### Numbers

Python2 has different types for whole numbers depending on whether it fits within a machine word (32bytes) in which it is an `int` type. Longer numbers are known as `long`. 

In Python3 _all_ numbers are of type `int`.

Division between integers will give Float types in Python3, `3/2 = 1.5`.

Octal numbers are represented only as `0o###`, `0###` no longer valid.

### Unicode

In unicode number of characters does not correspond to number of bytes. Many characters can be of a size larger than one byte.

In python3 unicode strings are the default. Now text and bytestrings are different types and should not be compared or assigned to eachother.

Rules: Decode to unicode from input as soon as possible, and if outputting bytestrings encode from unicode as late as possible.

Use str.encode() and str.decode(), the `b'bytestringhere'` indicates information is a bytestring. Either mark it or alternatively use the bytearray type which is more efficient for manipulation.

When converting an object to a string using `str(foo)` which calls `def __str__(self)` the default return value was a bytestring. In python3 the default is a unicode string, so the `__str__` method should return unicode strings.

### Booleans

In Python2 calling `bool(foo)` calls `foo.__nonzero__()`. In python3 it calls `foo.__bool__()` instead as the concept of 0 and False have been separated.

### Files

Python2 uses file() which operates only on bytestrings, and does uses a buffered mode which can hinders performance.

Python3 has replaced this with io.FileIO which provides read(), write(), and readinto() and corresponds to single system calls for better performance.

Conversely the open() and io.open() methods provide buffered file access which may do more than one system call.

### Exceptions

Python2
```
try:
    something()
except ValueError, e:
    print e

raise Exception, 'argument'
```

Python3
```
try:
    something()
except ValueError as e:
    print e

raise Exception('argument')
```

Python3 supports nested Exceptions, such that raising Exceptions within Exceptions (if you want to capture exceptions) will list all exceptions encountered. In python2 only the last exception is raised.

### Classes

For metaclasses, syntax is changed

Python2
```
class A:
    __metaclass__ == Singleton
```

Python3
```
class A(metaclass=Singleton):
    pass
```

Iterators have syntax changes

Within a class:
Python2 - `def next(self)`
Python3 - `def __next__(self)`

Call syntax:
Python2 - `foo.next()`
Python3 - `next(foo)`

### Dictionaries

Additionally dictionary methods `keys(), values(), items()` all return iterators instead of lists now so the `iterkeys(), itervalues(), iteritems()` methods are obsolete.

To iterate over keys in Python3 - `for key in dictionary:`

To iterate over values in Python3 - `for value in dictionary.values():`

For doing both `for (key, value) in dictionary.items()`

### Print

`print(*objects, sep=' ', end='\n', file=sys.stdout, flush=False)`

### Misc

`xrange` has been removed in python3, now `range` always returns an iterator instead of a list.

`raw_input` has been replaced with `input`.

`execfile` no longer exists, so use `exec(open(path).read())`

StringIO library lets you input strings into functions which ask for a file-like object. In Python3 it's organized as `io.StringIO` for unicode and `io.BytesIO` for binary.

Lots of stuff organized now in the `collections` module, instead of several separate libraries.

The `commands` module no longer exists, all functionality rolled into `subprocess` module.

Python2 HTTP libraries had several different libraries. Now everything is in `http` module. All functions and classes did not change. Same scenario with the `urllib` libraries, `xmlprc` related libraries.

`itertools` library return iterators for everything instead of lists and iterators. So i-prefix is no longer used such as `izip_longest`, now it's just `zip_longest`.

Relative imports must now be specified more clearly. So if importing `foo.py` in the same directory as the script, using `from . import foo`

Functional methods like `map` and `fliter` returns an iterator, so again call `list` method on the output.

The `reduce()` function is now in `functools`, `apply()` has been deprecated for the `f(*args, **kwargs)` syntax, `cmp()` and `__cmp__()` are no longer used and instead use functions such as `__lt__()` for comparisons.

# General Tips

Refactor in order to : 
* Stop repeating code
* Avoid having to change large amounts of code in order to add new features
* Reduce complexity

How to refactor:
* Identify bad code
* Improve it
* Run tests and improve tests
* Repeat

Refactoring consists of:
* Renaming, splitting, moving code and modules
* Simplify scope of modules
* Redraw boundaries and responsibilities between classes and modules

In comparisons and if statements pull out implicit variables for example
```python
if 8 > month > 4:
    ...

summer = 8 > month > 4
if summer:
    ...
```
No performance penalty in Python for doing so.

If you have a class with two methods, one of which is init .. convert to a function!

Strongly prefer to use built-in exceptions.

Improve readability by clarifying functions calls with keyword arguments, except in a tight loop.

Clarify multiple return values with namedtuples, which are a subclass of tuple.

Unpack sequences inline
```python
fname = p[0]
lname = p[1]

fname, lname = p
```

Use tuples to update multiple state variables `x, y = y, x`

If you are using del, pop, or inserting at the beginning of a list, convert to a deque instead. lists are not efficient at changing the first element.

`@cache` to avoid doing multiple lookups.

```
with ignored(Exception): 
    statement
```

Redirecting stdout: `with redirect_stdout(foo):`

Basically lots of cool stuff in contextlib.

Use iterator expressions `sum([i for i in range(10)])` -> `sum(i for i in range(10))`.

# Tips

Looping backwards through an iterator: `for item in reversed(iterable)`.

Or in sorted order: `for item in sorted(iterable, reverse=[False, True], key=foo)`, key functions are much more efficient than comparison functions, and are removed in python3.

`iter()` can take a second argument, a sentinel value indicating when to stop iterating.

`for` loops can be followed by an `else` statement, indicating that the loop finished without a `break` statement being executed.

Don't change a dictionary while iterating over it, instead create a copy of the keys `for k in d.keys()` to iterate over.

Create a dictionary easily from two lists, `d = dict(zip(keys, values))`.

`dict.setdefault(key, defaultvalue)` for calling keys that may not exist, better method is `defaultdict(defaultvalue)` instead of dictionary.

To combine the keys of multiple dictionaries, in an order of precedence, can either use 
```python
d = default_dict.copy()
d.update(dict1)
d.update(dict2)
```
or a ChainMap, `d = ChainMap(dict2, dict1, default_dict)` which is very efficient.

# Resources

Every single video, article, email, napkin scribble by Raymond Hettinger
Clean Code (book)
Effective Python by Slatkin

# Class Design In Python 3

Module docstrings are good, start with documentation. In python 3 `class Class: -> class Class(object):`, automatically inherits from `object` unlike Python 2.

`__init__` is _not_ a constructor, by the time of `__init__` it's already been created in order to pass `self`.

# Python Internals

Python first 'disassembles' your script into python bytecode. Can view this using the `dis` library, easy example is `python -m dis script.py`.

Python contains a value stack, `LOAD_CONST` pushes an object onto the stack. `STORE_NAME` pops off the top of the stack, associates it with a name, and stores it elsewhere in memory. `LOAD_NAME` takes what the variable refers to and puts it back onto the value stack. Really there is only ever one copies of the object, it's just the references (pointers) that get created. This is part of the reference counting aspect of python's garbage collection.

In addition to the valuestack there is a framestack, in which ecah frame contains all of the local names and objects.
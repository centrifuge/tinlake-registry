# tinlake-registry
A registry keeps track of a set of values that can be updated through
system-external logic. An example use case is a price feed that occassionally
updtaes a list with new prices.

## Push & Pull
There are two patterns of the registry: Push and Pull. A push-registry has a
method `update` that needs to be called to update the value. When a value is read
using `get` it simply reads the contract's state.

The pull pattern is the reverse. It does not have a method `set` but requires
implementing an `update` method that will is called in the `get` method and
should the value.

## Sum
In many places we don't just want to keep track of a list of values but also the
sum of all values. `Sum(Pull|Push)Registry` implements this functionality.


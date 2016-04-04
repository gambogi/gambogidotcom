---
title:  Structuring Computation 
author: Matt Gambogi
---

You may remember vectors as the arrows that described various forces in some
physics word problem. Given a particular force on an object, it could be
decomposed into component $x$, $y$, and $z$ force vectors.  To solve these
problems, it's possible to use most of solving techniques taught in Algebra I.
The exception to this is you cannot multiply two force vectors. The operation
is simply not defined. Which is good, because it's not at all clear what
multiplying two forces would even mean physically. But physics is far from the
only time vectors crop up as a modeling solution. They specify the font this
post is displayed in. They can also be used to describe points in machine
learning models. When a user is being described in those systems, each of their
attributes can be thought of as a component vector. Things like browser, ip,
time of day, etc. -- all vectors.

So how can you know when a vector space is an appropriate way to describe a
system? What makes vectors vectors? A vector can be anything, provided it has
definitions of addition and multiplication which satisfy some axiomatic
properties. It's possible to give definitions of multiplication and addition
that don't satisfy these properties, but are useful for modeling some system.
The great advantage of vectors is that once you frame your problem in terms of
them, all existing proofs surrouding vector spaces hold true.

**Definition:** A vector space over a field $F$ (a set of numbers called
scalars) is a set $V$ (called vectors) with defintions of addition and
multiplication which satisfy (in no particular order):

- Associativity of addition
  $$(\textbf{u} + \textbf{v}) + \textbf{w}  = \textbf{u} + (\textbf{v} + \textbf{w})$$
- Commutativity of addition
  $$\textbf{u} + \textbf{v} = \textbf{v} + \textbf{u}$$
- Identity element of addition
  $$\textbf{u} + \textbf{I} = \textbf{u}$$
- Inverse elements of addtion
  $$\textbf{u} + (-\textbf{u}) = \textbf{0}$$
- Compatibility of scalar multiplication with field multiplication
  $$a(b\textbf{v}) = (ab)\textbf{v}$$
- Identity element of scalar multiplication

- Distributivity of scalare multiplication with respect to vector addition
  $$a(\textbf{u} + \textbf{v}) = a\textbf{u} + \textbf{v}$$
- Distributivity of scalare multiplication with respect to field addition

An algebraic structure is composed of a set of objects it can work on, some
number of functions definited on those objects, and some properties the two
must satisfy together.

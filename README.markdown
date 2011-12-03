Enumerating
===========

Lazy "filtering" and transforming
---------------------------------

Enumerating extends Enumerable with "lazy" versions of various common operations:

* `#selecting` selects elements that pass a test block (like `Enumerable#select`)
* `#finding_all` is an alias for `#selecting` (like `Enumerable#find_all`)
* `#rejecting` selects elements that fail a test block (like `Enumerable#reject`)
* `#collecting` applies a transforming block to each element (like `Enumerable#collect`)
* `#mapping` is an alias for `#collecting` (like `Enumerable#map`)
* `#uniqing` discards duplicates (like `Enumerable#uniq`)
* `#taking`, `#taking_while`, `#dropping` and `#dropping_while` also do what you expect
* '#[]' gets the nth element of a collection

We say the "...ing" variants are "lazy", because they defer per-element processing until the result is used.  They return Enumerable "result proxy" objects, rather than Arrays, and only perform the actual filtering (or transformation) as the result proxy is enumerated.

Perhaps an example would help.  Consider the following snippet:

    >> (1..10).collect { |x| puts "#{x}^2 = #{x*x}"; x*x }.take_while { |x| x < 20 }
    1^2 = 1
    2^2 = 4
    3^2 = 9
    4^2 = 16
    5^2 = 25
    6^2 = 36
    7^2 = 49
    8^2 = 64
    9^2 = 81
    10^2 = 100
    => [1, 4, 9, 16]

Here we use plain old `#collect` to square a bunch of numbers, and then grab the ones less than 20. We can do the same thing using `#collecting`, rather than `#collect`:

    >> (1..10).collecting { |x| puts "#{x}^2 = #{x*x}"; x*x }.take_while { |x| x < 20 }
    1^2 = 1
    2^2 = 4
    3^2 = 9
    4^2 = 16
    5^2 = 25
    => [1, 4, 9, 16]

Same result, but notice how only the first five inputs were ever squared; just enough to find the first result above 20.

Lazy pipelines
--------------

By combining two or more of the lazy operations provided by Enumerating, you can create an efficient "pipeline", e.g.

    # enumerate all users
    users = User.to_enum(:find_each)

    # where first and last names start with the same letter
    users = users.selecting { |u| u.first_name[0] == u.last_name[0] }

    # grab their company (weeding out duplicates)
    companies = users.collecting(&:company).uniqing

    # resolve
    companies.to_a              #=> ["Disney"]

Because each processing step proceeds in parallel, without creation of intermediate collections (Arrays), you can efficiently operate on large (or even infinite) Enumerable collections.

Lazy combination of Enumerables
-------------------------------

Enumerating also provides some interesting ways to combine several Enumerable collections to create a new collection.  Again, these operate "lazily".

`Enumerating.zipping` pulls elements from a number of collections in parallel, yielding each group.

    array1 = [1,3,6]
    array2 = [2,4,7]
    Enumerating.zipping(array1, array2)    # generates: [1,2], [3,4], [6,7]

`Enumerating.concatenating` concatenates collections.

    array1 = [1,3,6]
    array2 = [2,4,7]
    Enumerating.concatenating(array1, array2)
                                           # generates: [1,3,6,2,4,7]

`Enumerating.merging` merges multiple collections, preserving sort-order.  The inputs are assumed to be sorted already.

    array1 = [1,4,5]
    array2 = [2,3,6]
    Enumerating.merging(array1, array2)    # generates: 1, 2, 3, 4, 5, 6

Variant `Enumerating.merging_by` uses a block to determine sort-order.

    array1 = %w(a dd cccc)
    array2 = %w(eee bbbbb)
    Enumerating.merging_by(array1, array2) { |x| x.length }
                                            # generates: %w(a dd eee cccc bbbbb)

Same but different
------------------

There are numerous similar implementations of lazy operations on Enumerables.  A nod, in particular, to:

* Greg Spurrier's gem "`lazing`" (from which Enumerating borrows the convention of using "..ing" to name lazy methods)
* `Enumerable#defer` from the Ruby Facets library

In the end, though, I felt the world deserved another.  Enumerating's selling point is that it's basic (filtering/transforming) operations work on any Ruby, whereas most of the other implementations depend on the availablity of Ruby 1.9's "`Enumerator`".  Enumerating has been tested on:

* MRI 1.8.6
* MRI 1.8.7
* MRI 1.9.2
* JRuby 1.5.3
* JRuby 1.6.0
* Rubinius 1.2.3

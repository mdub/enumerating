EnumerableFu
============

Lazy "filtering" and transforming
---------------------------------

EnumerableFu extends Enumerable with "lazy" versions of various common operations:

* `#selecting` selects elements that pass a test block (like `Enumerable#select`)
* `#rejecting` selects elements that fail a test block (like `Enumerable#reject`)
* `#collecting` applies a transforming block to each element (like `Enumerable#collect`)
* `#uniqing` discards duplicates (like `Enumerable#uniq`)

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

By combining two or more of the lazy operations provided by EnumerableFu, you can create an efficient "pipeline", e.g.

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

EnumerableFu also provides some interesting ways to combine several Enumerable collections to create a new collection.  Again, these operate "lazily".

`EnumerableFu.zipping` pulls elements from a number of collections in parallel, yielding each group.

    array1 = [1,3,6]
    array2 = [2,4,7]
    EnumerableFu.zipping(array1, array2)    # generates: [1,2], [3,4], [6,7]

`EnumerableFu.merging` merges multiple collections, preserving sort-order.  The inputs are assumed to be sorted already.

    array1 = [1,4,5]
    array2 = [2,3,6]
    EnumerableFu.merging(array1, array2)    # generates: 1, 2, 3, 4, 5, 6

Variant `EnumerableFu.merging_by` uses a block to determine sort-order.

    array1 = %w(a dd cccc)
    array2 = %w(eee bbbbb)
    EnumerableFu.merging_by(array1, array2) { |x| x.length }
                                            # generates: %w(a dd eee cccc bbbbb)

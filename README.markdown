EnumerableFu
============

"EnumerableFu" extends `Enumerable` with "lazy" versions of various operations, 
allowing streamed processing of large (or even infinite) collections.

It also provides some interesting ways of combining Enumerables.

Filters
-------

`selecting` (cf. `select`, or `find_all`) returns each element for which the given block is true

    (1..6).selecting { |x| x.even? }        # generates: 2, 4, 6

`rejecting` (cf. `reject`) returns each element for which the given block is false:

    (1..6).rejecting { |x| x.even? }        # generates: 1, 3, 5

`collecting` (cf. `collect`, or `map`) applies a block to each element:

    [1,2,3].collecting { |x| x*2 }          # generates: 2, 4, 6

`uniqing` (cf. `uniq`) returns unique elements:

    [2,1,2,3,2,1].uniqing                   # generates: 2, 1, 3

Unlike the original methods, the "...ing" variants each return an immutable Enumerable object, rather than an Array.  The actual processing is deferred until the result Enumerable is enumerated (e.g. with `each`), and elements are produced "just in time".

Mixers
------

`Enumerable.zipping` pulls elements from a number of Enumerables in parallel, yielding each group.

    array1 = [1,3,6]
    array2 = [2,4,7]
    Enumerable.zipping(array1, array2)      # generates: [1,2], [3,4], [6,7]

`Enumerable.merging` merges multiple Enumerables, preserving sort-order.  The inputs are assumed to be sorted already.

    array1 = [1,4,5]
    array2 = [2,3,6]
    Enumerable.merging(array1, array2)      # generates: 1, 2, 3, 4, 5, 6

Variant `Enumerable.merging_by` uses a block to determine sort-order.

    array1 = %w(a dd cccc)
    array2 = %w(eee bbbbb)
    Enumerable.merging_by(array1, array2) { |x| x.length }
                                            # generates: %w(a dd eee cccc bbbbb)

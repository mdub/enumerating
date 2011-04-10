EnumerableFu
============

"EnumerableFu" extends Enumerable with "lazy" versions of various operations, 
allowing streamed processing of large (or even infinite) collections.

Filters
-------

EnumerableFu extends Enumerable with "lazy" versions of various popular methods:

  * `selecting` (cf. `select`, or `find_all`) returns each element for which the given block is true

        (1..6).selecting { |x| x.even? }.to_a   #=> [2,4,6]

  * `rejecting` (cf. `reject`) returns each element for which the given block is false:

        (1..6).rejecting { |x| x.even? }.to_a   #=> [1,3,5]

  * `collecting` (cf. `collect`, or `map`) applies a block to each element:
  
        [1,2,3].collecting { |x| x*2 }.to_a     #=> [2,4,6]
    
Unlike the original methods, the "...ing" variants each return an immutable Enumerable object, rather than an Array.  The actual processing is deferred until the result Enumerable is enumerated (e.g. with `each`), and elements are produced "just in time".

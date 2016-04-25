#lang scheme

;Helper function for question 1 and 2.1, sums all numbers in the list

(define (sumNum L)
  (if (null? L) 0
      (+ (car L) (sumNum(cdr L))))
  )


#|
Question 1:
A kind of filter operation is defined as taking the weighted average of neighbouring elements in a list. 
The result is obtained by first normalizing the filter coefficients to sum to 1, i.e., 1+2+3+4=10 therefore
the coefficients have to be divided by 10 and the filter becomes (1/10 2/10 3/10 4/10). Next the
normalized filter coefficients are applied to the list '(1.0 1.0 2.0 3.0 5.0 8.0 13.0).
Design the function filter to return the application of the filter to a list.
Note that filter and list can have arbitrary length. For example: 
|#

(define (mult L1 L2 x)
  (if (> (length L1) (length L2))
      (if(null? L1)
         0
         (+(*(/ (car L1) x) (car L2))(mult (cdr L1)(cdr L2) x)))
       (if(null? L2)
         0
         (+(*(/ (car L1) x) (car L2))(mult (cdr L1)(cdr L2) x)))
      )
  )

(define (filer L1 L2)
  (if (null? L1) null
      (if (null? L2) null
          (list (mult L1 L2 (sumNum L1)) (filter L1 (cdr L2)))
          )
      )
  )

#|
Question 2.1:
Design a function that takes a list of characters and numbers and adds up all the
numbers returning the list of characters unchanged but only the sum of the numbers. 
|#

(define (listSym L)
      (list (car L) listSym (cdr L))
  )

(define (num L)
  (if (number? (car L)) (list (car L) (num (cdr L)))
  (null)
  )
 )



(define (sumNumbers L)
  (if (null? L) 0
      (list(listSym L) (sumNum (num L)))
      )
  )



#|
Question 2.2:
Design a function that converts a positive decimal integer into the quaternary numeral
system (base 4). 
|#

(define (quaternay x)
     (cond ((zero? (quotient x 4)) x)
     (else (+(* 10 (quaternay (quotient x 4)))(remainder x 4))))
  )


#|
Question 3.1:
Create the function (cubeLess x b) which calculates the power of 3 and the remainder
such that b =x^3 + r and returns the remainder r.
|#

(define (cubeless x b)
  (- b (expt x 3))
  )

#|
Question 3.2:
Use the function cubeLess from Question 1 to find all numbers with a cube smaller than a
given limit by creating a new function (smallerCube b) that generates the results as a list.  
|#

(define (smallerCube2 b x L)
  (if (< (cubeless x b) 0) L
      (smallerCube2 b (+ 1 x) (append L (cons (cons x (cons (cubeless x b) null)) null)))))

(define (smallerCube b)
  (smallerCube2 b 1 '()))

#|
Question 3.3:
Create a helper function (restSum S) to add up all the remainders from finding all
cubes up to an upper limit in 2
|#

(define (restSum L)
  (sum L 0))

(define (sum L s)
  (if (null? L) s
  (sum (cdr L) (+ s (car (cdar L))))
   )
 )

#|
Question 3.4:
Write another function to add all the rest sums that are multiples of 3 within a range
into a list.
|#

(define (showAllRestSum x y)
  findSum x y '())

(define (findSum x y L)
  (if (> y x) (if (eqv? 0 (modulo (restSum (smallerCube x)) 3))
                  (findSum (+ 1 x) y (append L (cons (cons x (cons (restSum (smallerCube x)) null)) null)))
                  (findSum (+ 1 x) y L))
      L))

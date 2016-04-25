#lang racket

#|
Question 1:
Write a function mergeALot that takes a list of sorted lists and merge them into one sorted list.
If the top-level list contains entries which are not sorted, than your function must return an error
message indicating which is the offending list. 
|#

(define (sorted? l)
  (cond ((null? l) #t)
        ((eq? (length l) 1) #t)
        ((> (car (cdr l)) (car l))
        (sorted? (cdr l)))
  (else #f))
)

(define (notSorted l newList countList)
  (cond[(null? l) (sort newList <)]
    [(sorted? (car l)) (notSorted (cdr l) newList (+ 1 countList))]
     [else (notSorted (cdr l) (append (list countList) newList) (+ 1 countList))]
     )
  )

(define (mergeALot l)
              (cond [(null? (cdr l)) (sort(car l) <)]
                [(null? l) l]
              [(andmap sorted? l)
               (sort(append (car l) (mergeALot (cdr l))) <)]
              [(not(andmap sorted? l))
               (display "ERROR: The following lists are not sorted: ") (display(notSorted l '() 1))]
              )
  )

#| Question 2:
The more terms are used in the calculation, the more precise the result becomes. Write a function in
Scheme which accepts a number -1 < x < 1 and a precision 0 < e < 1. The function must return the
value of log(1 + x) with a precision e and the number of terms necessary to reach this precision. 
|#


(define (ourLog x e)
  (cond [(and (> e 0) (< 1 e)) (display "ERROR: Precision is not in range")]
        [(and (> x -1) (< 1 x)) (display "ERROR: Number is not in range")] 
        [else (checkPrecision x e 1)]
  
  )
 )

;Calculates X given terms. Counter is always set to 1
(define (calculateX x terms counter)
  (if (> terms counter)
      (+ (* (expt -1 (+ 1 counter)) (/ (expt x counter) counter)) (calculateX x terms (+ 1 counter)))
      (* (expt -1 (+ 1 counter)) (/ (expt x counter) counter))
  )
 )


;Checks calculated precision with the given.
;If calculatedPrecision < e, return X and number of terms to reach the precision
(define (checkPrecision x e terms)
  (if (< (calculatePrecision x terms) e)
     (list (calculateX x (+ 1 terms) 1) (+ 1 terms))
     (checkPrecision x e (+ terms 1))
 )
 )

;Calculates the precision using x and terms given
(define (calculatePrecision x terms)
  (abs(-(calculateX x terms 1) (calculateX x (+ 1 terms) 1)))
 )

#|
Question 3:
Write a function lca for finding the smallest common ancestor for two nodes in a tree. When
writing (lca T k1 k2), your Scheme expression must return the t sub-tree whose root is the lowest
common ancestor being between k1 and k2.
|#


(define (lca tree key1 key2)
(cond
  [(not(exist tree key1)) '()]
  [(not(exist tree key2)) '()]
  [(and (> (car tree) key2)(> (car tree) key1)) (lca (cadr tree) key1 key2)]
  [(and (< (car tree) key2)(< (car tree) key1)) (lca (caddr tree) key1 key2)]
  [(and (> (car tree) key1)(< (car tree) key2)) (list tree)]
  [else #f]
  )
 )

(define (exist tree key)
  (cond
    [(null? tree) #f]
    [(equal? (car tree) key) #t]
    [(< key (car tree)) (exist (cadr tree) key)]
    [(> key (car tree)) (exist (caddr tree) key)]
    [else #f]
    )
  )



#lang racket
(define (removeLetter string char)
  (list->string (removeLetter2 (string->list string) char))
  )

(define (removeLetter2 list char)
  (cond
    [(empty? list) list]
    [(empty? (cdr list)) list]
    [(equal? (car list) char) (removeLetter2 (cdr list) char)]
    [else (cons (car list) (removeLetter2 (cdr list) char))]
    )
  )
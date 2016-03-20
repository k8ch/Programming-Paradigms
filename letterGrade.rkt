#lang racket

(define (letterGrade x)
  (cond
        [(<= x 39) 'F]
        [(<= x 49) 'E]
        [(<= x 54) 'D]
        [(<= x 59) 'D+]
        [(<= x 64) 'C]
        [(<= x 69) 'C+]
        [(<= x 74) 'B]
        [(<= x 79) 'B+]
        [(<= x 84) 'A-]
        [(<= x 89) 'A]
        [(<= x 100) 'A+]
       ))
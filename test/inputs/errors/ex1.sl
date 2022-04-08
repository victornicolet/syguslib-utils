(set-logic LIA)
(define-fun ((x Int) (y Int)) Int (ite (>= x y) x y))

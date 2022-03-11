(set-logic LIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
; This is not a Sygus command!
(define-const m Int)

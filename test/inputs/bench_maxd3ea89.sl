(set-logic LIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun xi_1 ((x6 Int) (x7 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x6 x7 (- Ix) (+ Ix Ix) (max Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var i0 Int)
(declare-var i4504 Int)
(constraint
 (or (not (and (or (not (= i0 (max i0 p))) (= i0 (max i0 i4504))) (= i0 (max i0 p))))
  (= (max i0 (max p i4504)) (xi_1 p i0))))
(check-synth)

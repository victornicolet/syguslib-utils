(set-logic LIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun xi_1 ((x0 Int) (x1 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x0 x1 (- Ix) (+ Ix Ix) (max Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var i0 Int)
(declare-var i1 Int)
(constraint (= (max i0 (max p i1)) (xi_1 p i0)))
(check-synth)

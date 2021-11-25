(set-logic LIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join1 ((x Int) (x0 Int) (x1 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x x0 x1 (- Ix) (+ Ix Ix) (max Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var i Int)
(constraint (or (not (>= i 0)) (= (max (+ i p) 0) (join1 p i 0))))
(check-synth)

(set-logic LIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun f0 ((x4 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x4 (- Ix) (+ Ix Ix) (max Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var i3 Int)
(declare-var i4 Int)
(constraint (or (not (= i3 i4)) (= (+ 1 (max i3 i4)) (f0 i3))))
(check-synth)

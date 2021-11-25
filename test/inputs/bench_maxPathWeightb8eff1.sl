(set-logic LIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join ((x2 Int) (x3 Int) (x4 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x2 x3 x4 (- Ix) (+ Ix Ix) (max Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p5 Int)
(constraint (= (max p p) (join p 0 0)))
(constraint (= (max (max (+ p p5) (+ p p5)) p) (join p 0 (max (+ 0 p5) (+ 0 p5)))))
(check-synth)

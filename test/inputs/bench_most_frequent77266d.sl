(set-logic LIA)
(synth-fun s00 ((x Int) (x0 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x x0 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var i0 Int)
(constraint (or (not true) (= 1 (s00 i0 1))))
(check-synth)

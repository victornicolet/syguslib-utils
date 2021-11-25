(set-logic LIA)
(synth-fun op ((x Int) (x0 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x x0 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(check-synth)

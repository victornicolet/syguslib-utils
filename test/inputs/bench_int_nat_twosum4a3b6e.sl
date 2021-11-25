(set-logic LIA)
(synth-fun add1 ((x0 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x0 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(check-synth)

(set-logic LIA)
(synth-fun join2 ((x3 Int) (x4 Int) (x5 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x3 x4 x5 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(check-synth)

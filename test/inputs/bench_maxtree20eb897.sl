(set-logic LIA)
(synth-fun join ((x0 Int) (x1 Int) (x2 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x0 x1 x2 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(check-synth)

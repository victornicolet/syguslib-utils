(set-logic LIA)
(synth-fun j2 ((x1 Int) (x2 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x1 x2 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(check-synth)

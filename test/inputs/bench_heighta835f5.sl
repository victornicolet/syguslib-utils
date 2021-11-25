(set-logic LIA)
(synth-fun s0 () Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(check-synth)

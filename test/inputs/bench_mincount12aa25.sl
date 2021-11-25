(set-logic LIA)
(synth-fun s_0 () Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(check-synth)

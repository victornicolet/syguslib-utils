(set-logic DTLIA)
(synth-fun s00 () Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(constraint (= 0 s00))
(check-synth)

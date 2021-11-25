(set-logic LIA)
(synth-fun int_succ ((x Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(check-synth)

(set-logic LIA)
(synth-fun add ((x1 Int) (x2 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x1 x2 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(synth-fun c0 () Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(constraint (= 0 (add c0 c0)))
(check-synth)

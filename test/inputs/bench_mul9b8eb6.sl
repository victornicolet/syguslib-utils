(set-logic NIA)
(synth-fun join ((x3 Int) (x4 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x3 x4 (- Ix) (+ Ix Ix) (* Ix Ix) (div Ix Ix))) (Ic Int ((Constant Int)))))
(synth-fun j2 ((x5 Int) (x6 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x5 x6 (- Ix) (+ Ix Ix) (* Ix Ix) (div Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var i0 Int)
(constraint (= p (join p 1)))
(constraint (= (* p i0) (join p (j2 i0 1))))
(check-synth)

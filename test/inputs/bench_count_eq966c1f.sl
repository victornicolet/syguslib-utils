(set-logic LIA)
(synth-fun f0 ((x10 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x10 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var a Int)
(declare-var i Int)
(declare-var i17 Int)
(constraint (or (not (and (or (not (= i a)) (= i17 0)) (= i a))) (= (+ 1 i17) (f0 i))))
(check-synth)

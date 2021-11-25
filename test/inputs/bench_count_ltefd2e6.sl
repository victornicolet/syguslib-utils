(set-logic LIA)
(synth-fun f0 ((x2 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x2 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i0 Int)
(declare-var i17299 Int)
(declare-var i17300 Int)
(constraint
 (or
  (not
   (and
    (and (and (>= i17299 0) (>= i17300 0))
     (or (not (and (and (>= i17299 0) (>= i17300 0)) (< i0 2))) (= i (+ (+ i17299 i17300) 1))))
    (< i0 2)))
  (= (+ (+ 1 i17299) i17300) (f0 i))))
(check-synth)

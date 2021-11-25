(set-logic LIA)
(synth-fun f0 ((x4 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x4 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i0 Int)
(declare-var i27573 Int)
(declare-var i27574 Int)
(constraint
 (or
  (not
   (and
    (and (and (>= i27573 0) (>= i27574 0))
     (and
      (or
       (not
        (and
         (and (and (>= i27573 0) (>= i27574 0))
          (or (not (and (and (>= i27573 0) (>= i27574 0)) (< i0 2))) (= i (+ (+ i27573 i27574) 1))))
         (not (< i0 2))))
       (= i (+ i27573 i27574)))
      (or (not (and (and (>= i27573 0) (>= i27574 0)) (< i0 2))) (= i (+ (+ i27573 i27574) 1)))))
    (< i0 2)))
  (= (+ (+ 1 i27573) i27574) (f0 i))))
(check-synth)

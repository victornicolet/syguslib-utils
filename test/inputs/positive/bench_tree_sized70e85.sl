(set-logic LIA)
(synth-fun xi_1 ((x0 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x0 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i2888 Int)
(declare-var i2889 Int)
(constraint
 (or
  (not
   (and (and (>= i2888 1) (>= i2889 1))
    (or (not (and (>= i2888 1) (>= i2889 1))) (= i (+ (+ i2888 i2889) 1)))))
  (= (+ (+ 1 i2888) i2889) (xi_1 i))))
(check-synth)

(set-logic LIA)
(synth-fun xi_1 ((x26 Int) (x27 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x26 x27 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var x Int)
(declare-var i Int)
(declare-var i31 Int)
(constraint
 (or
  (not
   (and (and (>= i31 0) (or (not (and (>= i31 0) (>= i x))) (= i (ite (= i31 0) i x)))) (>= i x)))
  (= (ite (= i x) 1 (ite (= i31 0) 0 (+ 1 i31))) (xi_1 x i))))
(check-synth)

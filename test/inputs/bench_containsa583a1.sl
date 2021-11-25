(set-logic LIA)
(synth-fun xi_1 ((x23 Int) (x24 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x23 x24 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var x Int)
(declare-var p Int)
(declare-var i39 Int)
(constraint
 (or
  (not
   (and (and (>= i39 0) (<= i39 1))
    (or (not (and (>= i39 0) (<= i39 1))) (= p (ite (= i39 0) p x)))))
  (= (ite (= p x) 1 i39) (xi_1 x p))))
(check-synth)

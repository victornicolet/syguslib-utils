(set-logic LIA)
(synth-fun xi_1 ((x18 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x18 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var x Int)
(declare-var i Int)
(declare-var i477 Int)
(declare-var i478 Int)
(constraint
 (or
  (not
   (and
    (and (and (and (>= i477 0) (<= i477 1)) (and (>= i478 0) (<= i478 1)))
     (or (not (and (and (and (>= i477 0) (<= i477 1)) (and (>= i478 0) (<= i478 1))) (< x i)))
      (= i478 0)))
    (< x i)))
  (= (ite (= i x) 1 (ite (= i477 1) 1 (ite (= i478 1) 1 0))) (xi_1 i477))))
(check-synth)

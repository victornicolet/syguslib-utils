(set-logic LIA)
(synth-fun xi_2 ((x18 Int) (x19 Int) (x20 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x18 x19 x20 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var x Int)
(declare-var p Int)
(declare-var i492 Int)
(declare-var i493 Int)
(constraint
 (or
  (not
   (and (and (and (>= i492 0) (<= i492 1)) (and (>= i493 0) (<= i493 1)))
    (or (not (and (and (>= i492 0) (<= i492 1)) (and (>= i493 0) (<= i493 1)))) (= i493 0))))
  (= (ite (= p x) 1 (ite (= i492 1) 1 (ite (= i493 1) 1 0))) (xi_2 x p i492))))
(check-synth)

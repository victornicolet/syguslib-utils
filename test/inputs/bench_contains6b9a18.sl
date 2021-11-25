(set-logic LIA)
(synth-fun xi_2 ((x1 Int) (x2 Int) (x3 Bool) (x4 Bool)) Bool ((Ipred Bool) (Ix Int) (Ic Int))
 ((Ipred Bool (x3 x4 (not Ipred) (and Ipred Ipred) (or Ipred Ipred) (= Ix Ix) (> Ix Ix)))
  (Ix Int (Ic x1 x2 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var x Int)
(declare-var i Int)
(declare-var i2 Int)
(declare-var b Bool)
(constraint (or (not (not (< x i))) (= (or (= i2 x) (or (= i x) b)) (xi_2 x i b (= i2 x)))))
(check-synth)

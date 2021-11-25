(set-logic LIA)
(synth-fun xi_1 ((x5 Bool)) Bool ((Ipred Bool))
 ((Ipred Bool (x5 (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var x Int)
(declare-var i Int)
(declare-var i2 Int)
(declare-var b Bool)
(constraint (or (not (< x i)) (= (or (= i2 x) (or (= i x) b)) (xi_1 b))))
(check-synth)

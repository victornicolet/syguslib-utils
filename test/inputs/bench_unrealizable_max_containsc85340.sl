(set-logic LIA)
(synth-fun c0 ((x19 Int) (x20 Int)) Bool ((Ipred Bool) (Ix Int) (Ic Int))
 ((Ipred Bool ((not Ipred) (and Ipred Ipred) (or Ipred Ipred) (= Ix Ix) (> Ix Ix)))
  (Ix Int (Ic x19 x20 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var x Int)
(declare-var i Int)
(declare-var p Int)
(declare-var b3 Bool)
(declare-var b4 Bool)
(constraint
 (or (not (and (or (not (> x i)) (> x p)) (> x i))) (= (or (= x p) (or b3 b4)) (c0 x p))))
(check-synth)

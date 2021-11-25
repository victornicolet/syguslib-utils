(set-logic LIA)
(synth-fun odot ((x5 Int) (x6 Int) (x7 Bool) (x8 Bool)) Bool ((Ipred Bool) (Ix Int) (Ic Int))
 ((Ipred Bool (x7 x8 (not Ipred) (and Ipred Ipred) (or Ipred Ipred) (= Ix Ix) (> Ix Ix)))
  (Ix Int (Ic x5 x6 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var x Int)
(declare-var p Int)
(declare-var p2 Int)
(declare-var b2 Bool)
(constraint (= (ite (= p x) true b2) (odot x p false b2)))
(constraint (= (ite (= p x) true (ite (= p2 x) true b2)) (odot x p (ite (= p2 x) true false) b2)))
(check-synth)

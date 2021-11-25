(set-logic LIA)
(synth-fun c0 ((x33 Int) (x34 Int)) Bool ((Ipred Bool) (Ix Int) (Ic Int))
 ((Ipred Bool ((not Ipred) (and Ipred Ipred) (or Ipred Ipred) (= Ix Ix) (> Ix Ix)))
  (Ix Int (Ic x33 x34 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var x Int)
(declare-var i Int)
(declare-var p Int)
(declare-var b5 Bool)
(declare-var b6 Bool)
(constraint
 (or
  (not
   (and
    (and (or (not (and (or (not (> x i)) (> x p)) (> x i))) (> x (ite b5 x p)))
     (or (not (> x i)) (> x p)))
    (> x i)))
  (= (or (= x p) (or b5 b6)) (c0 x p))))
(check-synth)

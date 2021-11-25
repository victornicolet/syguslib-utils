(set-logic LIA)
(synth-fun odot ((x1 Int) (x2 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x1 x2 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var p5 Int)
(declare-var p6 Int)
(declare-var i Int)
(constraint (= i (odot 0 i)))
(constraint (= (+ (ite (= p5 p6) 0 1) i) (odot (+ (ite (= p5 p6) 0 1) 0) i)))
(check-synth)

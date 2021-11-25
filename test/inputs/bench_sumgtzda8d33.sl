(set-logic LIA)
(synth-fun oplus ((x0 Int) (x1 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x0 x1 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var p Int)
(declare-var i0 Int)
(constraint
 (=
  (ite (> p i0) (ite (>= p 0) (+ p (ite (>= i0 0) i0 0)) 0)
   (ite (>= i0 0) (+ i0 (ite (>= p 0) p 0)) 0))
  (oplus p (ite (>= i0 0) i0 0))))
(check-synth)

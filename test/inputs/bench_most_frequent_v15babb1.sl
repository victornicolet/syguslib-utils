(set-logic LIA)
(synth-fun int_succ ((x27 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x27 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(synth-fun int_base () Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(synth-fun s00 ((x28 Int) (x29 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x28 x29 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(synth-fun s01 ((x30 Int) (x31 Int)) Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic x30 x31 (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var i0 Int)
(constraint (or (not true) (= 1 (s00 i0 int_base))))
(constraint (or (not true) (= i0 (s01 i0 int_base))))
(constraint (or (not true) (= (ite (> 2 1) 2 1) (s00 i0 (int_succ int_base)))))
(constraint (or (not true) (= (ite (> 2 1) i0 i0) (s01 i0 (int_succ int_base)))))
(check-synth)

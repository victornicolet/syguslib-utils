(set-logic DTLIA)
(synth-fun odot2 ((x6 (Tuple Int Int Bool)) (x7 (Tuple Int Int Bool))) Bool
 ((Ipred Bool) (Ix Int) (Ic Int))
 ((Ipred Bool
   (((_ tupSel 2) x6) ((_ tupSel 2) x7) (not Ipred) (and Ipred Ipred) 
    (or Ipred Ipred) (= Ix Ix) (> Ix Ix)))
  (Ix Int
   (Ic ((_ tupSel 0) x6) ((_ tupSel 1) x6) ((_ tupSel 0) x7) ((_ tupSel 1) x7) 
    (- Ix) (+ Ix Ix) (ite Ipred Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p4 Int)
(declare-var i Int)
(declare-var i0 Int)
(declare-var b Bool)
(constraint (= (> p4 i0) (odot2 (mkTuple p4 p4 true) (mkTuple i i0 b))))
(check-synth)

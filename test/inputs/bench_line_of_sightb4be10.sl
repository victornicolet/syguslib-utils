(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot1 ((x13 (Tuple Int Int Bool)) (x14 (Tuple Int Int Bool))) Int
 ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int
   (Ic ((_ tupSel 0) x13) ((_ tupSel 1) x13) ((_ tupSel 0) x14) ((_ tupSel 1) x14) 
    (- Ix) (+ Ix Ix) (max Ix Ix) (ite Ipred Ix Ix)))
  (Ic Int ((Constant Int)))
  (Ipred Bool
   (((_ tupSel 2) x13) ((_ tupSel 2) x14) (= Ix Ix) (> Ix Ix) (not Ipred) 
    (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var p4 Int)
(declare-var i3 Int)
(declare-var i4 Int)
(declare-var i7 Int)
(declare-var i8 Int)
(declare-var b2 Bool)
(declare-var i10 Int)
(constraint (= (max i8 p4) (odot1 (mkTuple p4 p4 true) (mkTuple i7 i8 b2))))
(constraint
 (= (max (max i10 i4) i3) (odot1 (mkTuple i3 (max i10 i3) (> i3 i10)) (mkTuple i4 i4 true))))
(check-synth)

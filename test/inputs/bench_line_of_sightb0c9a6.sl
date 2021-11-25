(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot2 ((x15 (Tuple Int Int Bool)) (x16 (Tuple Int Int Bool))) Bool
 ((Ipred Bool) (Ix Int) (Ic Int))
 ((Ipred Bool
   (((_ tupSel 2) x15) ((_ tupSel 2) x16) (not Ipred) (and Ipred Ipred) 
    (or Ipred Ipred) (= Ix Ix) (> Ix Ix)))
  (Ix Int
   (Ic ((_ tupSel 0) x15) ((_ tupSel 1) x15) ((_ tupSel 0) x16) ((_ tupSel 1) x16) 
    (- Ix) (+ Ix Ix) (max Ix Ix) (ite Ipred Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p4 Int)
(declare-var i3 Int)
(declare-var i4 Int)
(declare-var i7 Int)
(declare-var i8 Int)
(declare-var b2 Bool)
(declare-var i10 Int)
(constraint (= (> p4 i8) (odot2 (mkTuple p4 p4 true) (mkTuple i7 i8 b2))))
(constraint
 (= (> i3 (max i10 i4)) (odot2 (mkTuple i3 (max i10 i3) (> i3 i10)) (mkTuple i4 i4 true))))
(check-synth)

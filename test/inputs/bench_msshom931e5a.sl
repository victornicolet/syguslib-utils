(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot0 ((x3 (Tuple Int Int Int Int)) (x4 (Tuple Int Int Int Int))) Int
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x3) ((_ tupSel 1) x3) ((_ tupSel 2) x3) ((_ tupSel 3) x3) 
    ((_ tupSel 0) x4) ((_ tupSel 1) x4) ((_ tupSel 2) x4) ((_ tupSel 3) x4) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p4 Int)
(declare-var i Int)
(declare-var i0 Int)
(declare-var i1 Int)
(declare-var i2 Int)
(constraint
 (or
  (not
   (and (>= i0 0)
    (and (>= i1 0)
     (and (>= i1 i) (and (>= i0 i) (and (>= i2 0) (and (>= i2 i0) (and (>= i2 i) (>= i2 i1)))))))))
  (= i (odot0 (mkTuple 0 0 0 0) (mkTuple i i0 i1 i2)))))
(constraint
 (or
  (not
   (and (>= i0 0)
    (and (>= i1 0)
     (and (>= i1 i) (and (>= i0 i) (and (>= i2 0) (and (>= i2 i0) (and (>= i2 i) (>= i2 i1)))))))))
  (= (+ i p4)
   (odot0 (mkTuple (+ 0 p4) (max 0 (+ 0 p4)) (max (+ 0 p4) 0) (max 0 (max (+ 0 p4) 0)))
    (mkTuple i i0 i1 i2)))))
(check-synth)

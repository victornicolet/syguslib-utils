(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun joinl1 ((x2 Int) (x3 (Tuple Int Int)) (x4 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x2 ((_ tupSel 0) x3) ((_ tupSel 1) x3) ((_ tupSel 0) x4) ((_ tupSel 1) x4) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i2 Int)
(declare-var i11 Int)
(declare-var i12 Int)
(declare-var i15 Int)
(declare-var i16 Int)
(constraint (= (max i 0) (joinl1 i (mkTuple 0 0) (mkTuple 0 0))))
(constraint
 (or (not (and (>= i12 0) (>= i12 i11)))
  (= (max (+ i11 i) i12) (joinl1 i (mkTuple i11 i12) (mkTuple 0 0)))))
(constraint
 (or (not (and (>= i16 0) (>= i16 i15)))
  (= (max (+ (+ i15 i2) i) (max (+ i15 i2) i16))
   (joinl1 i (mkTuple (+ i15 i2) (max (+ i15 i2) i16)) (mkTuple 0 0)))))
(check-synth)

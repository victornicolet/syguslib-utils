(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join0 ((x54 (Tuple Int Int)) (x55 (Tuple Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x54) ((_ tupSel 1) x54) ((_ tupSel 0) x55) ((_ tupSel 1) x55) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i8 Int)
(declare-var i11 Int)
(declare-var i12 Int)
(constraint (or (not (>= i11 0)) (= i11 (join0 (mkTuple 0 0) (mkTuple i11 i12)))))
(constraint (or (not (>= i11 0)) (= i11 (join0 (mkTuple 0 0) (mkTuple i11 i12)))))
(constraint
 (or (not (>= i11 0)) (= (max (+ i11 i) 0) (join0 (mkTuple (max (+ 0 i) 0) i) (mkTuple i11 i12)))))
(constraint
 (or (not (>= i11 0))
  (= (max (+ i11 i8) 0) (join0 (mkTuple (max (+ 0 i8) 0) i8) (mkTuple i11 i12)))))
(check-synth)

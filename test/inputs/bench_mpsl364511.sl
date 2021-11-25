(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join0 ((x138 (Tuple Int Int)) (x139 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x138) ((_ tupSel 1) x138) ((_ tupSel 0) x139) ((_ tupSel 1) x139) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i8 Int)
(declare-var i21 Int)
(declare-var i25 Int)
(declare-var i28 Int)
(declare-var i29 Int)
(constraint (or (not (>= i28 0)) (= i28 (join0 (mkTuple 0 0) (mkTuple i28 i29)))))
(constraint (or (not (>= i28 0)) (= i28 (join0 (mkTuple 0 0) (mkTuple i28 i29)))))
(constraint
 (or (not (>= i28 0)) (= (max (+ i28 i) 0) (join0 (mkTuple (max (+ 0 i) 0) i) (mkTuple i28 i29)))))
(constraint
 (or (not (>= i28 0))
  (= (max (+ i28 i8) 0) (join0 (mkTuple (max (+ 0 i8) 0) i8) (mkTuple i28 i29)))))
(constraint
 (or (not (>= i28 0))
  (= (max (+ i28 i21) 0) (join0 (mkTuple (max (+ 0 i21) 0) i21) (mkTuple i28 i29)))))
(constraint
 (or (not (>= i28 0))
  (= (max (+ (max (+ i28 i25) 0) i21) 0)
   (join0 (mkTuple (max (+ (max (+ 0 i25) 0) i21) 0) (+ i21 i25)) (mkTuple i28 i29)))))
(check-synth)

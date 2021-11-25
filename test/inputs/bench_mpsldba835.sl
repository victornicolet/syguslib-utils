(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join0 ((x54 (Tuple Int Int)) (x55 (Tuple Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x54) ((_ tupSel 1) x54) ((_ tupSel 0) x55) ((_ tupSel 1) x55) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i14 Int)
(declare-var i17 Int)
(declare-var i18 Int)
(constraint (or (not (>= i17 0)) (= i17 (join0 (mkTuple 0 0) (mkTuple i17 i18)))))
(constraint (or (not (>= i17 0)) (= i17 (join0 (mkTuple 0 0) (mkTuple i17 i18)))))
(constraint
 (or (not (>= i17 0)) (= (max (+ i17 i) 0) (join0 (mkTuple (max (+ 0 i) 0) i) (mkTuple i17 i18)))))
(constraint
 (or (not (>= i17 0))
  (= (max (+ i17 i14) 0) (join0 (mkTuple (max (+ 0 i14) 0) i14) (mkTuple i17 i18)))))
(check-synth)

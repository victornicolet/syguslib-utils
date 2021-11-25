(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join0 ((x7 (Tuple Int Int)) (x8 (Tuple Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x7) ((_ tupSel 1) x7) ((_ tupSel 0) x8) ((_ tupSel 1) x8) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p4 Int)
(declare-var i5 Int)
(declare-var i9 Int)
(declare-var i12 Int)
(declare-var i13 Int)
(constraint
 (or (not (and (>= i12 0) (>= i12 i13))) (= i12 (join0 (mkTuple 0 0) (mkTuple i12 i13)))))
(constraint
 (or (not (and (>= i12 0) (>= i12 i13)))
  (= (max i12 (+ i13 p4)) (join0 (mkTuple (max 0 (+ 0 p4)) (+ 0 p4)) (mkTuple i12 i13)))))
(constraint
 (or (not (and (>= i12 0) (>= i12 i13)))
  (= (max i12 (+ i13 i5)) (join0 (mkTuple (max 0 (+ 0 i5)) (+ 0 i5)) (mkTuple i12 i13)))))
(constraint
 (or (not (and (>= i12 0) (>= i12 i13)))
  (= (max (max i12 (+ i13 i9)) (+ (+ i13 i9) i5))
   (join0 (mkTuple (max (max 0 (+ 0 i9)) (+ (+ 0 i9) i5)) (+ (+ 0 i9) i5)) (mkTuple i12 i13)))))
(check-synth)

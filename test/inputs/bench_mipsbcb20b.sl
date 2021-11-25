(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun joinl0 ((x11 Int) (x12 (Tuple Int Int)) (x13 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x11 ((_ tupSel 0) x12) ((_ tupSel 1) x12) ((_ tupSel 0) x13) ((_ tupSel 1) x13) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i2 Int)
(declare-var i4 Int)
(declare-var i76 Int)
(declare-var i82 Int)
(declare-var i83 Int)
(declare-var i86 Int)
(declare-var i87 Int)
(constraint (= i (joinl0 i (mkTuple 0 0) (mkTuple 0 0))))
(constraint
 (or (not (and (>= i83 0) (>= i83 i82))) (= (+ i82 i) (joinl0 i (mkTuple i82 i83) (mkTuple 0 0)))))
(constraint (= (+ i i4) (joinl0 i (mkTuple 0 0) (mkTuple (+ 0 i4) (max (+ 0 i4) 0)))))
(constraint (= (+ i i4) (joinl0 i (mkTuple 0 0) (mkTuple (+ 0 i4) (max (+ 0 i4) 0)))))
(constraint
 (or (not (and (>= i87 0) (>= i87 i86)))
  (= (+ (+ i86 i2) i) (joinl0 i (mkTuple (+ i86 i2) (max (+ i86 i2) i87)) (mkTuple 0 0)))))
(constraint
 (= (+ (+ i i76) i4)
  (joinl0 i (mkTuple 0 0) (mkTuple (+ (+ 0 i76) i4) (max (+ (+ 0 i76) i4) (max (+ 0 i76) 0))))))
(constraint
 (= (+ (+ i i4) i76)
  (joinl0 i (mkTuple 0 0) (mkTuple (+ (+ 0 i4) i76) (max (+ (+ 0 i4) i76) (max (+ 0 i4) 0))))))
(check-synth)

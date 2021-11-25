(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun joinl1 ((x14 Int) (x15 (Tuple Int Int)) (x16 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x14 ((_ tupSel 0) x15) ((_ tupSel 1) x15) ((_ tupSel 0) x16) ((_ tupSel 1) x16) 
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
(constraint (= (max i 0) (joinl1 i (mkTuple 0 0) (mkTuple 0 0))))
(constraint
 (or (not (and (>= i83 0) (>= i83 i82)))
  (= (max (+ i82 i) i83) (joinl1 i (mkTuple i82 i83) (mkTuple 0 0)))))
(constraint
 (= (max (+ i i4) (max i 0)) (joinl1 i (mkTuple 0 0) (mkTuple (+ 0 i4) (max (+ 0 i4) 0)))))
(constraint
 (= (max (+ i i4) (max i 0)) (joinl1 i (mkTuple 0 0) (mkTuple (+ 0 i4) (max (+ 0 i4) 0)))))
(constraint
 (or (not (and (>= i87 0) (>= i87 i86)))
  (= (max (+ (+ i86 i2) i) (max (+ i86 i2) i87))
   (joinl1 i (mkTuple (+ i86 i2) (max (+ i86 i2) i87)) (mkTuple 0 0)))))
(constraint
 (= (max (+ (+ i i76) i4) (max (+ i i76) (max i 0)))
  (joinl1 i (mkTuple 0 0) (mkTuple (+ (+ 0 i76) i4) (max (+ (+ 0 i76) i4) (max (+ 0 i76) 0))))))
(constraint
 (= (max (+ (+ i i4) i76) (max (+ i i4) (max i 0)))
  (joinl1 i (mkTuple 0 0) (mkTuple (+ (+ 0 i4) i76) (max (+ (+ 0 i4) i76) (max (+ 0 i4) 0))))))
(check-synth)

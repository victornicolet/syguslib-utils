(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join11 ((x20 Int) (x21 (Tuple Int Int)) (x22 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x20 ((_ tupSel 0) x21) ((_ tupSel 1) x21) ((_ tupSel 0) x22) ((_ tupSel 1) x22) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p0 Int)
(declare-var p3 Int)
(declare-var p4 Int)
(declare-var p7 Int)
(declare-var i Int)
(declare-var i17 Int)
(declare-var i21 Int)
(constraint (= (max 0 p0) (join11 p0 (mkTuple 0 0) (mkTuple 0 0))))
(constraint
 (= (max (max 0 p0) (+ p0 p7)) (join11 p0 (mkTuple 0 0) (mkTuple (+ 0 p7) (max 0 (+ 0 p7))))))
(constraint
 (= (max (max 0 p0) (+ p0 p3)) (join11 p0 (mkTuple (+ 0 p3) (max 0 (+ 0 p3))) (mkTuple 0 0))))
(constraint
 (= (max (max (max 0 p0) (+ p0 p3)) (+ (+ p0 p3) i))
  (join11 p0 (mkTuple (+ 0 p3) (max 0 (+ 0 p3))) (mkTuple (+ 0 i) (max 0 (+ 0 i))))))
(constraint
 (= (max (max (max 0 p0) (+ p0 p4)) (+ (+ p0 p4) i17))
  (join11 p0 (mkTuple (+ (+ 0 p4) i17) (max (max 0 (+ 0 p4)) (+ (+ 0 p4) i17))) (mkTuple 0 0))))
(constraint
 (= (max (max (max (max 0 p0) (+ p0 p4)) (+ (+ p0 p4) i17)) (+ (+ (+ p0 p4) i17) i21))
  (join11 p0 (mkTuple (+ (+ 0 p4) i17) (max (max 0 (+ 0 p4)) (+ (+ 0 p4) i17)))
   (mkTuple (+ 0 i21) (max 0 (+ 0 i21))))))
(check-synth)

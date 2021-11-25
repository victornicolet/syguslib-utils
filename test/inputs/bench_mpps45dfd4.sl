(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join11 ((x12 Int) (x13 (Tuple Int Int)) (x14 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x12 ((_ tupSel 0) x13) ((_ tupSel 1) x13) ((_ tupSel 0) x14) ((_ tupSel 1) x14) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p0 Int)
(declare-var p3 Int)
(declare-var p7 Int)
(declare-var i Int)
(constraint (= (max 0 p0) (join11 p0 (mkTuple 0 0) (mkTuple 0 0))))
(constraint
 (= (max (max 0 p0) (+ p0 p7)) (join11 p0 (mkTuple 0 0) (mkTuple (+ 0 p7) (max 0 (+ 0 p7))))))
(constraint
 (= (max (max 0 p0) (+ p0 p3)) (join11 p0 (mkTuple (+ 0 p3) (max 0 (+ 0 p3))) (mkTuple 0 0))))
(constraint
 (= (max (max (max 0 p0) (+ p0 p3)) (+ (+ p0 p3) i))
  (join11 p0 (mkTuple (+ 0 p3) (max 0 (+ 0 p3))) (mkTuple (+ 0 i) (max 0 (+ 0 i))))))
(check-synth)

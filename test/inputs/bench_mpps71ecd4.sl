(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join10 ((x17 Int) (x18 (Tuple Int Int)) (x19 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x17 ((_ tupSel 0) x18) ((_ tupSel 1) x18) ((_ tupSel 0) x19) ((_ tupSel 1) x19) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p0 Int)
(declare-var p3 Int)
(declare-var p4 Int)
(declare-var p7 Int)
(declare-var i Int)
(declare-var i17 Int)
(declare-var i21 Int)
(constraint (= p0 (join10 p0 (mkTuple 0 0) (mkTuple 0 0))))
(constraint (= (+ p0 p7) (join10 p0 (mkTuple 0 0) (mkTuple (+ 0 p7) (max 0 (+ 0 p7))))))
(constraint (= (+ p0 p3) (join10 p0 (mkTuple (+ 0 p3) (max 0 (+ 0 p3))) (mkTuple 0 0))))
(constraint
 (= (+ (+ p0 p3) i)
  (join10 p0 (mkTuple (+ 0 p3) (max 0 (+ 0 p3))) (mkTuple (+ 0 i) (max 0 (+ 0 i))))))
(constraint
 (= (+ (+ p0 p4) i17)
  (join10 p0 (mkTuple (+ (+ 0 p4) i17) (max (max 0 (+ 0 p4)) (+ (+ 0 p4) i17))) (mkTuple 0 0))))
(constraint
 (= (+ (+ (+ p0 p4) i17) i21)
  (join10 p0 (mkTuple (+ (+ 0 p4) i17) (max (max 0 (+ 0 p4)) (+ (+ 0 p4) i17)))
   (mkTuple (+ 0 i21) (max 0 (+ 0 i21))))))
(check-synth)

(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join10 ((x49 Int) (x50 (Tuple Int Int)) (x51 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x49 ((_ tupSel 0) x50) ((_ tupSel 1) x50) ((_ tupSel 0) x51) ((_ tupSel 1) x51) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p2 Int)
(declare-var i12 Int)
(declare-var i19 Int)
(declare-var i20 Int)
(constraint (or (not (>= i19 0)) (= (max (+ i19 p) 0) (join10 p (mkTuple i19 i20) (mkTuple 0 0)))))
(constraint
 (or (not (>= i19 0))
  (= (max (+ (max (+ i19 p) 0) p2) 0) (join10 p (mkTuple i19 i20) (mkTuple (max (+ 0 p2) 0) p2)))))
(constraint
 (or (not (>= i19 0))
  (= (max (+ (max (+ (max (+ i19 p) 0) p2) 0) i12) 0)
   (join10 p (mkTuple i19 i20) (mkTuple (max (+ (max (+ 0 p2) 0) i12) 0) (+ p2 i12))))))
(check-synth)

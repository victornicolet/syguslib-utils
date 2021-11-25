(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun oplus0 ((x11 Int) (x12 (Tuple Int Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x11 ((_ tupSel 0) x12) ((_ tupSel 1) x12) ((_ tupSel 2) x12) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p1 Int)
(declare-var i0 Int)
(constraint (= p (oplus0 p (mkTuple 0 0 0))))
(constraint (= (+ p p1) (oplus0 p (mkTuple (+ p1 0) (max (+ 0 p1) 0) (max (+ 0 p1) 0)))))
(constraint
 (= (+ p (+ p1 i0))
  (oplus0 p
   (mkTuple (+ p1 (+ i0 0)) (max (+ (max (+ 0 p1) 0) i0) 0) (max (+ (max (+ 0 i0) 0) p1) 0)))))
(check-synth)

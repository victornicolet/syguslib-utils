(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun oplus2 ((x15 Int) (x16 (Tuple Int Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x15 ((_ tupSel 0) x16) ((_ tupSel 1) x16) ((_ tupSel 2) x16) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p1 Int)
(declare-var i0 Int)
(constraint (= (max p 0) (oplus2 p (mkTuple 0 0 0))))
(constraint
 (= (max (+ (max p1 0) p) 0) (oplus2 p (mkTuple (+ p1 0) (max (+ 0 p1) 0) (max (+ 0 p1) 0)))))
(constraint
 (= (max (+ (max (+ (max i0 0) p1) 0) p) 0)
  (oplus2 p
   (mkTuple (+ p1 (+ i0 0)) (max (+ (max (+ 0 p1) 0) i0) 0) (max (+ (max (+ 0 i0) 0) p1) 0)))))
(check-synth)

(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun oplus1 ((x13 Int) (x14 (Tuple Int Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x13 ((_ tupSel 0) x14) ((_ tupSel 1) x14) ((_ tupSel 2) x14) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p1 Int)
(declare-var i0 Int)
(constraint (= (max p 0) (oplus1 p (mkTuple 0 0 0))))
(constraint
 (= (max (+ (max p 0) p1) 0) (oplus1 p (mkTuple (+ p1 0) (max (+ 0 p1) 0) (max (+ 0 p1) 0)))))
(constraint
 (= (max (+ (max (+ (max p 0) p1) 0) i0) 0)
  (oplus1 p
   (mkTuple (+ p1 (+ i0 0)) (max (+ (max (+ 0 p1) 0) i0) 0) (max (+ (max (+ 0 i0) 0) p1) 0)))))
(check-synth)

(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun oplus1 ((x7 Int) (x8 (Tuple Int Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x7 ((_ tupSel 0) x8) ((_ tupSel 1) x8) ((_ tupSel 2) x8) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p1 Int)
(constraint (= (max p 0) (oplus1 p (mkTuple 0 0 0))))
(constraint
 (= (max (+ (max p 0) p1) 0) (oplus1 p (mkTuple (+ p1 0) (max (+ 0 p1) 0) (max (+ 0 p1) 0)))))
(check-synth)

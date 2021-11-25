(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun oplus1 ((x1 Int) (x2 (Tuple Int Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x1 ((_ tupSel 0) x2) ((_ tupSel 1) x2) ((_ tupSel 2) x2) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(constraint (= (max p 0) (oplus1 p (mkTuple 0 0 0))))
(check-synth)

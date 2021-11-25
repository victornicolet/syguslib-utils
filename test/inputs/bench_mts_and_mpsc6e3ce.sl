(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun oplus2 ((x3 Int) (x4 (Tuple Int Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x3 ((_ tupSel 0) x4) ((_ tupSel 1) x4) ((_ tupSel 2) x4) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(constraint (= (max p 0) (oplus2 p (mkTuple 0 0 0))))
(check-synth)

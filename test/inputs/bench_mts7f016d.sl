(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun oplus1 ((x1 (Tuple Int Int)) (x2 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic ((_ tupSel 0) x1) ((_ tupSel 1) x1) x2 (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(constraint (= (max 0 p) (oplus1 (mkTuple 0 0) p)))
(check-synth)

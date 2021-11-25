(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot1 ((x2 Int) (x3 (Tuple Int Int)) (x4 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x2 ((_ tupSel 0) x3) ((_ tupSel 1) x3) ((_ tupSel 0) x4) ((_ tupSel 1) x4) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var i Int)
(declare-var i0 Int)
(constraint
 (or (not (and (> i0 i) (> i0 0))) (= (max (+ i p) i0) (odot1 p (mkTuple i i0) (mkTuple 0 0)))))
(check-synth)

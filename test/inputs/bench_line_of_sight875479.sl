(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot1 ((x4 (Tuple Int Int Bool)) (x5 (Tuple Int Int Bool))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x4) ((_ tupSel 1) x4) ((_ tupSel 0) x5) ((_ tupSel 1) x5) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p4 Int)
(declare-var i Int)
(declare-var i0 Int)
(declare-var b Bool)
(constraint (= (max i0 p4) (odot1 (mkTuple p4 p4 true) (mkTuple i i0 b))))
(check-synth)

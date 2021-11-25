(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot1 ((x3 (Tuple Int Int)) (x4 (Tuple Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x3) ((_ tupSel 1) x3) ((_ tupSel 0) x4) ((_ tupSel 1) x4) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i0 Int)
(declare-var i1 Int)
(constraint (or (not (>= i0 0)) (= i1 (odot1 (mkTuple 0 0) (mkTuple i0 i1)))))
(constraint
 (or (not (>= i0 0)) (= (+ i1 i) (odot1 (mkTuple (max (+ 0 i) 0) (+ 0 i)) (mkTuple i0 i1)))))
(check-synth)

(set-logic DTNIA)
(synth-fun join1 ((x3 Int) (x4 Int) (x5 (Tuple Int Int)) (x6 (Tuple Int Int))) Int
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x3 x4 ((_ tupSel 0) x5) ((_ tupSel 1) x5) ((_ tupSel 0) x6) ((_ tupSel 1) x6) 
    (- Ix) (+ Ix Ix) (* Ix Ix) (div Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var poly_in Int)
(declare-var p Int)
(declare-var i Int)
(declare-var i0 Int)
(constraint (= (* poly_in i0) (join1 poly_in p (mkTuple i i0) (mkTuple 0 1))))
(check-synth)

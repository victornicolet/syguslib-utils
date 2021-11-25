(set-logic DTNIA)
(synth-fun join0 ((x Int) (x0 Int) (x1 (Tuple Int Int)) (x2 (Tuple Int Int))) Int
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x x0 ((_ tupSel 0) x1) ((_ tupSel 1) x1) ((_ tupSel 0) x2) ((_ tupSel 1) x2) 
    (- Ix) (+ Ix Ix) (* Ix Ix) (div Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var poly_in Int)
(declare-var p Int)
(declare-var i Int)
(declare-var i0 Int)
(constraint (= (+ i (* i0 p)) (join0 poly_in p (mkTuple i i0) (mkTuple 0 1))))
(check-synth)

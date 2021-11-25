(set-logic DTNIA)
(synth-fun join1 ((x11 Int) (x12 Int) (x13 (Tuple Int Int)) (x14 (Tuple Int Int))) Int
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x11 x12 ((_ tupSel 0) x13) ((_ tupSel 1) x13) ((_ tupSel 0) x14) 
    ((_ tupSel 1) x14) (- Ix) (+ Ix Ix) (* Ix Ix) (div Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var poly_in Int)
(declare-var p Int)
(declare-var p2 Int)
(declare-var i7 Int)
(declare-var i8 Int)
(constraint (= (* poly_in i8) (join1 poly_in p (mkTuple i7 i8) (mkTuple 0 1))))
(constraint
 (= (* poly_in (* poly_in i8))
  (join1 poly_in p (mkTuple i7 i8) (mkTuple (+ 0 (* 1 p2)) (* poly_in 1)))))
(check-synth)

(set-logic DTNIA)
(synth-fun join0 ((x7 Int) (x8 Int) (x9 (Tuple Int Int)) (x10 (Tuple Int Int))) Int
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x7 x8 ((_ tupSel 0) x9) ((_ tupSel 1) x9) ((_ tupSel 0) x10) ((_ tupSel 1) x10) 
    (- Ix) (+ Ix Ix) (* Ix Ix) (div Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var poly_in Int)
(declare-var p Int)
(declare-var p2 Int)
(declare-var i7 Int)
(declare-var i8 Int)
(constraint (= (+ i7 (* i8 p)) (join0 poly_in p (mkTuple i7 i8) (mkTuple 0 1))))
(constraint
 (= (+ (+ i7 (* i8 p)) (* (* poly_in i8) p2))
  (join0 poly_in p (mkTuple i7 i8) (mkTuple (+ 0 (* 1 p2)) (* poly_in 1)))))
(check-synth)

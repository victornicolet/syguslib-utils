(set-logic DTNIA)
(synth-fun odot0 ((x Int) (x0 (Tuple Int Int)) (x1 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x ((_ tupSel 0) x0) ((_ tupSel 1) x0) ((_ tupSel 0) x1) ((_ tupSel 1) x1) 
    (- Ix) (+ Ix Ix) (* Ix Ix) (div Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var x Int)
(declare-var p4 Int)
(declare-var i Int)
(declare-var i0 Int)
(constraint (= i (odot0 x (mkTuple 0 1) (mkTuple i i0))))
(constraint (= (+ i (* p4 i0)) (odot0 x (mkTuple (+ 0 (* p4 1)) (* x 1)) (mkTuple i i0))))
(check-synth)

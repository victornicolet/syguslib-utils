(set-logic DTNIA)
(synth-fun odot1 ((x2 Int) (x3 (Tuple Int Int)) (x4 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x2 ((_ tupSel 0) x3) ((_ tupSel 1) x3) ((_ tupSel 0) x4) ((_ tupSel 1) x4) 
    (- Ix) (+ Ix Ix) (* Ix Ix) (div Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var x Int)
(declare-var p4 Int)
(declare-var i Int)
(declare-var i0 Int)
(constraint (= i0 (odot1 x (mkTuple 0 1) (mkTuple i i0))))
(constraint (= (* x i0) (odot1 x (mkTuple (+ 0 (* p4 1)) (* x 1)) (mkTuple i i0))))
(check-synth)

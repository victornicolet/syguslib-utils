(set-logic DTLIA)
(synth-fun odot0 ((x Int) (x0 (Tuple Int Int)) (x1 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x ((_ tupSel 0) x0) ((_ tupSel 1) x0) ((_ tupSel 0) x1) ((_ tupSel 1) x1) (- Ix) (+ Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var i Int)
(declare-var i0 Int)
(constraint (or (not (and (> i0 i) (> i0 0))) (= (+ i p) (odot0 p (mkTuple i i0) (mkTuple 0 0)))))
(check-synth)

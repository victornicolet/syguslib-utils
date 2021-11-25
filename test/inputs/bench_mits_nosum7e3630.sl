(set-logic DTLIA)
(synth-fun join11 ((x20 Int) (x21 (Tuple Int Int)) (x22 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x20 ((_ tupSel 0) x21) ((_ tupSel 1) x21) ((_ tupSel 0) x22) ((_ tupSel 1) x22) 
    (- Ix) (+ Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p2 Int)
(constraint (= p2 (join11 p2 (mkTuple 0 0) (mkTuple 0 0))))
(check-synth)

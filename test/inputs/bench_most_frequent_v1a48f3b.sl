(set-logic DTLIA)
(synth-fun join0 ((x0 Int) (x1 (Tuple Int Int)) (x2 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x0 ((_ tupSel 0) x1) ((_ tupSel 1) x1) ((_ tupSel 0) x2) ((_ tupSel 1) x2) (- Ix) (+ Ix Ix)))
  (Ic Int ((Constant Int)))))
(check-synth)

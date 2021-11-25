(set-logic DTLIA)
(synth-fun join1 ((x13 Int) (x14 (Tuple Int Int)) (x15 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x13 ((_ tupSel 0) x14) ((_ tupSel 1) x14) ((_ tupSel 0) x15) ((_ tupSel 1) x15) 
    (- Ix) (+ Ix Ix)))
  (Ic Int ((Constant Int)))))
(check-synth)

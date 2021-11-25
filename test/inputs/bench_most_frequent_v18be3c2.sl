(set-logic DTLIA)
(synth-fun join0 ((x10 Int) (x11 (Tuple Int Int)) (x12 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x10 ((_ tupSel 0) x11) ((_ tupSel 1) x11) ((_ tupSel 0) x12) ((_ tupSel 1) x12) 
    (- Ix) (+ Ix Ix)))
  (Ic Int ((Constant Int)))))
(check-synth)

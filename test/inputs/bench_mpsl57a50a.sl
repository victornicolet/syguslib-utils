(set-logic DTLIA)
(synth-fun join1 ((x18 (Tuple Int Int)) (x19 (Tuple Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x18) ((_ tupSel 1) x18) ((_ tupSel 0) x19) ((_ tupSel 1) x19) 
    (- Ix) (+ Ix Ix)))
  (Ic Int ((Constant Int)))))
(check-synth)

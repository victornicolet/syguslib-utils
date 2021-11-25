(set-logic DTLIA)
(synth-fun odot0 ((x2 (Tuple Int Int Bool)) (x3 (Tuple Int Int Bool))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x2) ((_ tupSel 1) x2) ((_ tupSel 0) x3) ((_ tupSel 1) x3) (- Ix) (+ Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p4 Int)
(declare-var i Int)
(declare-var i0 Int)
(declare-var b Bool)
(constraint (= p4 (odot0 (mkTuple p4 p4 true) (mkTuple i i0 b))))
(check-synth)

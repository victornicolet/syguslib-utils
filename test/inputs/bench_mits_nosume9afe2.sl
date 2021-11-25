(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join11 ((x52 Int) (x53 (Tuple Int Int)) (x54 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x52 ((_ tupSel 0) x53) ((_ tupSel 1) x53) ((_ tupSel 0) x54) ((_ tupSel 1) x54) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p2 Int)
(declare-var i12 Int)
(constraint (= (+ p2 i12) (join11 p2 (mkTuple 0 0) (mkTuple (max (+ 0 i12) 0) i12))))
(constraint (= p2 (join11 p2 (mkTuple 0 0) (mkTuple 0 0))))
(check-synth)

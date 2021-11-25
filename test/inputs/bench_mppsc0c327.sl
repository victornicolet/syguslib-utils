(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join11 ((x4 Int) (x5 (Tuple Int Int)) (x6 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x4 ((_ tupSel 0) x5) ((_ tupSel 1) x5) ((_ tupSel 0) x6) ((_ tupSel 1) x6) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p0 Int)
(declare-var p7 Int)
(constraint (= (max 0 p0) (join11 p0 (mkTuple 0 0) (mkTuple 0 0))))
(constraint
 (= (max (max 0 p0) (+ p0 p7)) (join11 p0 (mkTuple 0 0) (mkTuple (+ 0 p7) (max 0 (+ 0 p7))))))
(check-synth)

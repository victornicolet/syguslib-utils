(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join10 ((x1 Int) (x2 (Tuple Int Int)) (x3 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x1 ((_ tupSel 0) x2) ((_ tupSel 1) x2) ((_ tupSel 0) x3) ((_ tupSel 1) x3) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p0 Int)
(declare-var p7 Int)
(constraint (= p0 (join10 p0 (mkTuple 0 0) (mkTuple 0 0))))
(constraint (= (+ p0 p7) (join10 p0 (mkTuple 0 0) (mkTuple (+ 0 p7) (max 0 (+ 0 p7))))))
(check-synth)

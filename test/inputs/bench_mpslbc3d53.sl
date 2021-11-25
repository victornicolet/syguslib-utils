(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join1 ((x56 (Tuple Int Int)) (x57 (Tuple Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x56) ((_ tupSel 1) x56) ((_ tupSel 0) x57) ((_ tupSel 1) x57) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i14 Int)
(constraint (= i14 (join1 (mkTuple 0 0) (mkTuple (max (+ 0 i14) 0) i14))))
(constraint (= 0 (join1 (mkTuple 0 0) (mkTuple 0 0))))
(check-synth)

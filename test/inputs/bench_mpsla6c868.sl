(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join0 ((x16 (Tuple Int Int)) (x17 (Tuple Int Int))) Int ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x16) ((_ tupSel 1) x16) ((_ tupSel 0) x17) ((_ tupSel 1) x17) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i1 Int)
(declare-var i2 Int)
(constraint (or (not (>= i1 0)) (= i1 (join0 (mkTuple 0 0) (mkTuple i1 i2)))))
(constraint
 (or (not (>= i1 0)) (= (max (+ i1 i) 0) (join0 (mkTuple (max (+ 0 i) 0) i) (mkTuple i1 i2)))))
(check-synth)

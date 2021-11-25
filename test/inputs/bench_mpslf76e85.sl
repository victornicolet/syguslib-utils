(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join1 ((x140 (Tuple Int Int)) (x141 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x140) ((_ tupSel 1) x140) ((_ tupSel 0) x141) ((_ tupSel 1) x141) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i8 Int)
(declare-var i21 Int)
(declare-var i25 Int)
(constraint
 (= (+ i21 i25) (join1 (mkTuple (max (+ 0 i21) 0) i21) (mkTuple (max (+ 0 i25) 0) i25))))
(constraint (= i21 (join1 (mkTuple (max (+ 0 i21) 0) i21) (mkTuple 0 0))))
(constraint (= i8 (join1 (mkTuple 0 0) (mkTuple (max (+ 0 i8) 0) i8))))
(constraint (= 0 (join1 (mkTuple 0 0) (mkTuple 0 0))))
(check-synth)

(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join0 ((x138 (Tuple Int Int)) (x139 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x138) ((_ tupSel 1) x138) ((_ tupSel 0) x139) ((_ tupSel 1) x139) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i14 Int)
(declare-var i27 Int)
(declare-var i31 Int)
(declare-var i34 Int)
(declare-var i35 Int)
(constraint (or (not (>= i34 0)) (= i34 (join0 (mkTuple 0 0) (mkTuple i34 i35)))))
(constraint (or (not (>= i34 0)) (= i34 (join0 (mkTuple 0 0) (mkTuple i34 i35)))))
(constraint
 (or (not (>= i34 0)) (= (max (+ i34 i) 0) (join0 (mkTuple (max (+ 0 i) 0) i) (mkTuple i34 i35)))))
(constraint
 (or (not (>= i34 0))
  (= (max (+ i34 i14) 0) (join0 (mkTuple (max (+ 0 i14) 0) i14) (mkTuple i34 i35)))))
(constraint
 (or (not (>= i34 0))
  (= (max (+ i34 i27) 0) (join0 (mkTuple (max (+ 0 i27) 0) i27) (mkTuple i34 i35)))))
(constraint
 (or (not (>= i34 0))
  (= (max (+ (max (+ i34 i31) 0) i27) 0)
   (join0 (mkTuple (max (+ (max (+ 0 i31) 0) i27) 0) (+ i27 i31)) (mkTuple i34 i35)))))
(check-synth)

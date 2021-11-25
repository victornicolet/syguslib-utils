(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join1 ((x140 (Tuple Int Int)) (x141 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x140) ((_ tupSel 1) x140) ((_ tupSel 0) x141) ((_ tupSel 1) x141) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i14 Int)
(declare-var i27 Int)
(declare-var i31 Int)
(constraint
 (= (+ i27 i31) (join1 (mkTuple (max (+ 0 i27) 0) i27) (mkTuple (max (+ 0 i31) 0) i31))))
(constraint (= i27 (join1 (mkTuple (max (+ 0 i27) 0) i27) (mkTuple 0 0))))
(constraint (= i14 (join1 (mkTuple 0 0) (mkTuple (max (+ 0 i14) 0) i14))))
(constraint (= 0 (join1 (mkTuple 0 0) (mkTuple 0 0))))
(check-synth)

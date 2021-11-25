(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join10 ((x17 Int) (x18 (Tuple Int Int)) (x19 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x17 ((_ tupSel 0) x18) ((_ tupSel 1) x18) ((_ tupSel 0) x19) ((_ tupSel 1) x19) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p2 Int)
(declare-var i5 Int)
(declare-var i6 Int)
(constraint (or (not (>= i5 0)) (= (max (+ i5 p) 0) (join10 p (mkTuple i5 i6) (mkTuple 0 0)))))
(constraint
 (or (not (>= i5 0))
  (= (max (+ (max (+ i5 p) 0) p2) 0) (join10 p (mkTuple i5 i6) (mkTuple (max (+ 0 p2) 0) p2)))))
(check-synth)

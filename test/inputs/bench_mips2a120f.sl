(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun joinr0 ((x5 Int) (x6 (Tuple Int Int)) (x7 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x5 ((_ tupSel 0) x6) ((_ tupSel 1) x6) ((_ tupSel 0) x7) ((_ tupSel 1) x7) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i7 Int)
(declare-var i13 Int)
(declare-var i14 Int)
(constraint
 (or (not (and (>= i14 0) (>= i14 i13))) (= (+ i13 i) (joinr0 i (mkTuple 0 0) (mkTuple i13 i14)))))
(constraint
 (or (not (and (>= i14 0) (>= i14 i13)))
  (= (+ (+ i13 i) i7) (joinr0 i (mkTuple (+ 0 i7) (max (+ 0 i7) 0)) (mkTuple i13 i14)))))
(check-synth)

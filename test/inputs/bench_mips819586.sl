(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun joinr1 ((x8 Int) (x9 (Tuple Int Int)) (x10 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x8 ((_ tupSel 0) x9) ((_ tupSel 1) x9) ((_ tupSel 0) x10) ((_ tupSel 1) x10) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i7 Int)
(declare-var i13 Int)
(declare-var i14 Int)
(constraint
 (or (not (and (>= i14 0) (>= i14 i13)))
  (= (max (+ i13 i) i14) (joinr1 i (mkTuple 0 0) (mkTuple i13 i14)))))
(constraint
 (or (not (and (>= i14 0) (>= i14 i13)))
  (= (max (+ (+ i13 i) i7) (max (+ i13 i) i14))
   (joinr1 i (mkTuple (+ 0 i7) (max (+ 0 i7) 0)) (mkTuple i13 i14)))))
(check-synth)

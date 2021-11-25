(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun joinr0 ((x17 Int) (x18 (Tuple Int Int)) (x19 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x17 ((_ tupSel 0) x18) ((_ tupSel 1) x18) ((_ tupSel 0) x19) ((_ tupSel 1) x19) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i7 Int)
(declare-var i84 Int)
(declare-var i85 Int)
(constraint
 (or (not (and (>= i85 0) (>= i85 i84))) (= (+ i84 i) (joinr0 i (mkTuple 0 0) (mkTuple i84 i85)))))
(constraint
 (or (not (and (>= i85 0) (>= i85 i84)))
  (= (+ (+ i84 i) i7) (joinr0 i (mkTuple (+ 0 i7) (max (+ 0 i7) 0)) (mkTuple i84 i85)))))
(check-synth)

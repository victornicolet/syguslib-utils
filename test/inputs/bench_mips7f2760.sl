(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun joinr1 ((x20 Int) (x21 (Tuple Int Int)) (x22 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x20 ((_ tupSel 0) x21) ((_ tupSel 1) x21) ((_ tupSel 0) x22) ((_ tupSel 1) x22) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var i Int)
(declare-var i7 Int)
(declare-var i84 Int)
(declare-var i85 Int)
(constraint
 (or (not (and (>= i85 0) (>= i85 i84)))
  (= (max (+ i84 i) i85) (joinr1 i (mkTuple 0 0) (mkTuple i84 i85)))))
(constraint
 (or (not (and (>= i85 0) (>= i85 i84)))
  (= (max (+ (+ i84 i) i7) (max (+ i84 i) i85))
   (joinr1 i (mkTuple (+ 0 i7) (max (+ 0 i7) 0)) (mkTuple i84 i85)))))
(check-synth)

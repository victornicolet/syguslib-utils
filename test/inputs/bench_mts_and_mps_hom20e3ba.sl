(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot0 ((x2 (Tuple Int Int Int)) (x3 (Tuple Int Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x2) ((_ tupSel 1) x2) ((_ tupSel 2) x2) ((_ tupSel 0) x3) 
    ((_ tupSel 1) x3) ((_ tupSel 2) x3) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p4 Int)
(declare-var i Int)
(declare-var i0 Int)
(declare-var i1 Int)
(constraint
 (or (not (and (>= i1 0) (and (>= i0 0) (and (>= i0 i) (>= i1 i)))))
  (= i (odot0 (mkTuple 0 0 0) (mkTuple i i0 i1)))))
(constraint
 (or (not (and (>= i1 0) (and (>= i0 0) (and (>= i0 i) (>= i1 i)))))
  (= (+ i p4) (odot0 (mkTuple (+ 0 p4) (max (+ 0 p4) 0) (max 0 (+ 0 p4))) (mkTuple i i0 i1)))))
(check-synth)

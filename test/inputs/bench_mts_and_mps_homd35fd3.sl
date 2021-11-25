(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot1 ((x4 (Tuple Int Int Int)) (x5 (Tuple Int Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic ((_ tupSel 0) x4) ((_ tupSel 1) x4) ((_ tupSel 2) x4) ((_ tupSel 0) x5) 
    ((_ tupSel 1) x5) ((_ tupSel 2) x5) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p4 Int)
(declare-var i Int)
(declare-var i0 Int)
(declare-var i1 Int)
(constraint
 (or (not (and (>= i1 0) (and (>= i0 0) (and (>= i0 i) (>= i1 i)))))
  (= i0 (odot1 (mkTuple 0 0 0) (mkTuple i i0 i1)))))
(constraint
 (or (not (and (>= i1 0) (and (>= i0 0) (and (>= i0 i) (>= i1 i)))))
  (= (max (+ i0 p4) 0)
   (odot1 (mkTuple (+ 0 p4) (max (+ 0 p4) 0) (max 0 (+ 0 p4))) (mkTuple i i0 i1)))))
(check-synth)

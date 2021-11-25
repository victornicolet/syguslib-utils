(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot0 ((x5 Int) (x6 (Tuple Int Int)) (x7 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x5 ((_ tupSel 0) x6) ((_ tupSel 1) x6) ((_ tupSel 0) x7) ((_ tupSel 1) x7) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p2 Int)
(declare-var i7 Int)
(declare-var i8 Int)
(constraint
 (or (not (and (> i8 i7) (> i8 0))) (= (+ i7 p) (odot0 p (mkTuple i7 i8) (mkTuple 0 0)))))
(constraint
 (or (not (and (> i8 i7) (> i8 0)))
  (= (+ (+ i7 p2) p) (odot0 p (mkTuple i7 i8) (mkTuple (+ 0 p2) (max (+ 0 p2) 0))))))
(check-synth)

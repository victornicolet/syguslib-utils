(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun odot1 ((x8 Int) (x9 (Tuple Int Int)) (x10 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x8 ((_ tupSel 0) x9) ((_ tupSel 1) x9) ((_ tupSel 0) x10) ((_ tupSel 1) x10) 
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p2 Int)
(declare-var i7 Int)
(declare-var i8 Int)
(constraint
 (or (not (and (> i8 i7) (> i8 0))) (= (max (+ i7 p) i8) (odot1 p (mkTuple i7 i8) (mkTuple 0 0)))))
(constraint
 (or (not (and (> i8 i7) (> i8 0)))
  (= (max (+ (+ i7 p2) p) (max (+ i7 p2) i8))
   (odot1 p (mkTuple i7 i8) (mkTuple (+ 0 p2) (max (+ 0 p2) 0))))))
(check-synth)

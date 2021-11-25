(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join10 ((x159 Int) (x160 (Tuple Int Int)) (x161 (Tuple Int Int))) Int
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x159 ((_ tupSel 0) x160) ((_ tupSel 1) x160) ((_ tupSel 0) x161) 
    ((_ tupSel 1) x161) (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var p2 Int)
(declare-var i11 Int)
(declare-var i12 Int)
(declare-var i36 Int)
(declare-var i37 Int)
(constraint (or (not (>= i36 0)) (= (max (+ i36 p) 0) (join10 p (mkTuple i36 i37) (mkTuple 0 0)))))
(constraint
 (or (not (>= i36 0))
  (= (max (+ (max (+ i36 p) 0) p2) 0) (join10 p (mkTuple i36 i37) (mkTuple (max (+ 0 p2) 0) p2)))))
(constraint
 (or (not (>= i36 0))
  (= (max (+ (max (+ (max (+ i36 p) 0) p2) 0) i12) 0)
   (join10 p (mkTuple i36 i37) (mkTuple (max (+ (max (+ 0 p2) 0) i12) 0) (+ p2 i12))))))
(constraint
 (or (not (>= i36 0))
  (= (max (+ (max (+ (max (+ i36 p) 0) i11) 0) p2) 0)
   (join10 p (mkTuple i36 i37) (mkTuple (max (+ (max (+ 0 i11) 0) p2) 0) (+ p2 i11))))))
(check-synth)

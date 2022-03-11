(set-logic DTLIA)
(define-fun max ((x Int) (y Int)) Int (ite (>= x y) x y))
(synth-fun join10 ((x9 Int) (x10 (Tuple Int Int)) (x11 (Tuple Int Int))) Int
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x9 ((_ tupSel 0) x10) ((_ tupSel 1) x10) ((_ tupSel 0) x11) ((_ tupSel 1) x11)
    (- Ix) (+ Ix Ix) (max Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p0 Int)
(declare-var p3 Int)
(declare-var p7 Int)
(declare-var i Int)
(constraint (= p0 (join10 p0 (mkTuple 0 0) (mkTuple 0 0))))
(constraint (= (+ p0 p7) (join10 p0 (mkTuple 0 0) (mkTuple (+ 0 p7) (max 0 (+ 0 p7))))))
(constraint (= (+ p0 p3) (join10 p0 (mkTuple (+ 0 p3) (max 0 (+ 0 p3))) (mkTuple 0 0))))
(constraint
 (= (+ (+ p0 p3) i)
  (join10 p0 (mkTuple (+ 0 p3) (max 0 (+ 0 p3))) (mkTuple (+ 0 i) (max 0 (+ 0 i))))))
(check-synth)

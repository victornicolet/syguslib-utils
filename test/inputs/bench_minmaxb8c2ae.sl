(set-logic DTLIA)
(define-fun min ((x Int) (y Int)) Int (ite (<= x y) x y))
(synth-fun join0 ((x1 Int) (x2 (Tuple Int Int)) (x3 (Tuple Int Int))) Int 
 ((Ix Int) (Ic Int))
 ((Ix Int
   (Ic x1 ((_ tupSel 0) x2) ((_ tupSel 1) x2) ((_ tupSel 0) x3) ((_ tupSel 1) x3) 
    (- Ix) (+ Ix Ix) (min Ix Ix)))
  (Ic Int ((Constant Int)))))
(declare-var p0 Int)
(declare-var p3 Int)
(declare-var p7 Int)
(constraint (= (min (min p0 p3) p7) (join0 p0 (mkTuple p3 p3) (mkTuple p7 p7))))
(check-synth)

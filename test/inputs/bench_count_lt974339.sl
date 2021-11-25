(set-logic LIA)
(synth-fun xi_2 ((x11 Int)) Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic x11 (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var x Int)
(declare-var i Int)
(declare-var i1979 Int)
(declare-var i1980 Int)
(constraint
 (or
  (not
   (and
    (and (and (>= i1979 0) (>= i1980 0))
     (or (not (and (and (>= i1979 0) (>= i1980 0)) (not (< i x)))) (= i1980 0)))
    (not (< i x))))
  (= (+ i1979 i1980) (xi_2 i1979))))
(check-synth)

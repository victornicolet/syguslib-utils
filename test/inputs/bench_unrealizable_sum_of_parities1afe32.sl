(set-logic NIA)
(synth-fun c1 () Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var i67 Int)
(declare-var i68 Int)
(constraint
 (or
  (not
   (and (and (>= i67 0) (>= i68 0))
    (and
     (or (not (and (and (>= i67 0) (>= i68 0)) (or (not (and (>= i67 0) (>= i68 0))) (= i67 0))))
      (= i67 i68))
     (or (not (and (>= i67 0) (>= i68 0))) (= i67 0)))))
  (= (+ (+ (mod p 2) i67) i68) c1)))
(check-synth)

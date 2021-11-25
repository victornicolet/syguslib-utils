(set-logic NIA)
(synth-fun c1 () Int ((Ix Int) (Ic Int))
 ((Ix Int (Ic (- Ix) (+ Ix Ix))) (Ic Int ((Constant Int)))))
(declare-var p Int)
(declare-var i159 Int)
(declare-var i160 Int)
(constraint
 (or
  (not
   (and (and (>= i159 0) (>= i160 0))
    (and
     (and
      (or
       (not
        (and (and (>= i159 0) (>= i160 0))
         (and
          (or
           (not
            (and (and (>= i159 0) (>= i160 0)) (or (not (and (>= i159 0) (>= i160 0))) (= i159 0))))
           (= i159 i160))
          (or (not (and (>= i159 0) (>= i160 0))) (= i159 0)))))
       (= i159 (mod (+ p i160) 2)))
      (or
       (not
        (and (and (>= i159 0) (>= i160 0)) (or (not (and (>= i159 0) (>= i160 0))) (= i159 0))))
       (= i159 i160)))
     (or (not (and (>= i159 0) (>= i160 0))) (= i159 0)))))
  (= (+ (+ (mod p 2) i159) i160) c1)))
(check-synth)

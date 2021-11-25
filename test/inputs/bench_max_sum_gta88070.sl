(set-logic LIA)
(synth-fun c0 () Int ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int (Ic (- Ix) (+ Ix Ix) (ite Ipred Ix Ix))) (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var input Int)
(declare-var i Int)
(declare-var p Int)
(declare-var i6536 Int)
(declare-var i6537 Int)
(constraint
 (or
  (not
   (and
    (and
     (and
      (or
       (not
        (and
         (and (or (not (and (or (not (> input i)) (= i6536 0)) (> input i))) (> input p))
          (or (not (> input i)) (= i6536 0)))
         (> input i)))
       (= i6536 i6537))
      (or (not (and (or (not (> input i)) (= i6536 0)) (> input i))) (> input p)))
     (or (not (> input i)) (= i6536 0)))
    (> input i)))
  (= (+ (+ i6536 i6537) (ite (> p input) p 0)) c0)))
(check-synth)

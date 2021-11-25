(set-logic DTLIA)
(synth-fun join0 ((x43 Int) (x44 (Tuple Int Int)) (x45 (Tuple Int Int))) Int
 ((Ix Int) (Ic Int) (Ipred Bool))
 ((Ix Int
   (Ic x43 ((_ tupSel 0) x44) ((_ tupSel 1) x44) ((_ tupSel 0) x45) ((_ tupSel 1) x45) 
    (- Ix) (+ Ix Ix) (ite Ipred Ix Ix)))
  (Ic Int ((Constant Int)))
  (Ipred Bool ((= Ix Ix) (> Ix Ix) (not Ipred) (and Ipred Ipred) (or Ipred Ipred)))))
(declare-var i Int)
(declare-var i2 Int)
(declare-var i4 Int)
(declare-var i6 Int)
(declare-var i8 Int)
(constraint
 (or (not (and (< i4 i) (<= i i2)))
  (= (ite (> (+ (ite (= i4 i2) 1 0) 1) 1) (+ (ite (= i4 i2) 1 0) 1) 1)
   (join0 i (mkTuple 1 i4) (mkTuple 1 i2)))))
(constraint
 (or (not (and (< i6 i) (<= i i2)))
  (=
   (ite (> (+ (+ (ite (= i6 i2) 1 0) (ite (= i6 i2) 1 0)) 1) (ite (> 2 1) 2 1))
    (+ (+ (ite (= i6 i2) 1 0) (ite (= i6 i2) 1 0)) 1) (ite (> 2 1) 2 1))
   (join0 i
    (mkTuple (ite (> (+ (ite (= i6 i6) 1 0) 1) 1) (+ (ite (= i6 i6) 1 0) 1) 1)
     (ite (> (+ (ite (= i6 i6) 1 0) 1) 1) i6 i6))
    (mkTuple 1 i2)))))
(constraint
 (or (not (and (< i8 i) (<= i i2)))
  (=
   (ite
    (> (+ (+ (ite (= i8 i2) 1 0) 1) 1)
     (ite (> (+ (ite (= i8 i2) 1 0) 1) 1) (+ (ite (= i8 i2) 1 0) 1) 1))
    (+ (+ (ite (= i8 i2) 1 0) 1) 1)
    (ite (> (+ (ite (= i8 i2) 1 0) 1) 1) (+ (ite (= i8 i2) 1 0) 1) 1))
   (join0 i (mkTuple 1 i8)
    (mkTuple (ite (> (+ (ite (= i2 i2) 1 0) 1) 1) (+ (ite (= i2 i2) 1 0) 1) 1)
     (ite (> (+ (ite (= i2 i2) 1 0) 1) 1) i2 i2))))))
(check-synth)

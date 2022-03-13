(defpackage egal
  (:use :cl)
  (:shadow :=)
  (:export :=))

(in-package egal)

(defgeneric = (a b))

(defmethod = ((a t) (b t))
  (cl:eql a b))

(defmethod = ((a number) (b number))
  (cl:= a b))

(defmethod = ((a seq:seq) (b seq:seq))
  (seq:= a b))

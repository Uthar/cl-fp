(defpackage seq
  (:use :cl)
  (:shadow :list :cons :count := :first :rest :assoc :get :nth :pop :subseq :reduce :map :merge)
  (:export

   ;; FIXME implementation package
   :cons
   :list
   :lazy-seq

   :map
   :filter
   :merge

   ;; Collection
   :conj
   :seq
   :count
   :empty
   :=

   ;; Sequence
   :seq
   :first
   :rest
   :next

   ;; Associative
   :assoc
   :dissoc
   :get
   :contains?

   ;; Indexed
   :nth

   ;; Stack
   :conj
   :pop
   :peek

   ;; Set
   :disj

   ;; Sorted
   :rseq
   :subseq
   :rsubseq))

(in-package seq)

(defclass seq () ())

;; Collection
(defgeneric conj (seq val))
(defgeneric seq (seq))
(defgeneric count (seq))
(defgeneric empty (seq))
(defgeneric = (seq1 seq2))

;; Sequence
(defgeneric seq (seq))
(defgeneric first (seq))
(defgeneric rest (seq))
(defgeneric next (seq))

;; Associative
(defgeneric assoc (seq key val))
(defgeneric dissoc (seq key))
(defgeneric get (seq key))
(defgeneric contains? (seq key))

;; Indexed
(defgeneric nth (seq key))

;; Stack
(defgeneric conj (seq val))
(defgeneric pop (seq))
(defgeneric peek (seq))

;; Set
(defgeneric disj (seq val))

;; Sorted
(defgeneric rseq (seq))
(defgeneric subseq (seq))
(defgeneric rsubseq (seq))

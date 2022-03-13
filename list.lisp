(in-package seq)

;;;; Cons

(defclass seq:cons (seq)
  ((first :initarg :first :reader get-first)
   (rest :initarg :rest :reader get-rest)))

(defun cons (x seq)
  (check-type seq (or null seq:seq))
  (make-instance 'seq:cons
                 :first x
                 :rest seq))

(defclass empty-list (seq:seq) ())
(defparameter +empty-list+ (make-instance 'empty-list))
(defmethod seq:first ((seq (eql +empty-list+))) nil)
(defmethod seq:rest  ((seq (eql +empty-list+))) seq)
(defmethod seq:empty ((seq (eql +empty-list+))) seq)
(defmethod seq:conj ((seq (eql +empty-list+)) x) (seq:cons x seq))

(defun list (&rest xs)
  (cl:reduce (lambda (cons x)
            (seq:cons x cons))
          (reverse xs)
          :initial-value +empty-list+))

(defmethod seq:conj ((cons seq:cons) x)
  (seq:cons x cons))

(defmethod seq:first ((cons seq:cons))
  (get-first cons))

(defmethod seq:rest ((cons seq:cons))
  (or (get-rest cons) +empty-list+))

(defmethod seq:empty ((cons seq:cons))
  +empty-list+)

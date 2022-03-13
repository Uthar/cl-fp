(in-package seq)

(defclass cat (seq:seq)
  ((coll :initarg :coll :reader get-coll)
   (colls :initarg :colls :reader get-colls)))

(defun cat (coll colls)
  (check-type colls (or null cl:cons))
  (make-instance 'cat :coll coll :colls colls))

(defmethod seq:first ((cat cat))
  (first (get-coll cat)))

(defmethod seq:rest ((cat cat))
  (let ((coll (get-coll cat))
        (colls (get-colls cat)))
    (if (seq (rest coll))
        (cat (rest coll)
             colls)
        (cat (cl:first colls)
             (cl:rest colls)))))

(in-package seq)

(defclass pair ()
  ((key :initarg :key :reader get-key)
   (val :initarg :val :reader get-val)))

(defun pair (k v)
  (make-instance 'pair :key k :val v))

(defmethod key ((pair pair))
  (get-key pair))

(defmethod val ((pair pair))
  (get-val pair))

(defmethod print-object ((pair pair) stream)
  (format stream "[")
  (format stream "~a ~a" (key pair) (val pair))
  (format stream "]"))

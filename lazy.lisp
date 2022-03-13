(in-package seq)

;; Can get infinite sequences by returning, from thunks, things which
;; seq:rest of yields yet another lazy-seq
(defclass lazy-seq (seq:seq)
  ((thunk :initarg :thunk :reader get-thunk)))

(defmacro lazy-seq (seq-form)
  `(make-instance 'lazy-seq :thunk (lambda () ,seq-form)))

(defmethod seq:conj ((lazy-seq lazy-seq) val)
  (seq:cons val lazy-seq))

(defmethod seq:empty ((lazy-seq lazy-seq))
  (seq:list))

(defmethod seq:first ((lazy-seq lazy-seq))
  (seq:first (funcall (get-thunk lazy-seq))))

(defmethod seq:rest ((lazy-seq lazy-seq))
  (seq:rest (funcall (get-thunk lazy-seq))))

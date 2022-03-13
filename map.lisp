(in-package seq)

(defmethod seq:conj ((map cl-hamt:hash-dict) x)
  (check-type x pair)
  (cl-hamt:dict-insert map (key x) (val x)))

(defmethod seq:seq ((map cl-hamt:hash-dict))
  (unless (zerop (cl-hamt:dict-size map))
    (let* ((alist (cl-hamt:dict->alist map))
           (pairs (mapcar (lambda (pair)
                            (pair (car pair) (cdr pair)))
                          alist)))
      (apply #'seq:list pairs))))

(defmethod seq:count ((map cl-hamt:hash-dict))
  (cl-hamt:dict-size map))

(defmethod seq:empty ((map cl-hamt:hash-dict))
  (cl-hamt:empty-dict))

(defmethod seq:first ((map cl-hamt:hash-dict))
  (seq:first (seq:seq map)))

(defmethod seq:rest ((map cl-hamt:hash-dict))
  (seq:rest (seq:seq map)))

(defmethod seq:assoc ((map cl-hamt:hash-dict) key val)
  (cl-hamt:dict-insert map key val))

(defmethod seq:dissoc ((map cl-hamt:hash-dict) key)
  (cl-hamt:dict-remove map key))

(defmethod seq:get ((map cl-hamt:hash-dict) key)
  (cl-hamt:dict-lookup map key))

(defmethod seq:contains? ((map cl-hamt:hash-dict) key)
  (not (null (cl-hamt:dict-lookup map key))))

(defun alist->lists (alist)
  (mapcar (lambda (cons)
            (cl:list (car cons) (cdr cons)))
          alist))

(defmethod print-object ((map cl-hamt:hash-dict) stream)
  (format stream "{")
  (format stream "~{~{~a ~a~}~^, ~}" (alist->lists (cl-hamt:dict->alist map)))
  (format stream "}"))

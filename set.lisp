(in-package seq)

(defmethod seq:conj ((set cl-hamt:hash-set) x)
  (cl-hamt:set-insert set x))

(defmethod seq:seq ((set cl-hamt:hash-set))
  (let ((list (cl-hamt:set->list set)))
    (apply #'seq:list list)))

(defmethod seq:count ((set cl-hamt:hash-set))
  (cl-hamt:set-size set))

(defmethod seq:empty ((set cl-hamt:hash-set))
  (cl-hamt:empty-set))

(defmethod seq:first ((set cl-hamt:hash-set))
  (seq:first (seq:seq set)))

(defmethod seq:rest ((set cl-hamt:hash-set))
  (seq:rest (seq:seq set)))

(defmethod seq:get ((set cl-hamt:hash-set) val)
  (cl-hamt:set-lookup set val))

(defmethod seq:contains? ((set cl-hamt:hash-set) val)
  (not (null (cl-hamt:set-lookup set val))))

(defmethod seq:disj ((set cl-hamt:hash-set) val)
  (cl-hamt:set-remove set val))

(defmethod print-object ((set cl-hamt:hash-set) stream)
  (format stream "#{")
  (format stream "~{~a~^ ~}" (cl-hamt:set->list set))
  (format stream "}"))

(defmethod seq:next ((set cl-hamt:hash-set))
  (when (seq:seq set)
    (seq:rest set)))

(defmethod cl-murmurhash:murmurhash ((pair pair) &key)
  (cl-murmurhash:murmurhash (cl:list (key pair) (val pair))))

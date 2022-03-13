(in-package seq)

(defmethod seq:conj ((vec tuple:tuple) x)
  (tuple:conj vec x))

(defmethod seq:seq ((vec tuple:tuple))
  (unless (cl:<= (tuple:count vec) 0)
    (apply #'seq:list (tuple:tuple->list vec))))

(defmethod seq:count ((vec tuple:tuple))
  (tuple:count vec))

(defmethod seq:empty ((vec tuple:tuple))
  (tuple:tuple))

(defmethod seq:first ((vec tuple:tuple))
  (tuple:lookup vec 0))

(defmethod seq:rest ((vec tuple:tuple))
  (tuple:slice vec 1))

(defmethod seq:assoc ((vec tuple:tuple) key val)
  (tuple:insert vec key val))

;; no dissoc

(defmethod seq:get ((vec tuple:tuple) key)
  (tuple:lookup vec key))

(defmethod seq:contains? ((vec tuple:tuple) key)
  (not (null (tuple:lookup vec key))))

(defmethod seq:nth ((vec tuple:tuple) key)
  (tuple:lookup vec key))

(defmethod seq:pop ((vec tuple:tuple))
  (tuple:pop vec))

(defmethod seq:peek ((vec tuple:tuple))
  (tuple:peek vec))

(defmethod print-object ((vec tuple:tuple) stream)
  (format stream "[")
  (format stream "~{~a~^ ~}" (tuple:tuple->list vec))
  (format stream "]"))

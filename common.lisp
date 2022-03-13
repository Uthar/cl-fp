(in-package seq)

;; Common functions

(defmethod seq:count ((seq seq:seq))
  (labels
      ((lp (n seq)
         (if (seq:seq seq)
             (lp (1+ n) (seq:rest seq))
             n)))
    (lp 0 seq)))

(defmethod seq:= ((seq1 seq:seq) (seq2 seq:seq))
  (labels
      ((lp (seq1 seq2)
         (cond
           ((and (not (seq:seq seq1))
                 (not (seq:seq seq2)))
            t)

           ((egal:= (seq:first seq1)
                    (seq:first seq2))
            (lp (seq:rest seq1) (seq:rest seq2)))

           (t nil))))

    (lp seq1 seq2)))

(defmethod seq:seq ((seq seq:seq))
  (when (seq:first seq)
    seq))

(defmethod seq:seq ((seq null))
  nil)

(defmethod seq:first ((seq null))
  nil)

(defmethod seq:rest ((seq null))
  nil)

(defmethod seq:next ((seq seq:seq))
  (when (seq:seq seq)
    (seq:rest seq)))

(defmethod seq:next ((seq null))
  nil)

(defmethod print-object ((seq seq:seq) stream)
  (format stream "(")
  (loop for s = seq
        then (seq:next s)
        do (format stream "~a" (seq:first s))
        if (seq:next (seq:next s))
        do (format stream " ")
        else
        do (return))
  (format stream ")"))

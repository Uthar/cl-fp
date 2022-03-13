(in-package seq)

(defun range ()
  "Return an infinite sequence of natural numbers"
  (labels
      ((lp (n)
         (seq:cons n (lazy-seq (lp (1+ n))))))
    (lp 0)))

(defun take (n seq)
  "Return the first n elements of seq"
  (when (plusp n)
    (seq:cons (seq:first seq)
              (take (1- n) (seq:rest seq)))))

(defun iterate (f x)
  "Return an infinite sequence of applications of f to the previous
   iteration's value"
  (seq:cons x (lazy-seq (iterate f (funcall f x)))))

(defun drop (n seq)
  "Return all but the first n elemnts of seq"
  (labels ((lp (n seq)
             (if (zerop n)
                 seq
                 (lp (1- n) (seq:rest seq)))))
    (lp n seq)))


(defun reduce (f seq &optional init)
  "Reduce seq using f"
  (labels
      ((lp (prev cur)
         (if (not (seq:seq cur))
             prev
             (lp (funcall f prev (seq:first cur))
                 (seq:rest cur)))))
    (if init
        (lp init seq)
        (lp (seq:first seq) (seq:rest seq)))))

(defun into (to from)
  "Pour elemets of from into to"
  (reduce #'seq:conj from to))

(defun seq:map (f seq)
  (lazy-seq
   (when (seq:seq seq)
     (seq:cons (funcall f (seq:first seq))
               (seq:map f (seq:rest seq))))))

(defun seq:filter (f seq)
  (lazy-seq
   (when (seq:seq seq)
     (let ((fst (seq:first seq)))
       (if (funcall f fst)
           (seq:cons fst (seq:filter f (seq:rest seq)))
           (seq:filter f (seq:rest seq)))))))

(defun partition (n seq)
  "Partition seq into n-long seqs"
  (lazy-seq
   (when (seq:seq seq)
     (cons (take n seq) (partition n (drop n seq))))))

(defun repeatedly (f &optional n)
  "Returns an infinite/n-long lazy-seq of funcalls of f"
  (if (numberp n)
      (when (plusp n)
        (lazy-seq (cons (funcall f) (repeatedly f (1- n)))))
      (lazy-seq (cons (funcall f) (repeatedly f)))))

(defun repeat (x &optional n)
  "Returns an infinite/n-long lazy-seq of x(s)"
  (if (numberp n)
      (when (plusp n)
        (lazy-seq (cons x (repeat x (1- n)))))
      (lazy-seq (cons x (repeat x)))))

(defun merge (&rest maps)
  "Combine maps from right to left"
  (reduce #'into (apply #'list maps)))

(defun select-keys (map keys)
  (reduce (lambda (vals key)
            (let ((val (get map key)))
              (if val
                  (assoc vals key val)
                  vals)))
          keys
          {}))

(defun concat (&rest colls)
  "Return the concatenation of colls"
  (cat (cl:first colls) (cl:rest colls)))

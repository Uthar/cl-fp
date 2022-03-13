(in-package seq)

(defun vec-reader (stream char)
  (declare (ignore char))
  `(tuple:tuple ,@(read-delimited-list #\] stream t)))

(set-macro-character #\[ 'vec-reader)
(set-macro-character #\] (get-macro-character #\) nil))

(defun map-reader (stream char)
  (declare (ignore char))
  `(cl-hamt:dict-insert (cl-hamt:empty-dict) ,@(read-delimited-list #\} stream t)))

(set-macro-character #\{ 'map-reader)
(set-macro-character #\} (get-macro-character #\) nil))

(defun set-reader (stream char arg)
  (declare (ignore char arg))
  `(cl-hamt:set-insert (cl-hamt:empty-set) ,@(read-delimited-list #\} stream t)))

(set-dispatch-macro-character #\# #\{ 'set-reader)
(set-macro-character #\} (get-macro-character #\) nil))



(defsystem seq
  :depends-on (
               :cl-hamt
               :tuple
               )

  :components (
               (:file "api")
               (:file "egal")
               (:file "common")
               (:file "list")
               (:file "lazy")
               (:file "vec")
               (:file "pair")
               (:file "map")
               (:file "set")
               (:file "cat")
               (:file "reader")
               (:file "lib")
               ))

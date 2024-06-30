;;;; net.bardcode.nodeid.asd

(asdf:defsystem #:net.bardcode.nodeid
  :description "Describe net.bardcode.nodeid here"
  :author "mikel evins <mikel@evins.net>"
  :license  "MIT"
  :version (:read-file-form "version.lisp")
  :serial t
  :depends-on (
               :uiop ; [MIT] https://github.com/fare/asdf/tree/master/uiop
               :frugal-uuid ; [MIT] https://github.com/ak-coram/cl-frugal-uuid
               )
  :components ((:file "package")
               (:file "nodeid")))

;;; (asdf:load-system :net.bardcode.nodeid)

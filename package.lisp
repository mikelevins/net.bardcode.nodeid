;;;; package.lisp

(defpackage #:net.bardcode.nodeid
  (:use #:cl)
  (:nicknames :nodeid)
  (:export
   #:ensure-nodeid
   #:make-nodeid
   #:nodeid-pathname
   #:read-nodeid
   #:reset-nodeid
   #:save-nodeid
   ))



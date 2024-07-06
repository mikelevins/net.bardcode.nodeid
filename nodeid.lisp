;;;; ***********************************************************************
;;;; 
;;;; Name:          nodeid.lisp
;;;; Project:       nodeid
;;;; Purpose:       computing, storing, and reading nodeids
;;;; Author:        mikel evins
;;;; Copyright:     2021 by mikel evins
;;;;
;;;; ***********************************************************************

(in-package #:net.bardcode.nodeid)

;;; XDG standard config file paths: 
;;;
;;; | OS      | Config Path                                          | 
;;; |---------|------------------------------------------------------|
;;; | Linux   | $HOME/.config/net.bardcode.nodeid/nodeid             | 
;;; | macOS   | $HOME/Library/Preferences/net.bardcode.nodeid/nodeid | 
;;; | Windows | %APPDATA%\net.bardcode.nodeid\nodeid                 | 

(defun nodeid-pathname ()
  #+linux (merge-pathnames ".config/net.bardcode.nodeid/nodeid" (user-homedir-pathname))
  #+darwin (merge-pathnames "Library/Preferences/net.bardcode.nodeid/nodeid" (user-homedir-pathname))
  #+win32 (merge-pathnames "net.bardcode.nodeid\nodeid" (user-homedir-pathname)))

#+nil (nodeid-pathname)

(defmethod %make-nodeid ((id string))
  (frugal-uuid:from-string id))

(defun make-nodeid (&optional id)
  (if id
      (%make-nodeid id)
      (frugal-uuid:make-v7)))

#+nil (frugal-uuid:make-v7)
#+nil (frugal-uuid:to-string (frugal-uuid:make-v7))

(defmethod save-nodeid ((idstr string) &key (if-exists :error)) ; :error or :supersede
  (assert (typep (frugal-uuid:from-string idstr) 'frugal-uuid:uuid)()
          "Invalid node id string: ~S" idstr)
  (let ((savepath (nodeid-pathname)))
    (ensure-directories-exist savepath)
    (with-open-file (out savepath :direction :output :element-type 'character
                         :if-does-not-exist :create :if-exists if-exists)
      (format out "~S" idstr))))

(defmethod save-nodeid ((id frugal-uuid:uuid) &key (if-exists :error)) ; :error or :supersede
  (save-nodeid (frugal-uuid:to-string id)))

#+nil (defparameter $id (frugal-uuid:make-v7))
#+nil (save-nodeid $id)
#+nil (save-nodeid (frugal-uuid:to-string $id))

(defun read-nodeid ()
  (let ((savepath (nodeid-pathname)))
    (with-open-file (in savepath :direction :input :element-type 'character
                        :if-does-not-exist nil)
      (when in
        (read in)))))


(defun reset-nodeid ()
  (let ((savepath (nodeid-pathname))
        (newid (make-nodeid)))
    (when (probe-file savepath)
      (delete-file savepath))
    (save-nodeid newid)
    newid))

#+nil (defparameter $id (frugal-uuid:make-v7))
#+nil (read-nodeid)

(defun ensure-nodeid ()
  (let ((found (read-nodeid)))
    (or found
        (let ((id (make-nodeid)))
          (save-nodeid id)
          id))))

#+nil (read-nodeid)
#+nil (ensure-nodeid)
#+nil (reset-nodeid)

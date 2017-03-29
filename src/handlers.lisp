(defpackage :handlers
  (:use :cl :hunchentoot))

(in-package :handlers)

;;; Define handlers
(defun foo1 (&rest args) "Hello everyone, this is spa-five")
(defun bar  (&rest args)
  (format nil "Weeeeeeeeeee yay!!! ~A" args))
(defun baz  (&rest args)
  ;; this is the way of invoking a debugger
  ;; (cerror "debugging session" "tried ~a" args)
  (format nil "Baz ~a ~a <br>get parameters ~a"
          (request-method *request*)
          args
          (get-parameters *request*)))

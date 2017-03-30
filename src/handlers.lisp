(defpackage :handlers
  (:use :cl :hunchentoot :cl-who))

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

(defun assets ()
  (let ((asset (cl-fad:merge-pathnames-as-file
                     server::*file-root*
                     (script-name *request*))))
    ;; problem with path creation
    (cerror "debugging request" "request ~a  ~a" *request* asset )
    (hunchentoot:handle-static-file asset)))

(defun parenscripts (&rest args)
  "parenscripts will go here")

(defun home (&rest args)
  (with-html-output-to-string (*standard-output* nil :indent T)
    (:html
     (:head
      (:title "SPA five")
      (:link :href "/stylesheets/style.css" :media "all" :rel "stylesheet" :type "text/css")
      ;; (:script :src "/javascripts/jquery-3.1.1.min.js")
      ;; (:script :src "/javascripts/javascript.js")
      )
     (:body
      (:h1 "The Page")
      (:p "this is content of" (fmt "~A" (script-name *request*)) )))))

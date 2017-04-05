(declaim (optimize (debug 3)))

(defpackage :handlers
  (:use :cl :hunchentoot :cl-who :parenscript))

(in-package :handlers)

;;; Define handlers
(defun foo1 (args) "Hello everyone, this is spa-five")

(defun bar  (args)
  (format nil "Weeeeeeeeeee yay!!! ~A" args))

(defun baz  (args)
  ;; this is the way of invoking a debugger
  ;; (cerror "debugging session" "tried ~a" args)
  (format nil "Baz ~a ~a <br>get parameters ~a"
          (request-method *request*)
          args
          (get-parameters *request*)))

(defun assets ()
  (let ((asset (merge-pathnames
                (subseq (script-name *request*) 1)
                (parse-namestring server::*file-root*))))
    ;;(cerror "debugging session" "tried ~a" asset)
    (hunchentoot:handle-static-file asset)))

(defun parenscripts (args)
  (setf (hunchentoot:content-type*) "text/javascript")
  (parenscripts-js))

(defun layout (view)
  (with-html-output-to-string (*standard-output* nil :indent T)
    (:html
     (:head
      (:title "Spa five")
      (:link :href "/stylesheets/style.css" :media "all" :rel "stylesheet" :type "text/css")
      (:script :src "/javascripts/jquery-3.2.0.js")
      (:script :src "/javascripts/javascript.js")
      (:script :src "/parenscripts/first-parenscript.js")
      )
     (:body
      (fmt "~a" view)
      (:footer (multiple-value-bind
                     (s m h date month year wkd dst zone)
                   (get-decoded-time)
                 (fmt "time now ~2,'0d:~2,'0d current date ~2,'0d/~2,'0d/~d"
                      h m date month year) ))))))

(defun home ()
  (layout
   (with-html-output-to-string (*standard-output* nil :indent T)
     (:h1 :onclick (ps (greeting-callback)) "Home")
     (:p "this is content of " (fmt "~A" (script-name *request*)) )
     (:a :href "/about" "About"))))

(defun about ()
  (layout
   (with-html-output-to-string (*standard-output* nil :indent T)
     (:h1 :onclick (ps (hiding-callback)) "About")
     (:p "this is content of " (fmt "~A" (script-name *request*)) )
     (:a :href "/" "Home"))))

(defun spa ()
  (setf (html-mode) :HTML5)
  (with-html-output-to-string (*standard-output* nil :indent T :prologue T)
    (:html
     (:head
      (:title "SPA")
      (:script :src "https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"))
     (:body
      (:div :data-ng-app ""
            (:p (fmt "My first expression: {{ ~a }}" (ps (+ 5 5))))
            (:p "Name: " (:input :type "text" :data-ng-model "name"))
            (:p "Entered name was: {{ name }}")
            )))))

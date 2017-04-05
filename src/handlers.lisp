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
      (:div :data-ng-app "myApp" :data-ng-controller "myCtrl"
            "First Name:" (:input :type "text" :data-ng-model "firstName") (:br)
            "Last Name:"  (:input :type "text" :data-ng-model "lastName")  (:br)
            (:br)
            (fmt "Full Name: {{ ~a }}" (ps (+ first-name " " last-name))))
      (:script
       (fmt "~%~A"
            (ps
              ;; last AngularJS Example from
              ;; https://www.w3schools.com/angular/angular_intro.asp
              (var app (chain angular (module "myApp" (array))))
              (chain app (controller "myCtrl" (lambda ($scope)
                                             (setf (@ $scope first-name) "John")
                                             (setf (@ $scope first-name) "Doe")
                                             (return undefined)))))))))))

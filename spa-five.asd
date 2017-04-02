#|
  This file is a part of spa-five project.
  Copyright (c) 2017 Jacek Podkanski (ruby.object@googlemail.com)
|#

#|
  single-page app experiment

  Author: Jacek Podkanski (ruby.object@googlemail.com)
|#



(in-package :cl-user)
(defpackage spa-five-asd
  (:use :cl :asdf))
(in-package :spa-five-asd)


(defsystem spa-five
  :version "0.1"
  :author "Jacek Podkanski"
  :mailto "ruby.object@googlemail.com"
  :license "LLGPL"
  :depends-on (:alexandria
               :iterate
               :hunchentoot
               :parenscript
               :cl-who)
  :components ((:module "src"
                :components
                ((:module "lib"
                          :components
                          ((:file "server")))
                 (:file "package")
                 (:file "handlers")
                 (:file "parenscripts")
                 (:file "routes")
                 )))
  :description "single-page app experiment"
  :in-order-to ((test-op (test-op :spa-five.test))))

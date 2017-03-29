#|
  This file is a part of spa-five project.
  Copyright (c) 2017 Jacek Podkanski (ruby.object@googlemail.com)
|#


(in-package :cl-user)
(defpackage spa-five.test-asd
  (:use :cl :asdf))
(in-package :spa-five.test-asd)


(defsystem spa-five.test
  :author "Jacek Podkanski"
  :mailto "ruby.object@googlemail.com"
  :description "Test system of spa-five"
  :license "LLGPL"
  :depends-on (:spa-five
               :fiveam)
  :components ((:module "t"
                :components
                ((:file "package"))))
  :perform (test-op :after (op c) (eval
 (read-from-string
  "(let ((res (5am:run :spa-five)))
     (explain! res)
     (every #'fiveam::TEST-PASSED-P res))"))
))

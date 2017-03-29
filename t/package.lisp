#|
  This file is a part of spa-five project.
  Copyright (c) 2017 Jacek Podkanski (ruby.object@googlemail.com)
|#

(in-package :cl-user)
(defpackage :spa-five.test
  (:use :cl
        :spa-five
        :fiveam
        :alexandria :iterate))
(in-package :spa-five.test)



(def-suite :spa-five)
(in-suite :spa-five)

;; run test with (run! test-name) 

(test spa-five

  )




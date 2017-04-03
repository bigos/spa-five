(in-package :handlers)

(defun parenscripts-js ()
  (ps
    (defun greeting-callback ()
      (alert "Hello World and everyone else"))

    (defun hiding-callback ()
      (chain ($ "footer") (toggle)))

    ;; example code from http://imgur.com/qg6mn1z
    (progn (var your_drink)
           (var reverse (lambda (s)
                          (chain s (split "") (reverse) (join ""))))
           (var bartender (create
                           str1 "ers"
                           str2 (reverse "rap")
                           str3 "amet"
                           request (lambda (preference)
                                     (+ preference ".Secret word: "
                                        (+ (@ this str2)
                                           (@ this str3)
                                           (@ this str1)))))))

  ))                                    ; end of parenscript:ps

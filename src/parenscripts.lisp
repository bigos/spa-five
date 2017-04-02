(in-package :handlers)

(defun parenscripts-js ()
  (parenscript:ps
    (defun greeting-callback ()
      (alert "Hello World and everyone else"))

    (defun hiding-callback ()
      (parenscript:chain ($ "footer") (toggle)))

    ))

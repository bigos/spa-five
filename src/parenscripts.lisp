(in-package :handlers)

(defun parenscripts-js ()
  (ps
   (defun greeting-callback ()
     (alert "Hello World and everyone else"))

   (defun hiding-callback ()
     (parenscript:chain ($ "footer") (toggle)))

   ))                                   ; end of parenscript:ps

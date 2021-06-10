;;;; qt-conv.asd

(defsystem #:qt-conv
  :description "Describe qt-conv here"
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later"  
  :serial t
  :depends-on (#:qt)
  :components ((:file "package")
               (:file "qt-conv")))


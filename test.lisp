;;;; qt-conv.lisp

(in-package #:qt-conv)

;;; "qt-conv" goes here. Hacks and glory await!



(defmethod initialize-instance :after ((instance my-window) &key)
  (new instance)
  (#_setFixedSize instance 360 170)
  (let ((convert (#_new QPushButton "Convert" instance)))
    (setf (conversionRate instance) (#_new QLineEdit "1.00" instance)
	  (dollarAmount instance) (#_new QLineEdit "0.00" instance)
	  (result instance) (#_new QLineEdit "0.00" instance))
    (#_move (#_new QLabel "Exchange Rate per $1:" instance) 20 20)
    (#_move (#_new QLabel "Dollars to Covert:" instance) 20 60)
    (#_move (#_new QLabel "Amount in other Currency:" instance) 20 100)
    (#_move (dollarAmount instance) 200 60)
    (#_move (conversionRate instance) 200 20)
    (#_move (result instance) 200 100)
    (#_move convert 220 130)
    (#_connect "QObject"
	       convert (QSIGNAL "clicked()")
	       instance (QSLOT "convert()"))))


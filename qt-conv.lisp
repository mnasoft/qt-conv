;;;; qt-conv.lisp

(in-package :qt-conv)

;;; "qt-conv" goes here. Hacks and glory await!

(named-readtables:in-readtable :qt)

(defvar *qapp*)

(defclass my-window()
    ((dollarAmount :accessor dollarAmount)
     (conversionRate :accessor conversionRate)
     (result :accessor result))
  (:metaclass qt-class)
  (:qt-superclass "QWidget")
  (:slots ("convert()" convert)))

(defmethod convert ((instance my-window) &aux (res 0))
  ;; Just ignore if input isn't numeric...
  (handler-case
      (setf res (* (read-from-string (#_text (dollarAmount instance)))
		   (read-from-string (#_text (conversionRate instance)))))
    (t () nil))
  (#_setText (result instance) (format nil "~A" res)))

(defmethod initialize-instance :after ((instance my-window) &key)
  (new instance)
					;  (#_setFixedSize instance 560 170)
  (let* ((convert (#_new QPushButton "Convert" instance))
	 (verticalLayout (#_new  QVBoxLayout  instance))
	 (hbox1 (#_new QHBoxLayout  instance))
	 (hbox2 (#_new QHBoxLayout  instance))
	 (hbox3 (#_new QHBoxLayout  instance))
	 (hbox4 (#_new QHBoxLayout  instance)))
    (setf (conversionRate instance) (#_new QLineEdit "1.00" instance)
	  (dollarAmount instance) (#_new QLineEdit "0.00" instance)
	  (result instance) (#_new QLineEdit "0.00" instance))
    (#_resize instance 600 400)
;;;;    
    (#_addWidget  hbox1 (#_new QLabel "Exchange Rate per $1:" instance))
    (#_addItem    hbox1 (#_new QSpacerItem 40 20 (#_QSizePolicy::Expanding) (#_QSizePolicy::Minimum)))
    (#_addWidget  hbox1 (dollarAmount instance))
    (#_setAlignment (dollarAmount instance) (#_Qt::AlignRight)) 
;;;;
    (#_addWidget hbox2 (#_new QLabel "Долларов для конвертирования:" instance))
    (#_addItem   hbox2 (#_new QSpacerItem 40 20 (#_QSizePolicy::Expanding) (#_QSizePolicy::Minimum)))
    (#_addWidget hbox2 (conversionRate instance))
    (#_setAlignment (conversionRate instance) (#_Qt::AlignRight))
;;;;    
    (#_addWidget hbox3 (#_new QLabel "Amount in other Currency:" instance))
    (#_addItem   hbox3 (#_new QSpacerItem 40 20 (#_QSizePolicy::Expanding) (#_QSizePolicy::Minimum)))
    (#_addWidget hbox3 (result instance))
    (#_setAlignment (result instance) (#_Qt::AlignRight))
;;;;
    (#_addItem   hbox4 (#_new QSpacerItem 40 20 (#_QSizePolicy::Expanding) (#_QSizePolicy::Minimum)))
    (#_addWidget hbox4 convert)
;;;;
    (mapc #'(lambda (el) (#_addLayout verticalLayout  el)) (list hbox1 hbox2 hbox3))
    (#_addItem verticalLayout (#_new QSpacerItem 20 40 (#_QSizePolicy::Minimum) (#_QSizePolicy::Expanding)))
    (#_addLayout verticalLayout hbox4)
;;;;
    (#_connect "QObject"
	       convert (QSIGNAL "clicked()")
	       instance (QSLOT "convert()"))
    (#_setWindowTitle instance "SLIME - Converter")))

(defun main (&optional style)
  (when style
    (#_setStyle "QApplication"
		(#_create "QStyleFactory" (ecase style
					    (:cde "CDE")
					    (:macintosh "Macintosh")
					    (:windows "Windows")
					    (:motif "Motif")))))
  (setf *qapp* (make-qapplication))
  (let ((window (make-instance 'my-window)))
    (#_show window)
    (unwind-protect
	 (#_exec *qapp*)
      (#_hide window))))

(main  :windows)

(global-set-key "\C-caamsw" 'akahige-mod-sleep-apnea-wake-patient)

(global-set-key "\C-caamst" 'akahige-mod-sleep-apnea-start-timer)
(global-set-key "\C-caamsT" 'akahige-mod-sleep-apnea-stop-timer)

(global-set-key "\C-caamsr" 'akahige-mod-sleep-apnea-start-record)
(global-set-key "\C-caamsR" 'akahige-mod-sleep-apnea-stop-record)

(global-set-key "\C-caamsl" 'akahige-mod-sleep-apnea-start-listen)
(global-set-key "\C-caamsL" 'akahige-mod-sleep-apnea-stop-listen)

(global-set-key "\C-caamsb" 'akahige-mod-sleep-apnea-stop-both-record-and-listen)

(defun akahige-mod-sleep-apnea-wake-patient ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "wake" "perform" 'var-Result)))

(defun akahige-mod-sleep-apnea-start-timer ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "timer" "start" 'var-Result)))

(defun akahige-mod-sleep-apnea-cancel-timer ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "timer" "cancel" 'var-Result)))

(defun akahige-mod-sleep-apnea-stop-timer ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "timer" "stop" 'var-Result)))

(defun akahige-mod-sleep-apnea-start-record ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "record" "start" 'var-Result)))

(defun akahige-mod-sleep-apnea-stop-record ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "record" "stop" 'var-Result)))

(defun akahige-mod-sleep-apnea-start-listen ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "listen" "start" 'var-Result)))

(defun akahige-mod-sleep-apnea-stop-listen ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "listen" "stop" 'var-Result)))

(defun akahige-mod-sleep-apnea-stop-both-record-and-listen ()
 ""
 (interactive)
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "record" "stop" 'var-Result))
 (formalog-query (list 'var-Result) (list "akahigeMod" "sleepApneaSystem" "<REDACTED>" "listen" "stop" 'var-Result)))

(setq homedir "/home/andrewdo")

(global-set-key "\C-caau" 'ushell)
(global-set-key "\C-c\C-k\C-vAK" 'akahige)

(global-set-key "\C-caal" 'akahige-load-emacs-lisp-source-file)
(global-set-key "\C-caaa" 'akahige-load-kb-about-agent)
(global-set-key "\C-caax" 'akahige-set-patient-name)

(global-set-key "\C-caas" 'akahige-search-patients-chart)
(global-set-key "\C-caaS" 'akahige-search-patients-file-names)
(global-set-key "\C-caaT" 'akahige-custom-search-1)
(global-set-key "\C-caac" 'akahige-close-searches)

;; LOGS
(global-set-key "\C-cala" 'akahige-log-action)
(global-set-key "\C-calE" 'akahige-log-event)
(global-set-key "\C-calm" 'akahige-log-taking-of-medicine)
(global-set-key "\C-calb" 'akahige-log-restroom-breaks)
(global-set-key "\C-calM" 'akahige-log-meal)
(global-set-key "\C-calt" 'akahige-log-tiredness)
(global-set-key "\C-calc" 'akahige-log-misc)
(global-set-key "\C-calv" 'akahige-log-vitals)
(global-set-key "\C-cals" 'akahige-log-symptom)
(global-set-key "\C-calp" 'akahige-log-pain-level)


(global-set-key "\C-caop" 'akahige-patient-dir-open-in-dired)
(global-set-key "\C-caos" 'akahige-patient-dir-open-in-shell)
(global-set-key "\C-caoi" 'akahige-patient-dir-insert)

;; VISITS
(global-set-key "\C-cavp" 'akahige-visit-load-previous)
(global-set-key "\C-cavv" 'akahige-visit-start)
(global-set-key "\C-cavV" 'akahige-visit-end)
(global-set-key "\C-cavc" 'akahige-visit-open-current-visit-buffer)
(global-set-key "\C-cavq" 'akahige-visit-record-question-answer)
(global-set-key "\C-cavm" 'akahige-visit-record-meeting)
(global-set-key "\C-cavl" 'akahige-visit-open-visit-dir)

;; CALLS
(global-set-key "\C-cacp" 'akahige-call-load-previous)
(global-set-key "\C-cacs" 'akahige-call-start)
(global-set-key "\C-cace" 'akahige-call-end)
(global-set-key "\C-cacc" 'akahige-call-open-current-call-buffer)
(global-set-key "\C-cacq" 'akahige-call-record-question-answer)
(global-set-key "\C-cacl" 'akahige-call-open-call-dir)

(global-set-key "\C-caat" 'akahige-edit-patient-todo)

(global-set-key "\C-caol" 'akahige-open-log)

(global-set-key "\C-caaT" 'akahige-render-timeline)

;; (setq akahige-current-day "20050808")

(defvar akahige-people-data-dir "/var/lib/myfrdcsa/codebases/internal/akahige/data/people")
(defvar akahige-current-patient nil)

(defun akahige-current-date-yyyymmdd ()
 (interactive)
 "Get the current date in YYYYMMDD format"
 (let* ((string (shell-command-to-string "date \"+%Y%m%d\"")))
  (string-match "[0-9]+" string)
  (match-string 0 string)))

(setq akahige-current-day (akahige-current-date-yyyymmdd))


(defun akahige-set-font-large ()
  "Set the font to be large so that the patient can read."
  (interactive)
  (set-default-font "-adobe-courier-bold-*-*-*-34-*-*-*-*-*-*-*")
  )

(defun akahige-set-font-small ()
  "Set the font to be large so that the patient can read."
  (interactive)
  (set-default-font "-*courier-medium-r-normal--14-140-*-iso8859-1")
  )


(defun akahige-alarm ()
  "Remind the user about the next event"
  (interactive))

(defun akahige-hide ()
  "Hide all current activities"
  (interactive)
  ;; Develop hide functionality. 
  )

(defun akahige-daily-report ()
  "Generate a daily report to be sent to the person taking care of the
patient"
  ;;   Have a daily report sent to patient's caretaker, automatically
  ;;  uploaded and sent when I get home, composed of all the days
  ;;  events, etc.  Email information at end of the day.
  (interactive)
)



(defun akahige-rule-base ()
  ""
  ;; Develop rule base that will assist anyone working with the same patient in the future.
  (interactive)
  )

(defun akahige-date ()
  "List date"
  (interactive)
  (eshell/date)
  "")



(defun akahige-question-for-caretaker ()
  "Put a question into the daily report"
  (interactive)
  (let*
      ((question (read-from-minibuffer "Question?: ")))
    (akahige-edit-daily-report)
    (isearch-forward "<QUESTIONS>")))

(defun akahige-load-emacs-lisp-source-file ()
  "Load an  emacs lisp program  for one of  our systems, for  now that
will be Akahige"
  (interactive)
  (find-file 
   (concat "/var/lib/myfrdcsa/codebases/internal/akahige/akahige.el")))

(defun akahige-patient-dir-open-in-dired (&optional agent)
 (interactive)
 (dired (akahige-get-patient-dir (or agent (akahige-get-patient-name)))))

(defun akahige-patient-dir-open-in-shell (&optional agent)
 (interactive)
 (run-in-shell (concat "cd "(shell-quote-argument (akahige-get-patient-dir (or agent (akahige-get-patient-name)))))))

(defun akahige-get-patient-dir (&optional agent)
 ""
 (interactive)
 (akahige-get-patient-dir-for-patient-name (or agent (akahige-get-patient-name))))

(defun akahige-set-patient-name ()
 ""
 (interactive)
 (setq akahige-current-patient nil)
 (setq akahige-current-patient (akahige-get-patient-name)))

(defun akahige-get-patient-name ()
 (interactive)
 (if (non-nil akahige-current-patient)
  akahige-current-patient
  (completing-read "Agent?: " (kmax-directory-files-no-hidden akahige-people-data-dir))))

(defun akahige-get-patient-dir-for-patient-name (agent)
 (interactive)
 (frdcsa-el-concat-dir (list akahige-people-data-dir agent)))

(defun akahige-load-kb-about-agent (&optional tmp-agent skip-complete-predicate)
 ""
 (interactive)
 (let* ((agent (or tmp-agent (akahige-get-patient-name))))
  (kmax-find-file-or-create-including-parent-directories
   (frdcsa-el-concat-dir
    (list
     (akahige-get-patient-dir-for-patient-name agent)
     (downcase (concat agent ".pl")))))
  (end-of-buffer)
  (unless skip-complete-predicate (flp-complete-from-predicates-in-current-buffer))))

;; (defun akahige-search-patients-chart ()
;;  ""
;;  (interactive)
;;  (concat "grep -R " (shell-quote-argument search) " " (shell-quote-argument akahige-get-patient-dir)))

(defun akahige-search-patients-chart (&optional search agent)
 ""
 (interactive)
 (let* ((agent (or agent (akahige-get-patient-name)))
	(patient-dir (akahige-get-patient-dir-for-patient-name agent))
	(search (or search (read-from-minibuffer "Search?: "))))
  (kmax-search-files
   search
   (kmax-grep-list 
    (kmax-grep-v-list-regexp
     (kmax-grep-list-regexp
      (kmax-find-name-dired patient-dir "*")
      "[^~]$")
     (akahige-generate-extension-blacklist-regex))
    #'kmax-non-directory-file)
   (akahige-get-buffer-for-patient agent "Akahige Patient Chart Search")
   "-i"
   " | grep -v \"function init\" ")
  (delete-other-windows)))

(defun akahige-log (type message &optional agent)
 (let* ((agent (or agent (akahige-get-patient-name)))
	(patient-dir (akahige-get-patient-dir-for-patient-name agent))
	(result (read-from-minibuffer message)))
  (ffap (frdcsa-el-concat-dir (list patient-dir "logs" "bioroutine.pl")))
  (end-of-buffer)
  (insert (concat "log(" (flp-prolog-timestamp) "," type "(" (akahige-convert-to-prolog-style agent) "," (kmax-prolog-quote result) ")).\n"))))

(defun akahige-convert-to-prolog-style (string)
 ""
 (let* ((list (split-string string "-"))
	(head (list (downcase (pop list)))))
  (join "" (append head (mapcar #'capitalize list)))))

(defun akahige-log-taking-of-medicine ()
 ""
 (interactive)
 (akahige-log "tookMedicine" "Medicines?: "))

(defvar akahige-actions (list "eat" "brush teeth" "not brush teeth"))
(defvar akahige-events (list "aspiration" "possible(aspiration)"))

(defun akahige-log-action ()
 ""
 (interactive)
 (let ((action (completing-read "Action?: " akahige-actions)))
  (akahige-log action (concat "What was the " action "?: "))))

(defun akahige-log-event ()
 ""
 (interactive)
 (kmax-fixme "<REDACTED>")
 (let ((event (completing-read "Event?: " akahige-events)))
  (akahige-log event (concat "What was the " event "?: "))))

(defun akahige-log-meal ()
 ""
 (interactive)
 (akahige-log "ate" "What was the meal?: "))

(defun akahige-log-tiredness ()
 ""
 (interactive)
 (akahige-log "tiredness" "How tired are you, scale of 1 to 10?: "))

(defun akahige-log-pain-level ()
 ""
 (interactive)
 (akahige-log "painLevel" "What is your pain level?: "))

(defun akahige-log-misc ()
 ""
 (interactive)
 (akahige-log "misc" "What was the misc item?: "))

(defun akahige-log-symptom ()
 ""
 (interactive)
 ;; size color texture consistency
 (akahige-log "hasSymptom" "Symptom?: "))

(defun akahige-log-restroom-breaks ()
 ""
 (interactive)
 ;; size color texture consistency
 (akahige-log "hadRestroomBreak" "Restroom?: "))

(defun akahige-log-vitals ()
 ""
 (interactive)
 (akahige-log "hadVitals" "Vitals?: "))

(defvar akahige-extension-blacklist (list  "css" "js" "pdf" "gif" "jpg" "pnm" "ppm" "doc" "html" "odt" "xls"))
;; (setq akahige-extension-blacklist (list  "css" "js" "pdf" "gif" "jpg" "pnm" "ppm" "doc" "html" "odt" "xls"))

(defun akahige-generate-extension-blacklist-regex ()
 (concat "\\.\\(" (join "\\|" akahige-extension-blacklist) "\\)$"))

(defun akahige-get-buffer-for-patient (patient buffer-name)
  (concat "*" buffer-name " for " agent "*"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun akahige-visit-start ()
 ""
 (interactive)
 ;; (kmax-ffap-or-dired (akahige-visit-current-visit-file) 'formalog-prolog-mode)
 (kmax-ffap-or-dired (akahige-visit-current-visit-file))
 (akahige-visit-record-meeting))

(defun akahige-visit-current-visit-file ()
 (interactive)
 (let* ((patient-dir (akahige-get-patient-dir-for-patient-name (akahige-get-patient-name)))
	(caregiver (akahige-select-name-of-caregiver-for-patient))
	(filename (concat
		    (kmax-datestamp)
		    "-" ;; "-meeting-with-"
		    (replace-regexp-in-string " " "-" 
		     (kmax-decamelcase caregiver))
		    ".pl"))
	(file-name-list (if (kmax-non-empty-string caregiver)
			 (list
			  patient-dir
			  "visits"
			  filename)
			 (list
			  patient-dir
			  "visits"))))
  (frdcsa-el-concat-dir file-name-list)))

(defun akahige-visit-end ()
 ""
 (interactive)
 ;; (restart audio, and move audio file when visit concludes)
 (kmax-not-yet-implemented))

(defun akahige-visit-load-previous ()
 ""
 (interactive)
 (let* ((patient (akahige-get-patient-name))
	(visit-file
	 (ido-completing-read
	  "Which visit file do you wish to open?: "
	  (kmax-directory-files-no-hidden
	   (frdcsa-el-concat-dir
	    (list
	     (akahige-get-patient-dir-for-patient-name patient)
	     "visits")))))
	(visit-file-full-name
	 (frdcsa-el-concat-dir
	  (list
	   (akahige-get-patient-dir-for-patient-name patient)
	   "visits"
	   visit-file))))
  (if (file-exists-p visit-file-full-name)
   (ffap visit-file-full-name)
   (error (concat "Cannot find file " visit-file-full-name)))))

(defun akahige-visit-open-current-visit-buffer ()
 ""
 (interactive)
 (ffap (akahige-visit-current-visit-file)))

(defun akahige-visit-record-question-answer ()
 ""
 (interactive)
 (let* ((question (read-from-minibuffer "Question asked by caregiver?: "))
	(answer (read-from-minibuffer "Answer given by patient?: ")))
  (save-excursion
   (akahige-visit-open-current-visit-buffer)
   (end-of-buffer)
   (insert
    "log("
    (flp-prolog-timestamp)
    ",question(<REDACTED>,<REDACTED>,"
    (kmax-prolog-quote question)
    ","
    (kmax-prolog-quote answer)
    "))."))))

(defun akahige-visit-record-meeting ()
 ""
 (interactive)
 (kmax-not-yet-implemented))

(defun akahige-visit-open-visit-dir ()
 ""
 (interactive)
 (ffap
  (frdcsa-el-concat-dir
   (list
    (akahige-get-patient-dir-for-patient-name (akahige-get-patient-name))
    "visits"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun akahige-select-name-of-caregiver-for-patient ()
 ""
 (completing-read
  "Select name of caregiver: "
  (mapcar
   (lambda (match) (nth 2 match))
   (formalog-query
    (list 'var-Patient 'var-CareGiver)
    (list "hasHealthWorker" 'var-Patient 'var-CareGiver)
    t))))

(defun akahige-close-searches (&optional agent)
 (interactive)
 (kill-matching-buffers "Akahige Patient Chart Search for"))

(defun akahige-open-log ()
 (interactive)
 (ffap (akahige-get-filename 'log)))

(defun akahige-get-filename (item &optional agent-arg)
 (interactive)
 (let* ((agent (or agent-arg (akahige-get-patient-name))))
  (case item
   ('log
    (frdcsa-el-concat-dir
     (list
      "/var/lib/myfrdcsa/codebases/internal/akahige/data/people"
      agent
      "/logs/bioroutine.pl"))))))

(defun akahige-get-buffer (item &optional agent-arg)
 (interactive)
 (let* ((agent (or agent-arg (akahige-get-patient-name))))
  (case item
   ('timeline (get-buffer-create (concat "*Akahige Patient Chart Timeline for " agent "*")))
   ('main-chart (get-buffer
		 (frdcsa-el-concat-dir
		  (list
		   (akahige-get-patient-dir-for-patient-name agent)
		   (downcase (concat agent ".pl")))))))))

(defun akahige-render-timeline ()
 ""
 (interactive)
 (let* ((agent (akahige-get-patient-name)))
  (switch-to-buffer (akahige-get-buffer 'timeline agent))
  (insert (prin1-to-string (formalog-query (list 'var-Result) (list "generatePageFor" "dates" "admin" 'var-Result))))))

(defun akahige-patient-dir-insert ()
 ""
 (interactive)
 (insert (akahige-get-patient-dir-for-patient-name (akahige-get-patient-name))))

;; (defun akahige-visit-open-visit-file ()
;;  ""
;;  (interactive)
;;  (kmax-open-file-from-directory
;;   (frdcsa-el-concat-dir
;;    (list
;;     (akahige-get-patient-dir-for-patient-name (akahige-get-patient-name))
;;     "visits"))))

(defun akahige-fix-windows (agent)
 ""
 (interactive)
 (delete-other-windows)
 (split-window-vertically)
 (split-window-horizontally)
 (other-window 2)
 (split-window-horizontally)
 (other-window -1)
 (switch-to-buffer (akahige-get-buffer 'main-chart agent))
 (other-window 1)
 (split-window-below)
 (switch-to-buffer
  (get-buffer
   (frdcsa-el-concat-dir
    (list
     (akahige-private-get-patient-dir-for-patient-name agent)
     (downcase (concat agent ".pl"))))))
 (other-window 2)
 (split-window-below)
 (switch-to-buffer (get-buffer (akahige-get-filename 'log)))
 (other-window 2)
 (split-window-below)
 (switch-to-buffer (akahige-get-buffer 'timeline agent))
 (pop-to-buffer "*Formalog-REPL*"))

(defun akahige ()
 ""
 (interactive)
 (other-window 1)
 (let ((agent (akahige-set-patient-name)))
  (akahige-private-load-kb-about-agent nil t)
  (end-of-buffer)
  (akahige-load-kb-about-agent nil t)
  (end-of-buffer)
  (akahige-open-log)
  (end-of-buffer)
  (akahige-render-timeline)
  (end-of-buffer)
  (akahige-fix-windows agent)))

(kmax-fixme "also convert things to text that should be, like .doc, if there is no corresponding .txt")

(defun akahige-search-patients-file-names (&optional search agent)
 ""
 (interactive)
 (let* ((agent (or agent (akahige-get-patient-name)))
	(patient-dir (akahige-get-patient-dir-for-patient-name agent))
	(search (or search (read-from-minibuffer "Search?: "))))
  (see (kmax-grep-list-regexp
   (kmax-grep-list 
    (kmax-grep-v-list-regexp
     (kmax-grep-list-regexp
      (kmax-find-name-dired patient-dir "*")
      "[^~]$")
     (akahige-generate-extension-blacklist-regex))
    #'kmax-non-directory-file)
   search))))



(defun akahige-call-start ()
 ""
 (interactive)
 (ffap (akahige-call-current-call-file))
 (prolog-mode))

(defun akahige-call-identify-person-on-the-other-end-of-the-line ()
 ""
 (interactive)
 (read-from-minibuffer "Caller?: "))

(defun akahige-call-current-call-file ()
 (interactive)
 (frdcsa-el-concat-dir
  (list
   (akahige-get-patient-dir-for-patient-name (akahige-get-patient-name))
   "calls"
   (concat
    (kmax-timestamp)
    "-" ;; "-meeting-with-"
    (replace-regexp-in-string " " "-" 
     (kmax-decamelcase (akahige-call-identify-person-on-the-other-end-of-the-line)))
    ".pl"))))

(defun akahige-call-end ()
 ""
 (interactive)
 ;; (restart audio, and move audio file when call concludes)
 (kmax-not-yet-implemented))

(defun akahige-call-load-previous ()
 ""
 (interactive)
 (let* ((patient (akahige-get-patient-name))
	(call-file
	 (ido-completing-read
	  "Which call file do you wish to open?: "
	  (kmax-directory-files-no-hidden
	   (frdcsa-el-concat-dir
	    (list
	     (akahige-get-patient-dir-for-patient-name patient)
	     "calls")))))
	(call-file-full-name
	 (frdcsa-el-concat-dir
	  (list
	   (akahige-get-patient-dir-for-patient-name patient)
	   "calls"
	   call-file))))
  (if (file-exists-p call-file-full-name)
   (ffap call-file-full-name)
   (error (concat "Cannot find file " call-file-full-name)))))

(defun akahige-call-open-current-call-buffer ()
 ""
 (interactive)
 (ffap (akahige-call-current-call-file)))

(defun akahige-call-record-question-answer ()
 ""
 (interactive)
 (let* ((question (read-from-minibuffer "Question asked by caregiver?: "))
	(answer (read-from-minibuffer "Answer given by patient?: ")))
  (save-excursion
   (akahige-call-open-current-call-buffer)
   (end-of-buffer)
   (insert
    "log("
    (flp-prolog-timestamp)
    ",question(<REDACTED>,<REDACTED>,"
    (kmax-prolog-quote question)
    ","
    (kmax-prolog-quote answer)
    "))."))))

(defun akahige-call-open-call-dir ()
 ""
 (interactive)
 (ffap
  (frdcsa-el-concat-dir
   (list
    (akahige-get-patient-dir-for-patient-name (akahige-get-patient-name))
    "calls"))))

(defun akahige-edit-patient-todo (&optional tmp-agent)
 (interactive)
 ""
 (ffap
  (frdcsa-el-concat-dir
   (list
    (akahige-get-patient-dir-for-patient-name (akahige-get-patient-name))
    "to.do"))))

(add-to-list 'load-path "/var/lib/myfrdcsa/codebases/internal/akahige/frdcsa/emacs")

(require 'akahige-caregiving-instructions)

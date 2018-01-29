;; (global-set-key "\C-caat" 'akahige-communicate-to-patient)
;; (global-set-key "\C-caae" 'akahige-walk-through-exercises)
;; (global-set-key "\C-caad" 'akahige-edit-daily-report)

(defun akahige-communicate-to-patient ()
 "Function to tell patient something.  Displays messages in a
large emacs font until the user hits enter.  Logs messages to
patient in a message buffer."
 (interactive)
 (let* 
  ((filename (concat homedir "/akahige/messages/" akahige-current-day ".message.log")))
  (find-file filename)
  (delete-other-windows)
  (end-of-buffer)
  (akahige-set-font-large)
  (while
   (not
    (string= 
     (setq akahige-message (read-from-minibuffer "Message (or \"exit\") ? "))
     "exit"))
   (insert "------------------------------------------------\n")
   (insert
    (concat 
     (akahige-date)
     ": " akahige-message "\n"))
   (write-file filename)
   ))
 (akahige-set-font-small)
 (kill-buffer (current-buffer)))

;; (defun ushell ()
;;   "Function  to jump  to  a  temporary unilang  like  buffer, enter  a
;; thought, and then save it"
;;   (interactive)
;;   (let* 
;;       ((ushell-message (read-from-minibuffer "Record: "))
;;        (filename (concat homedir "/ushell/ushell.log")))
;;     ;; maybe add a type system to where it prompts you to classify the
;;     ;; thought
;;     (find-file filename)
;;     (end-of-buffer)
;;     (insert ushell-message)
;;     (insert "\n")
;;     (write-file filename)
;;     (kill-buffer (current-buffer))))


(defun akahige-walk-through-exercises ()
 ""
 ;; Implement system that walks through tasks, exercises.
 ;; During exercise recording, record the time it takes to complete each sequence.
 ;; Should gradually increase difficulty of exercises
 (interactive)
 (find-file (concat homedir "/akahige/exercises/exercises.txt"))
 (delete-other-windows)
 (split-window-vertically)
 (split-window-horizontally)
 (other-window 1)
 (find-file (concat homedir "/akahige/exercises/mistake.index"))
 (other-window 1)
 ;; use  exists-file-p to  test for existence  and then copy  the log
 ;; template file
 (find-file 
  (concat
   homedir
   "/akahige/exercises/logs/"
   akahige-current-day
   ".exercise.log"))
 )

(defun akahige-edit-daily-report ()
 "Edit the daily report"
 (interactive)
 (let* ((file (concat homedir "/akahige/daily-reports/" 
	       akahige-current-day ".daily-report.txt")))
  (if (file-exists-p file)
   (find-file file)
   ())))

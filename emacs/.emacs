(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ada-language-version (quote ada2005))
 '(blink-cursor-mode nil)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Polish")
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode nil)
 '(inhibit-startup-screen t)
 '(safe-local-variable-values
   (quote ((syntax . COMMON-LISP)
	   (Package . "CCL")
	   (Syntax . Common-lisp)
	   (Package ANSI-LOOP "COMMON-LISP")
	   (Lowercase . T)
	   (Package ARCH :use CL)
	   (Package . CCL)
	   (Package . Maxima)
	   (Base . 10)
	   (Syntax . Common-Lisp)
	   (Package . cells)
	   (Package . KERNEL)
	   (Log . code\.log))))
 '(show-paren-mode t nil (paren)))

;; ADDITIONAL LOAD PATHS
(setq load-path
      (append (list nil "~/.emacs.d/elisp")
              load-path))

;; ADDITIONAL PACKAGE LOCATIONS
(require 'package)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(package-initialize)

;; DEFAULT BROWSER
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "opera")

;; FONTS
;; (set-face-attribute 'default nil :font "DejaVu Sans Mono-10")
;; (set-face-attribute 'default nil :font "Droid Sans Mono-11")
;; (set-face-attribute 'default nil :font "Liberation Mono-10")
;; (set-face-attribute 'default nil :font "Ubuntu Mono-12")

(set-default-font "Ubuntu Mono-12")
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-12"))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; CURRENT LINE HIGHLIGHT (BEFORE ZENBURN)
(add-hook 'text-mode-hook 'turn-off-visual-line-mode)
(set-face-background 'hl-line "gray89")

;; INITIAL FRAME SIZE
(add-to-list 'default-frame-alist '(height . 39))
(add-to-list 'default-frame-alist '(width . 80))

;; ;; AUTO-COMPLETION
;; (global-set-key (kbd "M-/") 'hippie-expand)

;; BELL
;; (setq visible-bell 1)

;; TOOL-TIPS OFF
(tooltip-mode -1)

;; LINE NUMBERS
;; (global-linum-mode 1)
;; (setq linum-format "%d ")

(transient-mark-mode 1)

;; RULERS
;; NW MODE
;; (add-hook 'window-configuration-change-hook (lambda () (ruler-mode 1)))
(setq-default fill-column 80)

;; BACKGROUND COLOR (BEFORE ZENBURN)
;; M-x list-faces-display
;; Colors available:
;; http://www.geocities.com/kensanata/colors.htlm

(setq default-frame-alist
      (cons
       '(background-color  . "#DBDBDB")
       default-frame-alist))

(setq x-select-enable-clipboard t)
(setq column-number-mode t)

;; POWERLINE
(require 'powerline)

;; SCROLLING

;; (setq mouse-wheel-progressive-speed nil)
;; (setq mouse-wheel-follow-mouse 't)

;; (setq auto-save-interval 500)
;; (setq scroll-conservatively 10000)

(setq scroll-step 2)
(setq scroll-preserve-screen-position t)

(set-scroll-bar-mode 'left)
(scroll-bar-mode -1)

;; (require 'smooth-scroll)
;; (smooth-scroll-mode t)

;; TOOL BAR OFF
(tool-bar-mode 0)

;; MENU BAR OFF
(menu-bar-mode -1)

;; COLUMN NUMBERS
(column-number-mode 1)

;; ENCODING
(prefer-coding-system 'utf-8)

;; MAP THE WINDOW MANIPULATION KEYS TO META 0, 1, 2, O
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-2") 'split-window-vertically  )
(global-set-key (kbd "M-1") 'delete-other-windows     )
(global-set-key (kbd "M-0") 'delete-window            )
(global-set-key (kbd "M-o") 'other-window             )

;; ROTATING AND TRANSPOSING WINDOWS
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 0)
          (num-windows (count-windows)))
      (while  (< i (- num-windows 1))
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (% (+ i 1) num-windows)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))

(defun transpose-windows (arg)
   "Transpose the buffers shown in two windows."
   (interactive "p")
   (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
     (while (/= arg 0)
       (let ((this-win (window-buffer))
             (next-win (window-buffer (funcall selector))))
         (set-window-buffer (selected-window) next-win)
         (set-window-buffer (funcall selector) this-win)
         (select-window (funcall selector)))
       (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

(defun swap-window-positions ()         ; Stephen Gildea
   "*Swap the positions of this window and the next one."
   (interactive)
   (let ((other-window (next-window (selected-window) 'no-minibuf)))
     (let ((other-window-buffer (window-buffer other-window))
           (other-window-hscroll (window-hscroll other-window))
           (other-window-point (window-point other-window))
           (other-window-start (window-start other-window)))
       (set-window-buffer other-window (current-buffer))
       (set-window-hscroll other-window (window-hscroll (selected-window)))
       (set-window-point other-window (point))
       (set-window-start other-window (window-start (selected-window)))
       (set-window-buffer (selected-window) other-window-buffer)
       (set-window-hscroll (selected-window) other-window-hscroll)
       (set-window-point (selected-window) other-window-point)
       (set-window-start (selected-window) other-window-start))
     (select-window other-window)))

;; KILLING ALL OTHER BUFFERS
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer)
              (remove-if-not 'buffer-file-name (buffer-list)))))

;; SOME EASY KEYS
(global-set-key (kbd "M-u")   'undo             ) ; was upcase-word
(global-unset-key "\C-_"                        )
(global-set-key (kbd "M-a")   'mark-whole-buffer)
(global-set-key [C-f4]        'kill-this-buffer )
(global-set-key (kbd "C-x g") 'goto-line        )

;; DELETE TRAILING SPACES ON EVERY SAVE
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; CLOJURE via CIDER
(add-to-list 'load-path "~/.emacs.d/elisp/cider")
(require 'cider)
(add-hook 'cider-mode-hook                #'eldoc-mode)
(add-hook 'cider-repl-mode-hook           #'paredit-mode)
(setq      cider-repl-display-help-banner nil)

;; CLJ-REFACTOR
;; (require 'clj-refactor)

;; (defun my-clojure-mode-hook ()
;;     (clj-refactor-mode 1)
;;     (yas-minor-mode 1) ; for adding require/use/import statements
;;     ;; This choice of keybinding leaves cider-macroexpand-1 unbound
;;     (cljr-add-keybindings-with-prefix "C-c C-m"))

;; (add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; AC-MODE CIDER AUTO-COMPLETE
(add-to-list 'load-path "~/.emacs.d/elisp/ac-cider")
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;; CLOJURE INDENTATION (CUSTOM FORMS)

(put-clojure-indent 'clongra.oloops/forever 0)
(put-clojure-indent 'oloo/forever 0)

(put-clojure-indent 'clongra.oloops/dotimes 1)
(put-clojure-indent 'oloo/dotimes 1)

(put-clojure-indent 'clongra.oloops/doarray 1)
(put-clojure-indent 'oloo/doarray 1)

(put-clojure-indent 'clongra.oloops/for 1)
(put-clojure-indent 'oloo/for 1)

;; CLOJURE SLAMHOUND
(require 'slamhound)

;; PAREDIT
(require 'paredit)
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook       (lambda () (paredit-mode +1)))

(setq skeleton-pair t)
(setq skeleton-pair-alist
      '((?\( _ ?\))
	(?[  _ ?])
	(?{  _ ?})
	(?\" _ ?\")))

(defun autopairs-ret (arg)
  (interactive "P")
  (let (pair)
    (dolist (pair skeleton-pair-alist)
      (when (eq (char-after) (car (last pair)))
	(save-excursion (newline-and-indent))))
    (newline arg)
    (indent-according-to-mode)))

(global-set-key (kbd "RET") 'autopairs-ret)

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook
	  'override-slime-repl-bindings-with-paredit)

;; BACKUP
(setq backup-inhibited t)

;; SMART-TABS-MODE
(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python
                       'ruby 'nxml)

;; MANAGING BOOKMARKS
(global-set-key [f8] 'bookmark-set)
(global-set-key [f9] 'bookmark-jump)
(setq bookmark-save-flag 1)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; MIC-PAREN
(require 'mic-paren)
(paren-activate)
(setf paren-priority 'close)

;; C/C++ STYLE

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; PYTHON-MODE
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(setq-default py-indent-offset 2)

(add-hook 'python-mode-hook
	  (lambda ()
	    (set (make-variable-buffer-local 'beginning-of-defun-function)
		 'py-beginning-of-def-or-class)
	    (setq outline-regexp "def\\|class ")))

;; USE IDO ...
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

(global-set-key (kbd "M-<right>") 'ido-switch-buffer)
(global-set-key (kbd "M-<left>")  'ido-switch-buffer)

;; ... TOGETHER WITH SMEX
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; COLOR (M)OCCUR
(require 'color-moccur)

;; ABBREVS
(define-abbrev-table 'global-abbrev-table
  '(
    ("alpha"   "α" nil 0)
    ("beta"	"β" nil 0)
    ("gamma" "γ" nil 0)
    ("delta" "δ" nil 0)
    ("epsilon" "ε" nil 0)
    ("zeta"	"ζ" nil 0)
    ("eta"	"η" nil 0)
    ("theta" "θ" nil 0)
    ("iota"	"ι" nil 0)
    ("kappa" "κ" nil 0)
    ("lambda" "λ" nil 0)
    ("mu"	"μ" nil 0)
    ("nu"   "ν" nil 0)
    ("xi"   "ξ" nil 0)
    ("omicron" "ο" nil 0)
    ("pi"      "π" nil 0)
    ("rho"     "ρ" nil 0)
    ("sigma"   "σ" nil 0)
    ("tau"     "τ" nil 0)
    ("upsilon" "υ" nil 0)
    ("phi"     "φ" nil 0)
    ("chi"     "χ" nil 0)
    ("psi"     "ψ" nil 0)
    ("omega"   "ω" nil 0)

    ("aleph"   "א" nil 0)

    ("inf"     "∞" nil 0)

    ("forall"      "∀" nil 0)
    ("thereexists" "∃" nil 0)
    ("downtack"    "⊤" nil 0)
    ("uptack"      "⊥" nil 0)
    ("falsum"      "⊥" nil 0)
    ("righttack"   "⊢" nil 0)

    ("mathfunarrow"   "↦" nil 0)))

;; LET'S GO INTO SERVER MODE
;; (server-start)
;; (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; NXML MODE
(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))

;; UNFILL-PARAGRAPH/REGION
(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single
  spaces. This command does the reverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column 90002000))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  "Replace newline chars in region by single spaces.
  This command does the reverse of `fill-region'."
  (interactive "r")
  (let ((fill-column 90002000))
    (fill-region start end)))

;; NAVIGATING WORDS (OVERRIDES KEYS for paredit-forward-barf-sexp AND
;; paredit-forward-slurp-sexp)
(defun geosoft-forward-word ()
  ;; Move one word forward. Leave the pointer at start of word instead of
  ;; emacs default end of word. Treats _ and - as parts of word
  (interactive)
  (forward-char 1)
  (backward-word 1)
  (forward-word 2)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
	((looking-at "-") (forward-char 1) (geosoft-forward-word))

	(t (forward-char 1))))

(defun geosoft-backward-word ()
  ;; Move one word backward. Leave the pointer at start of word Treats _ and
  ;; - as parts of word
  (interactive)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (geosoft-backward-word))
	((looking-at "-") (geosoft-backward-word))

	(t (forward-char 1))))

(global-set-key (kbd "C-.")'geosoft-forward-word)
(global-set-key (kbd "C-,") 'geosoft-backward-word)

;; ISPELL
(setq ispell-program-name "aspell")
(setq ispell-dictionary "american")

;; ZENBURN COLOR THEME
;; (load-theme 'zenburn t)
;; (require 'color-theme-zenburn)
;; (color-theme-zenburn)

;; CURSOR COLOR
(set-cursor-color "IndianRed")
(add-to-list 'default-frame-alist '(cursor-color . "IndianRed"))

;; ;; MATCHING PARENS COLORS (USE WITH ZENBURN)
;; (custom-set-faces
;;  '(show-paren-match ((t (:background "CornflowerBlue" :foreground "white"))))
;;  '(show-paren-mismatch ((((class color))
;; 			 (:background "red" :foreground "white")))))

;; CUSTOM COLORS FOR SYNTAX HIGHLIGHTING
(set-face-attribute 'font-lock-comment-delimiter-face nil :foreground "#8080C9")
(set-face-attribute 'font-lock-comment-face           nil :foreground "#8080C9")
(set-face-attribute 'font-lock-doc-face               nil :foreground "#8080C9" :weight 'bold)
(set-face-attribute 'font-lock-keyword-face           nil :foreground "#0000FF" :weight 'bold)
(set-face-attribute 'font-lock-string-face            nil :foreground "#6100FF")
(set-face-attribute 'font-lock-type-face              nil :foreground "#008289")
(set-face-attribute 'font-lock-function-name-face     nil :foreground "#363636" :weight 'bold)
(set-face-attribute 'font-lock-variable-name-face     nil :foreground "#363636" :weight 'bold)

;; CUA MODE
(cua-mode)

;; DIRED
(put 'dired-find-alternate-file 'disabled nil)
;; (dired "~/")

;; WHITESPACE MODE
(setq whitespace-style
      (quote (spaces tabs newline space-mark tab-mark newline-mark)))

;; make whitespace-mode use “¶” for newline and “▷” for tab.
;; together with the rest of its defaults
(setq whitespace-display-mappings
      '(
	(space-mark 32 [183] [46])	; normal space, ·
	(space-mark 160 [164] [95])
	(space-mark 2208 [2212] [95])
	(space-mark 2336 [2340] [95])
	(space-mark 3616 [3620] [95])
	(space-mark 3872 [3876] [95])
	(newline-mark 10 [182 10])	; newlne, ¶
	(tab-mark 9 [9655 9] [92 9])	; tab, ▷
	))


;; AUTO-COMPLETE MODE
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode)
(setq ac-auto-start 2)      ; Start auto-completion after 2 characters of a word
(setq ac-ignore-case nil)   ; Case sensitivity is important when finding matches

;; HASKELL MODE
;; (add-to-list 'load-path "~/.emacs.d/elisp/haskell-mode/")
;; (load "haskell-mode-autoloads.el")

(require 'haskell-mode)

(setq haskell-process-args-stack-ghci '("--ghci-options=-ferror-spans"))

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

;; (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

(add-to-list 'completion-ignored-extensions ".hi")

(add-to-list 'ac-modes 'haskell-mode)
(add-hook 'haskell-mode-hook 'auto-complete-mode)

(require 'hs-lint)    ;; https://gist.github.com/1241059

(custom-set-variables
 '(haskell-process-log t)
 ;; '(haskell-process-type (quote cabal-repl)) ;; use cabal repl instead of ghci
 '(haskell-process-type (quote stack-ghci)) ;; use stack ghci
 '(inferior-haskell-wait-and-jump t))

(require 'hi2)
(add-hook 'haskell-mode-hook 'turn-on-hi2)

;; ELM MODE ...
(require  'elm-mode)
(add-hook 'elm-mode-hook 'turn-on-hi2)

;; ... WITH FLYCHECK
;; (require  'flycheck-elm)
;; (add-hook 'flycheck-mode-hook 'flycheck-elm-setup)
;; (with-eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

;; TURN ON ABBREV MODE GLOBALLY
(setq default-abbrev-mode t)

;; PHP CONFIGURATION
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; JS MODE CONFIGURATION
(setq js-indent-level 2)

;; SHUFFLING LINES
(require 'shuffle-lines)

;; MISC. INSERTING

(defun insert-time ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d-%R")))

(defun insert-ISO ()
  (interactive)
  (insert (format-time-string "%Y%m%d")))

(defun insert-date-verbose ()
  (interactive)
  (insert (format-time-string
	   "It is now second %S of minute %M of hour %H (%l %p) on day %d of %B in year %Y in time zone %Z. It is %A, and day %j, in week %U, of %Y. ")))

;; DESCRIBING FACES
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

;; CUPS PRINTER CONFIG.

(setq lpr-page-header-switches (quote ("-o6")))

;; ESS
;; (require 'ess-site)

;; (add-hook 'ess-mode-hook
;;           (lambda ()
;;             ;;                                 DEF GNU BSD K&R C++
;;             ;; ess-indent-level                  2   2   8   5   4
;;             ;; ess-continued-statement-offset    2   2   8   5   4
;;             ;; ess-brace-offset                  0   0  -8  -5  -4
;;             ;; ess-arg-function-offset           2   4   0   0   0
;;             ;; ess-expression-offset             4   2   8   5   4
;;             ;; ess-else-offset                   0   0   0   0   0
;;             ;; ess-close-brace-offset            0   0   0   0   0
;;             (ess-set-style 'GNU 'quiet)

;;             (setq ess-arg-function-offset nil)))

(add-hook 'perl-mode-hook
      (lambda () (setq perl-indent-level 2)))


;; HIGHLIGHTING SYMBOLS AT POINT
(require 'highlight-symbol)
(require 'highlight)
(global-set-key [f1] 'highlight-symbol-at-point)

;; (global-set-key [(control f3)] 'highlight-symbol)
;; (global-set-key [f3] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;; GIT GUTTER
(require 'git-gutter)
(global-git-gutter-mode t)
(custom-set-variables '(git-gutter:lighter " GG"))

(set-face-foreground 'git-gutter:modified "BlueViolet")
(set-face-foreground 'git-gutter:added    "ForestGreen")
(set-face-foreground 'git-gutter:deleted  "red")

;; ANTLR MODE
(push '("\\.g4\\'" . antlr-v4-mode) auto-mode-alist)
(autoload 'antlr-v4-mode "antlr-mode" nil t)

;; TRAMP
(require 'tramp)

;; ESS (Emacs Speaks Statistics)
(add-to-list 'load-path "~/.emacs.d/elisp/ess/lisp/")
(require 'ess-site)
;; (setq ess-indent-level 2)
;; (setq ess-arg-function-offset 4)
;; (setq ess-else-offset  2)

(add-hook 'ess-mode-hook
          (lambda ()
            ;;                                 DEF GNU BSD K&R C++
            ;; ess-indent-level                  2   2   8   5   4
            ;; ess-continued-statement-offset    2   2   8   5   4
            ;; ess-brace-offset                  0   0  -8  -5  -4
            ;; ess-arg-function-offset           2   4   0   0   0
            ;; ess-expression-offset             4   2   8   5   4
            ;; ess-else-offset                   0   0   0   0   0
            ;; ess-close-brace-offset            0   0   0   0   0
            (ess-set-style 'GNU 'quiet)
            (setq ess-arg-function-offset nil)))

;; CUCUMBER FEATURE MODE
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

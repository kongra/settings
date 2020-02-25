;; GC
;; https://github.com/Fanael/init.el/blob/master/init.el
(setq gc-cons-threshold (* 16 1024 1024))
(setq gc-cons-percentage 0.3)

(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold (* 16 1024 1024)))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook  #'my-minibuffer-exit-hook)

(setq garbage-collection-messages t)

;; PACKAGES INITIALIZATION
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; ADDITIONAL LOAD PATHS
(setq load-path
      (append (list nil "~/.emacs.d/elisp")
              load-path))

;; USE-PACKAGE
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; WHICH-KEY
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; SOME ESSENTIAL KEYS
(global-set-key (kbd "M-u") 'undo) ; was upcase-word
(global-unset-key "\C-_")
(global-set-key (kbd "M-a") 'mark-whole-buffer)
(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(defalias 'yes-or-no-p 'y-or-n-p)

;; UNDO LIMITS
(setq undo-limit        (* 16 1024 1024))
(setq undo-strong-limit (* 24 1024 1024))
(setq undo-outer-limit  (* 64 1024 1024))

;; DEFAULT WEB BROWSER
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/firefox")

;; ENCODING
(prefer-coding-system                   'utf-8     )
(set-language-environment               "UTF-8"    )
(setq locale-coding-system              'utf-8     )
(set-selection-coding-system            'utf-8     )
(setq-default buffer-file-coding-system 'utf-8-unix)

;; CUA MODE
(cua-mode)

;; INHIBIT BACKUP
(setq backup-inhibited t)

;; DELETE TRAILING SPACES ON EVERY SAVE
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; AUTO REVERT MODE (RELOAD ON FILE CHANGE)
(global-auto-revert-mode t)

;; CLIPBOARD
(setq x-select-enable-clipboard t)

;; OPTIMIZE UP/DOWN LAGS
(setq auto-window-vscroll nil)

;; MOVING LINES UP/DOWN
;; https://www.emacswiki.org/emacs/MoveLine
;;
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd   "M-<up>")   'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; JUMPING N LINES UP/DOWN
(defun next-line-n (n)
  (interactive "nLines down: ")
  (forward-line n))

(defun previous-line-n (n)
  (interactive "nLines up: ")
  (forward-line (- n)))

(global-set-key (kbd "C-n")     'next-line-n)
(global-set-key (kbd "C-p") 'previous-line-n)

;; SUBWORD FOR M-f/M-b (forward-word/backward-word)
(global-subword-mode 1)

;; SAVE ALL BUFFERS
(defun save-all-buffs () (interactive) (save-some-buffers t))
(global-set-key (kbd "C-x C-a") 'save-all-buffs)

;; NO STARTUP SCREEN
(setq inhibit-startup-screen t)

;; INITIAL FRAME SIZE
(add-to-list 'default-frame-alist '(height . 39))
(add-to-list 'default-frame-alist '(width .  80))

;; MINIBUF HEIGHT
(setq max-mini-window-height 0.33)

;; BARS OFF
(tool-bar-mode -1)
(menu-bar-mode -1)

;; FONTS
(set-default-font "Ubuntu Mono-12")
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-12"))

;; FONT LOCK MODE ALWAYS
(global-font-lock-mode 1)

;; +/- FONT SIZE
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; TOOL-TIPS OFF
(tooltip-mode -1)

;; SCROLLING
(scroll-bar-mode                           -1)
;; (setq scroll-step                        2)
;; (setq scroll-margin                      3)

(setq mouse-wheel-progressive-speed       nil)
(setq scroll-conservatively            100000)
(setq scroll-preserve-screen-position 'always)

;; SPACEMACS THEME
(use-package spacemacs-theme
  :ensure t
  :defer  t
  :init (require 'spacemacs-dark-theme))

;; CURSOR
(set-cursor-color "#eead0e")
(blink-cursor-mode        0)

;; (use-package beacon
;;   :ensure t
;;   :init
;;   (progn (beacon-mode 1)))

;; SHOW COLUMN NUMBERS
(setq column-number-mode t)

;; SHOW LINE NUMBERS
(setq line-number-mode t)
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))

;; (setq display-line-numbers-type 'relative)
(set-face-background 'line-number              "#292b2e")
(set-face-background 'line-number-current-line "#222226")

;; TRANSIENT-MARK MODE
(transient-mark-mode 1)

;; FILL COLUMN
(setq-default fill-column 80)

(use-package fill-column-indicator
  :ensure t)

(setq fci-rule-width 1)
(setq fci-rule-color "#404347")

;; MAP THE WINDOW MANIPULATION KEYS TO META 0, 1, 2, O
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-2") 'split-window-vertically  )
(global-set-key (kbd "M-1") 'delete-other-windows     )
(global-set-key (kbd "M-0") 'delete-window            )
(global-set-key (kbd "M-o") 'other-window             )

;; SWAP WINDOW POSITIONS
(defun swap-window-positions () ; Stephen Gildea
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

;; GIT-GUTTER
(use-package git-gutter
  :ensure t
  :init
  (progn (setq git-gutter:lighter " GG")
         (global-git-gutter-mode t)
         (set-face-foreground 'git-gutter:modified "BlueViolet")
         (set-face-foreground 'git-gutter:added    "ForestGreen")
         (set-face-foreground 'git-gutter:deleted  "red")))

;; MAGIT
(use-package magit
  :ensure t)

;; COMPANY
(use-package company
  :ensure t
  :init (progn (setq company-idle-delay                      0)
               (setq company-minimum-prefix-length           2)
               (add-hook 'after-init-hook 'global-company-mode)))

;; POWERLINE
;; (add-to-list 'load-path "~/.emacs.d/elisp/powerline")
;; (require 'powerline)
;; (powerline-center-theme)

;; IDO VERTICAL WITH SMEX
(use-package ido-vertical-mode
  :ensure t
  :init
  (progn
    (setq ido-enable-flex-matching      t) ;; enable fuzzy matching
    ;; (setq ido-enable-flex-matching nil)
    (setq ido-create-new-buffer   'always)
    (setq ido-everywhere                t)
    (setq ido-vertical-show-count       t)
    (ido-mode                           1)
    (ido-vertical-mode                  1)))

(use-package smex
  :ensure t
  :init
  (progn
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

;; IVY/SWIPER/COUNSEL
(defun ivy-with-thing-at-point (cmd)
  (let ((ivy-initial-inputs-alist
         (list
          (cons cmd (thing-at-point 'symbol)))))
    (funcall cmd)))

(defun counsel-rg-thing-at-point ()
  (interactive)
  (ivy-with-thing-at-point 'counsel-rg))

(setq counsel-grep-base-command
 "rg -i -M 120 --no-heading --line-number --color never '%s' %s")

(use-package swiper
  :ensure t
  :init (global-set-key "\C-s" 'swiper-isearch-thing-at-point))

(use-package ivy
  :ensure t)

(use-package counsel
  :ensure t
  :init (global-set-key "\C-f" 'counsel-rg-thing-at-point))

;; PAREDIT
(use-package paredit
  :ensure t
  :init
  (progn (add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))
         (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
         (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
         (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
         (add-hook 'slime-repl-mode-hook       (lambda () (paredit-mode +1)))))

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

;; RAINBOW DELIMITERS
(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; HIGHLIGHT MATCHING PARENS
(use-package mic-paren
  :ensure t
  :init
  (progn (paren-activate)
         (setf paren-priority 'close)))

;; MANAGING BOOKMARKS
(global-set-key [f8] 'bookmark-set)
(global-set-key [f9] 'bookmark-jump)
(setq bookmark-save-flag 1)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; COLOR (M)OCCUR
(use-package color-moccur
  :ensure t)

;; ABBREVS
(define-abbrev-table 'global-abbrev-table
  '(
    ("alpha"          "α" nil 0)
    ("beta"           "β" nil 0)
    ("gamma"          "γ" nil 0)
    ("delta"          "δ" nil 0)
    ("epsilon"        "ε" nil 0)
    ("zeta"           "ζ" nil 0)
    ("eta"            "η" nil 0)
    ("theta"          "θ" nil 0)
    ("iota"           "ι" nil 0)
    ("kappa"          "κ" nil 0)
    ("lambda"         "λ" nil 0)
    ("mu"             "μ" nil 0)
    ("nu"             "ν" nil 0)
    ("xi"             "ξ" nil 0)
    ("omicron"        "ο" nil 0)
    ("pi"             "π" nil 0)
    ("rho"            "ρ" nil 0)
    ("sigma"          "σ" nil 0)
    ("tau"            "τ" nil 0)
    ("upsilon"        "υ" nil 0)
    ("phi"            "φ" nil 0)
    ("chi"            "χ" nil 0)
    ("psi"            "ψ" nil 0)
    ("omega"          "ω" nil 0)
    ("aleph"          "א" nil 0)
    ("inf"            "∞" nil 0)
    ("forall"         "∀" nil 0)
    ("thereexists"    "∃" nil 0)
    ("downtack"       "⊤" nil 0)
    ("uptack"         "⊥" nil 0)
    ("falsum"         "⊥" nil 0)
    ("righttack"      "⊢" nil 0)
    ("mathfunarrow"   "↦" nil 0)))

;; (setq-default abbrev-mode t) ;; ABBREVS ALWAYS ON

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

;; KILL WHOLE WORD (BETTER <C-delete>)
(defun kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))

(global-set-key (kbd "<C-delete>") 'kill-whole-word)

;; ISPELL
(setq ispell-program-name "aspell")
(setq ispell-dictionary "american")

;; WHITESPACE MODE
(setq whitespace-style
      (quote (spaces tabs newline space-mark tab-mark newline-mark)))

;; make whitespace-mode use “¶” for newline and “▷” for tab.
;; together with the rest of its defaults
(setq whitespace-display-mappings
      '(
        (space-mark   32 [183]    [46])   ; normal space, ·
        (space-mark  160 [164]    [95])
        (space-mark 2208 [2212]   [95])
        (space-mark 2336 [2340]   [95])
        (space-mark 3616 [3620]   [95])
        (space-mark 3872 [3876]   [95])
        (newline-mark 10 [182 10])        ; newlne, ¶
        (tab-mark      9 [9655 9] [92 9]) ; tab,
        ))

;; TIMESTAMP STRING
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

;; HIGHLIGHT SYMBOL AT POINT
(use-package highlight-symbol
  :ensure t)

(use-package highlight
  :ensure t)

(global-set-key [f1] 'highlight-symbol-at-point)

;; DASHBOARD
;; (use-package page-break-lines :ensure t)
;; (use-package dashboard
;;   :ensure t
;;   :config
;;   (dashboard-setup-startup-hook))

;; DIRED+
(require 'dired+)

;; C/C++
(setq-default indent-tabs-mode  nil)
(setq         c-basic-offset      2)
(setq         c-default-style "gnu")

;; JavaScript
(setq js-indent-level 2)

;; CLOJURE/CIDER
(use-package clojure-mode
  :ensure t
  :init
  (progn
    (setq clojure-indent-style 'always-indent)))

(use-package cider
  :ensure t
  :init
  (progn
    (add-hook 'cider-repl-mode-hook #'paredit-mode)
    (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
    (add-hook 'cider-mode-hook      #'eldoc-mode)
    (add-hook 'cider-mode-hook      #'cider-company-enable-fuzzy-completion)

    (setq cider-repl-display-help-banner nil)

    ;; Let's disable Cider's fading out reader's conditionals - we need this
    ;; cause we work with cljc files:
    (setq cider-font-lock-reader-conditionals nil)))

;; ESS (Emacs Speaks Statistics)
(add-hook
 'find-file-hook
 (lambda ()
   (when (string-match (file-name-extension buffer-file-name) "[r|R]$")
     (ess-set-style 'RStudio))))

(setq inferior-ess-r-program "/usr/bin/R")
(remove-hook 'flymake-diagnostic-functions
             'flymake-proc-legacy-flymake)

(use-package ess
  :ensure t
  :init
  (progn
    (global-set-key (kbd "M-n") 'ess-eval-line-and-step)
    (global-set-key (kbd "M-m") (lambda () (interactive) (insert "%>% ")))
    (global-set-key (kbd "M--") (lambda () (interactive) (insert "<- " )))))

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

;; PYTHON MODE
(add-hook
 'python-mode-hook

 '(lambda ()
    (setq python-indent 2)
    ;; (when (executable-find "ipython")
    ;;   (setq python-shell-interpreter "ipython"))
    ))

;; RAINBOW MODE
(use-package rainbow-mode
  :ensure t
  :init (progn (add-hook 'prog-mode-hook #'rainbow-mode)
               (add-hook 'org-mode-hook  #'rainbow-mode)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (color-moccur spacemacs-theme which-key use-package))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(show-paren-match ((t (:background "CornflowerBlue" :foreground "white"))))
 '(show-paren-mismatch ((((class color)) (:background "red" :foreground "white")))))

(put 'dired-find-alternate-file 'disabled nil)

;; COMPLETELY DISABLE BOLD FONTS
(defun remap-faces-default-attributes ()
   (let ((family (face-attribute 'default :family))
         (height (face-attribute 'default :height)))
     (mapcar (lambda (face)
              (face-remap-add-relative
               face :family family :weight 'normal :height height))
          (face-list))))

(when (display-graphic-p)
   (add-hook 'minibuffer-setup-hook 'remap-faces-default-attributes)
   (add-hook 'change-major-mode-after-body-hook 'remap-faces-default-attributes))

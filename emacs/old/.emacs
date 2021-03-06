(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Polish")
 '(git-gutter:lighter " GG")
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode nil)
 '(haskell-process-log   t)
 '(haskell-process-type (quote stack-ghci))
 '(inferior-haskell-wait-and-jump t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (swiper ido-vertical-mode clojure-mode-extra-font-locking cider magit zenburn-theme spinner smex smart-tabs-mode seq queue pkg-info paredit hi2 haskell-mode git-gutter feature-mode elm-mode)))
 '(safe-local-variable-values
   (quote
    ((syntax . COMMON-LISP)
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
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; AUTO REVERT MODE (RELOAD ON CHANGE)
(global-auto-revert-mode t)

;; DEFAULT BROWSER
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "opera")

;; FONTS
(set-default-font "Ubuntu Mono-12")
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-12"))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; SPACEMACS THEME
(add-to-list 'load-path "~/.emacs.d/elisp/spacemacs-theme")
(require 'spacemacs-dark-theme)

;; CUSTOM CURSOR/LINE COLOR
(set-cursor-color             "#eead0e") ;; orange
(set-face-background 'hl-line "#212026") ;; grey

;; POWERLINE
;; (add-to-list 'load-path "~/.emacs.d/elisp/powerline")
;; (require 'powerline)
;; (powerline-center-theme)

;; MATCHING PARENS COLORS (USE WITH ZENBURN AND SPACEMACS)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(show-paren-match ((t (:background "CornflowerBlue" :foreground "white"))))
 '(show-paren-mismatch ((((class color)) (:background "red" :foreground "white")))))

;; RAINBOW DELIMITERS
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; INITIAL FRAME SIZE
(add-to-list 'default-frame-alist '(height . 39))
(add-to-list 'default-frame-alist '(width .  80))

;; COMPANY AUTO COMPLETE
(require                               'company)
(setq company-idle-delay                      0)
(setq company-minimum-prefix-length           2)
(add-hook 'after-init-hook 'global-company-mode)

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

(setq x-select-enable-clipboard t)
(setq column-number-mode t)

;; SCROLLING
(setq scroll-step 2)
(setq scroll-preserve-screen-position t)

(set-scroll-bar-mode 'left)
(scroll-bar-mode -1)

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
(global-set-key (kbd "C-x g") 'goto-line        )

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

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; DELETE TRAILING SPACES ON EVERY SAVE
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; SAVE ALL BUFFERS
(defun save-all-buffs () (interactive) (save-some-buffers t))
(global-set-key (kbd "C-x C-a") 'save-all-buffs)

;; CLOJURE via CIDER
(require 'cider)
(add-hook 'cider-mode-hook                  #'eldoc-mode)
(add-hook 'cider-repl-mode-hook           #'paredit-mode)
(setq      cider-repl-display-help-banner            nil)

;; Cider auto-completion:
(add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
(add-hook 'cider-mode-hook      #'cider-company-enable-fuzzy-completion)

;; Let's disable Cider's fading out reader's conditionals - we need this cause
;; we work with cljc files:
(setq cider-font-lock-reader-conditionals nil)

;; PAREDIT
(require 'paredit)
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

(add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
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
(setq-default indent-tabs-mode  nil)
(setq         c-basic-offset      2)
(setq         c-default-style "gnu")

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

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

;; RUST MODE
(add-to-list 'load-path "~/.emacs.d/elisp/rust-mode")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; UPDATED ada-mode
(add-to-list 'load-path "~/.emacs.d/elisp/ada-mode")
;; (require 'ada-mode)

;; IDO ...
(setq ido-enable-flex-matching      t) ;; enable fuzzy matching
;; (setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer   'always)
(setq ido-everywhere                t)
(setq ido-vertical-show-count       t)
(require           'ido-vertical-mode)
(ido-mode                           1)
(ido-vertical-mode                  1)

;; ... TOGETHER WITH SMEX
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; SEARCHING
(require 'swiper)
(require    'ivy)

(defun ivy-with-thing-at-point (cmd)
  (let ((ivy-initial-inputs-alist
         (list
          (cons cmd (thing-at-point 'symbol)))))
    (funcall cmd)))

(defun counsel-rg-thing-at-point ()
  (interactive)
  (ivy-with-thing-at-point 'counsel-rg))

(global-set-key "\C-s" 'swiper-isearch-thing-at-point)
(global-set-key "\C-f"     'counsel-rg-thing-at-point)

;; MINIBUF HEIGHT
(setq max-mini-window-height 0.33)

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

;; HASKELL MODE
(require 'haskell-mode)
(setq haskell-process-args-stack-ghci '("--ghci-options=-ferror-spans -fshow-loaded-modules"))
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-to-list 'completion-ignored-extensions ".hi")
(add-hook 'haskell-mode-hook 'auto-complete-mode)

(require 'hs-lint)    ;; https://gist.github.com/1241059

(require 'hi2)
(add-hook 'haskell-mode-hook 'turn-on-hi2)

;; ELM MODE ...
(require  'elm-mode)
(add-hook 'elm-mode-hook 'turn-on-hi2)

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
;; (global-set-key (kbd "M-m") 'ess-eval-line-and-step)
;; (global-set-key (kbd "M--") (lambda () (interactive) (insert "<- ")))
;; (global-set-key (kbd "M-m") 'ess-eval-line-and-step)
(add-hook 'find-file-hook 'my-R-style-hook)
(defun my-R-style-hook ()
  (when (string-match (file-name-extension buffer-file-name) "[r|R]$")
    (ess-set-style 'RStudio)))

(global-set-key [f7] 'ess-eval-line-and-step)
(global-set-key (kbd "C-n") (lambda () (interactive) (insert "%>% ")))

(add-hook 'perl-mode-hook
      (lambda () (setq perl-indent-level 2)))

;; HIGHLIGHTING SYMBOLS AT POINT
(require 'highlight-symbol)
(require 'highlight)
(global-set-key [f1] 'highlight-symbol-at-point)

;; GIT GUTTER
(require 'git-gutter)
(global-git-gutter-mode t)

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

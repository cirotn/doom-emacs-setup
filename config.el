;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ciro Nishiguchi"
      user-mail-address "cironishiguchi@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dark+)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Start window maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Show trailing whitespace
(setq-default show-trailing-whitespace t)
(add-hook 'minibuffer-setup-hook (lambda() (setq show-trailing-whitespace nil)))
(add-hook 'inferior-python-mode-hook (lambda() (setq show-trailing-whitespace nil)))
(add-hook 'comint-mode-hook (lambda() (setq show-trailing-whitespace nil)))
(add-hook 'compilation-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'eshell-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil)))

;; Ctrl-C, Ctrl-V
(cua-mode +1)

;; No confirmation when quitting
(setq confirm-kill-emacs nil)

;; Make frame title the full file path
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name)) "%b"))))

;; Use cygwin find rather than Windows find
(if (string-equal system-type "windows-nt") (setq find-program "C:\\cygwin\\bin\\find.exe"))

;; Let avy find matches across windows
(setq avy-all-windows t)

;; Disable smartparens
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(after! evil
  ;; Make underscores part of a word
  (add-hook! 'python-mode-hook (modify-syntax-entry ?_ "w"))
  (add-hook! 'c++-mode-hook (modify-syntax-entry ?_ "w"))
  (add-hook! 'c-mode-hook (modify-syntax-entry ?_ "w"))
  (add-hook! 'makefile-mode-hook (modify-syntax-entry ?_ "w"))
  (add-hook! 'rustic-mode-hook (modify-syntax-entry ?_ "w"))
  ;; Make hyphen part of a word in lisp
  (add-hook! 'emacs-lisp-mode-hook (modify-syntax-entry ?- "w"))
  ;; Make asterisk not include \\<...\\>
  (define-key evil-normal-state-map (kbd "*") 'evil-ex-search-unbounded-word-forward)
  )

(after! ivy
  ;; Adds recent files to buffer list
  (setq ivy-use-virtual-buffers t)
  ;; Configure display of number of options
  (setq ivy-count-format "(%d/%d) "))

(after! clang-format
  (setq clang-format-executable "clang-format-6.0")
  )

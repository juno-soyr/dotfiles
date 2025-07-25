;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Haile Gaspar"
      user-mail-address "h.gaspar@soyrscave.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  (setq org-directory "~/org/")

  (setq org-default-notes-file (concat org-directory "/notes.org"))

  (setq org-agenda-custom-commands
        '(("d" "Daily Agenda"
           ((agenda "" ((org-agenda-span 'week)
                        (org-deadline-warning-days 7)
                        (org-agenda-use-time-grid t)
                        ))
            (todo "TODO")
            (todo "STARTED")
            (todo "NEXT")
            (todo "HOLD")
            (tags-todo "+PRIORITY=\"A\""
                       ((org-agenda-overriding-header "High Priority Tasks")))

            ))

        )
   )
  (setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "STARTED(s)" "|" "DONE(d)" "|" "Cancelled(c)")))
  (setq org-roam-directory "~/org")
  (setq org-roam-db-autosync-mode t)
  (use-package! org-fragtog
    :custom
    (org-startup-with-latex-preview t)
    :hook
    (org-mode . org-fragtog-mode)
    :custom
    (org-format-latex-options
     (plist-put org-format-latex-options :scale 2.0)
     (plist-put org-format-latex-options :foreground 'auto)
     (plist-put org-format-latex-options :background 'auto))
    )

  )
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t)
)
;; Org alert stuff --------------
(use-package! org-alert
  :commands org-alert-check org-alert-enable org-alert-disable org-alert-time-match-string)

(after! org-alert
  (setq org-alert-interval 300
      org-alert-notify-cutoff 30
      org-alert-notify-after-event-cutoff 10)
  (setq org-alert-match-string "\\(?:SCHEDULED\\|DEADLINE\\):.*<.*\\([0-9]\\{2\\}:[0-9]\\{2\\}\\).*>")
  (setq alert-default-style 'libnotify)
)

(setq-default line-spacing 3)
(defun connect-vps ()
  (interactive)
  (dired "/ssh:haile@157.180.41.130#10000:/"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; LATEX config
(setq +latex-viewers '(pdf-tools))
(setq tidal-boot-script-path "~/Documents/Music/BootTidal.hs")
;; Only for debugging
;; (setq debug-on-error t)

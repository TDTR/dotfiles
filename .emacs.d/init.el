;;; THIS IS A BASIC INIT.EL FOR TORUTSUDA 2011/06/29
;;; UPDATE 2011/12/03 -> cursor & init flame size

(set-language-environment 'Japanese)

;;;　ロードパスの追加
(setq load-path (append
		 '("~/.emacs.d")
		 load-path))

;;;localeに合わせた環境の設定
(set-locale-environment nil)

;;;tool-bar消えろ
(tool-bar-mode 0)

;;; 初期フレームの設定
(setq initial-frame-alist
      (append
       '((top    . 22)
	 (left   . 650)
	 (width  . 125)
	 (height . 65))
       initial-frame-alist))
(setq default-frame-alist
      (append
       '((width    . 81)
	 (height   . 44))
       default-frame-alist))

;;; キーバインド
(define-key global-map (kbd "C-z") 'undo) ;undo
(define-key global-map (kbd "M-C-g") 'grep) ;grep
(define-key global-map (kbd "C-c i") 'indent-region) ;indent
(define-key global-map (kbd "C-c C-i") 'hippie-expand); 補完
(define-key global-map (kbd "C-c ;") 'comment-dwim);comment out
(define-key global-map (kbd "C-[ M-C-g") 'goto-line) ;指定行へ移動

;;ウィンドウ移動
;;;次のウィンドウへ
(define-key global-map (kbd "C-M-n") 'next-multiframe-window)
;;;前のウィンドウへ
(define-key global-map (kbd "C-M-p") 'previous-multiframe-window)

;;; 再帰的grep
(require 'grep)
(setq grep-command-before-query "grep -nH -r -e ")
(defun grep-default-command ()
  (if current-prefix-arg
      (let ((grep-command-before-target
             (concat grep-command-before-query
                     (shell-quote-argument (grep-tag-default)))))
        (cons (if buffer-file-name
                  (concat grep-command-before-target
                          " *."
                          (file-name-extension buffer-file-name))
                (concat grep-command-before-target " ."))
              (+ (length grep-command-before-target) 1)))
    (car grep-command)))
(setq grep-command (cons (concat grep-command-before-query " .")
                         (+ (length grep-command-before-query) 1)))

;;画像表示
(auto-image-file-mode t)

;;;カーソルの点滅を止める
(blink-cursor-mode 0)

;;; 対応する括弧を光らせる。
(show-paren-mode 1)
;;; ウィンドウ内に収まらないときだけ括弧内も光らせる。
(setq show-paren-style 'mixed)

;;; 最終行に必ず一行挿入する
(setq require-final-newline t)

;;; バックアップファイルを作らない
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq delete-auto-save-files t)

;; 行番号を表示
(line-number-mode t)
;; カーソル位置の指定
(column-number-mode t)
;;; 現在の行を目立たせる
;;;(global-hl-line-mode)

;;行
;;;行の先頭でC-kを一回押すだけで行全体を消去する
(setq kill-whole-line t)

;;;最終行に必ず一行挿入する
(setq require-final-newline t)

;;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)


;;起動画面消えろ
(setq inhibit-startup-message t)
;;C-k は改行も消える
(setq kill-whole-line t)

;;タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%F:%b")
;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;;; 部分一致の補完機能を使う
;;; p-bでprint-bufferとか
;;;(partial-completion-mode t)

;;; ファイル名が重複していたらディレクトリ名を追加する。
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 2012-03-15
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;; 関数名
(which-function-mode 1)


;;; 標準Elispの設定
;;;(load "config/builtins")

;;; 非標準Elispの設定
;;;(load "config/packages")

;;フォントの設定
;;01234567890123456789
;;あいうえおかきくけこ
;;1920 * 1200 もにた
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs)
  (set-face-attribute 'default nil
		    :family "Ricty"
		    ;:family "RictyDiscord"
		    ;:family "Sazanami Gothic"
	      	    ;:family "Monaco"
       		    ;height 110
		    :height 120
		    )
  ;; Rictyfontで豆腐が大量発生する悲しみから逃れる復活の呪文
  (when (x-list-fonts "Ricty")
    (let* ((size 14)
	   (asciifont "Ricty")
	   (jpfont "Ricty")
	   (h (* size 10))
	   (fontspec)
	   (jp-fontspec))
      (set-face-attribute 'default nil :family asciifont :height h)
      (setq fontspec (font-spec :family asciifont))
      (setq jp-fontspec (font-spec :family jpfont))
      (set-fontset-font nil 'japanese-jisx0208 jp-fontspec)
      (set-fontset-font nil 'japanese-jisx0212 jp-fontspec)
      (set-fontset-font nil 'japanese-jisx0213-1 jp-fontspec)
      (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
      (set-fontset-font nil '(#x0080 . #x024F) fontspec)
      (set-fontset-font nil '(#x0370 . #x03FF) fontspec)))
)
;; linux の場合
(when (eq system-type 'gnu/linux)
    (set-face-attribute 'default nil
		    :family "Ricty"
      		    :height 120
		    )
    )


;; Pythonテンプレート auto-insert
(setq auto-insert-directory "~/.emacs.d/template/")
(auto-insert-mode 1)
(setq auto-insert-query nil)
;;(define-auto-insert "\\.py\\'" "template.py")
;;(add-hook 'find-file-hooks 'auto-insert)

;;auto-complete設定
(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;;python
;;(add-to-list 'load-path "~/.emacs.d/elisp/")
(require 'python-mode)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq ipython-command "/usr/local/bin/ipython")
(require 'ipython)
(setq auto-insert-alist
      '((python-mode . "template.py")))

;;yatex
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "platex"
	  dvi2-command "open -a Preview")
(setq YaTeX-kanji-code 4)
(setq YaTeX-use-hilit10 nil
      YaTeX-use-font-lock t)

;;dictionary
;; 2011-03-09
(setq-default flyspell-mode t)
(setq ispell-dictionary "american")

;;text
;; 2012-03-18
;; text-modeでバッファーを開いたときに行う設定
(add-hook
 'text-mode-hook
 (lambda ()
   ;; 自動で長過ぎる行を分割する
   (auto-fill-mode 1)))

;;auto-install
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(auto-install-compatibility-setup)

;;; Anything
(let ((original-browse-url-browser-function browse-url-browser-function))
;;  (el-get 'sync '(anything))
  (require 'anything-startup)
  (require 'anything-config)
  (anything-set-anything-command-map-prefix-key
   'anything-command-map-prefix-key "C-c C-<SPC>")
  (define-key global-map (kbd "C-x b") 'anything-for-files)
  (define-key global-map (kbd "C-x g") 'anything-imenu) ; experimental
  (define-key global-map (kbd "M-y") 'anything-show-kill-ring)
  (define-key anything-map (kbd "C-z") nil)
  (define-key anything-map (kbd "C-l") 'anything-execute-persistent-action)
  (define-key anything-map (kbd "C-o") nil)
  (define-key anything-map (kbd "C-M-n") 'anything-next-source)
  (define-key anything-map (kbd "C-M-p") 'anything-previous-source)
  (setq browse-url-browser-function original-browse-url-browser-function))

;; anything-bib
(require 'anything-bibtex)

;; key-comboで幸せになる 
;; http://d.hatena.ne.jp/uk-ar/20111208/1322572618%3E
(require 'key-combo)
(key-combo-load-default)
(key-combo-define-global (kbd "{") '("{`!!'}"))
(key-combo-define-global (kbd "{}") "{}")
;;C
;; 2012-03-18
;; c-modeやc++-modeなどcc-modeベースのモード共通の設定
(add-hook
 'c-mode-common-hook
 (lambda ()
   ;; BSDスタイルをベースにする
   (c-set-style "bsd")

   ;; スペースでインデントをする
   (setq indent-tabs-mode nil)

   ;; インデント幅を2にする
   (setq c-basic-offset 2)

   ;; 自動改行（auto-new-line）と
   ;; 連続する空白の一括削除（hungry-delete）を
   ;; 有効にする
   (c-toggle-auto-hungry-state 1)

   ;; CamelCaseの語でも単語単位に分解して編集する
   ;; EmacsFrameClass   => Emacs Frame Class
   ;; GtkWindow         => Gtk Window
   ;; NSGraphicsContext => NS Graphics Context
   (subword-mode 1)))

;;;org-mode
(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(org-remember-insinuate)
(setq org-directory "~/Documents/org/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-agenda-files (list "~/Documents/org/plan.org"))
;; org-rememberを起動した時のテンプレ
(setq org-remember-templates
      '(("Event" ?e "** %?   \n   %i\n   %a\n   %U" nil "Events")
        ("Todo" ?t "** TODO %?\n   %i\n   %a\n   %U" nil "Inbox")
        ("Work" ?w "** TODO %?   :work:\n   %i\n   %a\n   %U" nil "Inbox")
        ("Home" ?h "** TODO %?   :home:\n   %i\n   %a\n   %U" nil "Inbox")
	("survey" ?s "** TODO %?   :survey:\n   %i\n   %a\n   %U" nil "Research")
	("Coding" ?c "** TODO %?   :code:\n   %i\n   %a\n   %U" nil "Research")
	("Bug" ?b "** TODO %?   :Bug:\n   %i\n   %a\n   %U" nil "Research")
	("paper" ?p "** TODO %?   :paper:\n   %i\n   %a\n   %U" nil "Research")
        ("Idea" ?i "** %?\n   %i\n   %a\n   %U" nil "New Ideas")
        ("Want" ?a "** %?\n   %i\n   %U" nil "Wants")
        ("Log" ?l "** %?\n   %i\n   %a\n   %U" nil "Inbox")
        ))
(setq org-todo-keywords
       '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)")
        (sequence "|" "CANCELED(c)")))

;; color
 (add-to-list 'load-path "~/.emacs.d/elisp/color-theme")
 (require 'color-theme)
 (eval-after-load "color-theme"
 	 '(progn
 		(color-theme-initialize)
 		(color-theme-molokai)))

;; 何か最後がいいらしい
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)



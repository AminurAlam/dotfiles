["(" ")"] @punctuation.bracket

(symbol) @variable
(boolean) @boolean
[(string) (raw_string)] @string

;; functions
(list
  .
  (symbol) @function
  (#any-of? @function
    "alias-to-trigger-on-load" "allow-hardware-repeat" "arbitrary-code"
    "base-layer" "block-unmapped-keys" "caps-word" "caps-word-custom"
    "caps-word-custom-toggle" "caps-word-toggle" "chord" "chordgroupname"
    "chords-v2-min-idle" "clipboard-cmd-set" "clipboard-restore" "clipboard-save"
    "clipboard-save-cmd-set" "clipboard-save-swap" "clipboard-set" "cmd"
    "cmd-output-keys" "concat" "concat" "concurrent-tap-hold" "danger-enable-cmd"
    "defalias" "defaliasenvcond" "defcfg" "defchords" "defchordsv2" "deffakekeys"
    "deflayer" "deflayermap" "deflocalkeys" "deflocalkeys-linux" "deflocalkeys-macos"
    "deflocalkeys-win" "deflocalkeys-winiov2" "deflocalkeys-wintercept" "defoverrides"
    "defoverridesv2" "defseq" "defsrc" "deftemplate" "defvar" "defvirtualkeys"
    "delegate-to-first-layer" "dynamic-macro" "dynamic-macro-max-presses"
    "dynamic-macro-play" "dynamic-macro-record" "dynamic-macro-record-stop"
    "dynamic-macro-record-stop-truncate" "fork" "hold-for-duration" "if-equal"
    "include" "input" "input-history" "key-history" "key-timing" "layer"
    "layer-switch" "layer-toggle" "layer-while-held" "log-layer-changes"
    "macos-dev-names-exclude" "macos-dev-names-include" "macro" "macro-cancel-on-press"
    "macro-release-cancel" "macro-release-cancel-and-cancel-on-press"
    "macro-repeat" "macro-repeat-cancel-on-press" "macro-repeat-release-cancel"
    "macro-repeat-release-cancel-and-cancel-on-press" "movemouse-accel-down"
    "movemouse-accel-left" "movemouse-accel-right" "movemouse-accel-up"
    "movemouse-down" "movemouse-inherit-accel-state" "movemouse-left"
    "movemouse-right" "movemouse-smooth-diagonals" "movemouse-speed" "movemouse-up"
    "multi" "mwheel-accel-down" "mwheel-accel-up" "mwheel-down" "mwheel-left"
    "mwheel-right" "mwheel-up" "on-idle" "on-idle-fakekey" "on-physical-idle"
    "on-press" "on-press-fakekey" "on-press-fakekey-delay" "on-release-fakekey"
    "on-release-fakekey-delay" "one-shot" "one-shot-pause-processing" "one-shot-press"
    "one-shot-press-pcancel" "one-shot-release" "one-shot-release-pcancel"
    "override-release-on-activation" "platform" "process-unmapped-keys"
    "push-msg" "rapid-event-delay" "release-layer" "reverse-release-order"
    "sequence" "sequence-backtrack-modcancel" "sequence-input-mode"
    "sequence-noerase" "sequence-timeout" "setmouse" "switch" "t!"  "tap-dance"
    "tap-dance-eager" "tap-hold" "tap-hold-except-keys" "tap-hold-press-timeout"
    "tap-hold-release" "tap-hold-release-keys" "tap-hold-release-tap-keys-release"
    "tap-hold-release-timeout" "tap-hold-tap-keys" "template-expand" "unicode" "unmod"
    "unshift" "use-defsrc")
)

;; switch case
(list
  (symbol) @keyword.conditional
  (#any-of? @keyword.conditional "break" "fallthrough")
)

;; operators
(list
  .
  (symbol) @keyword.operator
  (#any-of? @keyword.operator "not" "and" "or")
)
(list
  (symbol) @keyword.operator
  (#any-of? @keyword.operator "less-than" "lt" "greater-than" "gt")
)

; @alias
(list
  (symbol) @keyword
  (#match? @keyword "^\\@.+$")
)

; $variable
(list
  (symbol) @constant
  (#match? @constant "^\\$.+$")
)

; ;;comment ;|block_comment|;
[(comment) (block_comment)] @comment

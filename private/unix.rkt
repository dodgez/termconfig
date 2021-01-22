#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define)
(define-ffi-definer define-c (ffi-lib #f))

; int tcgetattr(int fd, struct termios *termios_p);
(define-c tcgetattr (_fun _int _pointer -> _int))
; int tcsetattr(int fd, int optional_actions,
;               const struct termios *termios_p);
(define-c tcsetattr (_fun _int _int _pointer -> _int))
; void cfmakeraw(struct termios *termios_p);
(define-c cfmakeraw (_fun _pointer -> _void))

(define termios (malloc 'atomic 64))

(define (enable-raw)
  (define termtmp (malloc 'atomic 64))
  (tcgetattr 0 termios)
  (tcgetattr 0 termtmp)
  (cfmakeraw termtmp)
  (tcsetattr 0 0 termtmp)
  (void))
(define (disable-raw)
  (tcsetattr 0 0 termios)
  (void))
(define-syntax-rule (with-raw commands ...) (begin (enable-raw) commands ... (disable-raw) (void)))

(provide enable-raw disable-raw with-raw)

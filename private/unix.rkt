#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define)
(define-ffi-definer define-c (ffi-lib #f))
(define (check val where)
  (unless (zero? val)
    (error where "failed: ~a" val)))
(define _termios-pointer (_cpointer 'termios))

; int tcgetattr(int fd, struct termios *termios_p);
(define-c tcgetattr (_fun _int _termios-pointer -> (r : _int) -> (check r 'tcgetattr)))
; int tcsetattr(int fd, int optional_actions,
;               const struct termios *termios_p);
(define-c tcsetattr (_fun _int _int _termios-pointer -> (r : _int) -> (check r 'tcsetattr)))
; void cfmakeraw(struct termios *termios_p);
(define-c cfmakeraw (_fun _termios-pointer -> _void))

(define termios #f)

(define (enable-raw)
  (when (ptr-equal? termios #f)
    (set! termios (cast (malloc 'atomic 36) _pointer _termios-pointer))
    (tcgetattr 0 termios))
  (define termtmp (cast (malloc 'atomic 36) _pointer _termios-pointer))
  (tcgetattr 0 termtmp)
  (cfmakeraw termtmp)
  (tcsetattr 0 0 termtmp))
(define (disable-raw)
  (tcsetattr 0 0 termios))
(define-syntax-rule (with-raw commands ... last) (begin (enable-raw) commands ... (let ([ret last]) (disable-raw) ret)))

(provide enable-raw disable-raw with-raw)

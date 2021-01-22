#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define)
(define-ffi-definer define-c (ffi-lib #f))

; HANDLE WINAPI GetStdHandle(_In_ DWORD nStdHandle);
(define-c GetStdHandle (_fun _int -> _pointer))
; BOOL WINAPI GetConsoleMode(_In_ HANDLE hConsoleHandle, _Out_ LPDWORD lpMode);
(define-c GetConsoleMode (_fun _pointer _pointer -> _int))
; BOOL WINAPI SetConsoleMode(_In_ HANDLE hConsoleHandle, _In_ DWORD dwMode);
(define-c SetConsoleMode (_fun _pointer _int -> _int))

(define MAXMODE 639)
(define LINE_INPT 2)
(define VIRT_TERM_INPT 512)
(define STDINPUT -10)
(define lpMode (malloc 'atomic 8))

(define (enable-raw)
  (define stdin (GetStdHandle STDINPUT))
  (GetConsoleMode stdin lpMode)
  (define mode (bitwise-ior VIRT_TERM_INPT (bitwise-and (ptr-ref lpMode _int) (- MAXMODE LINE_INPT))))
  (SetConsoleMode stdin mode)
  (void))
(define (disable-raw)
  (define stdin (GetStdHandle STDINPUT))
  (SetConsoleMode stdin (ptr-ref lpMode _int))
  (void))
(define-syntax-rule (with-raw commands ...) (begin (enable-raw) commands ... (disable-raw) (void)))

(provide enable-raw disable-raw with-raw)

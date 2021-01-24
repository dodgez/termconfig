#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define)
(define-ffi-definer define-c (ffi-lib #f))
(define (check val where)
  (when (zero? val)
    (error where "failed: ~a ~a" val (GetLastError))))
(define _HANDLE (_cpointer 'handle))

; HANDLE WINAPI GetStdHandle(_In_ DWORD nStdHandle);
(define-c GetStdHandle (_fun _uint32 -> _HANDLE))
; BOOL WINAPI GetConsoleMode(_In_ HANDLE hConsoleHandle, _Out_ LPDWORD lpMode);
(define-c GetConsoleMode (_fun _HANDLE _pointer -> (r : _int) -> (check r 'GetConsoleMode)))
; BOOL WINAPI SetConsoleMode(_In_ HANDLE hConsoleHandle, _In_ DWORD dwMode);
(define-c SetConsoleMode (_fun _HANDLE _uint32 -> (r : _int) -> (check r 'SetConsoleMode)))
; _Post_equals_last_error_ DWORD GetLastError();
(define-c GetLastError (_fun -> _uint32))

(define RAW-FLAGS (- 639 4 2 1))
(define VIRT-TERM-INPUT 512)
(define STDINPUT 4294967286)
(define lpMode (malloc 'atomic 8))

(define (enable-raw)
  (define stdin (GetStdHandle STDINPUT))
  (GetConsoleMode stdin lpMode)
  (define mode (bitwise-ior VIRT-TERM-INPUT (bitwise-and (ptr-ref lpMode _uint32) RAW-FLAGS)))
  (SetConsoleMode stdin mode)
  (void))
(define (disable-raw)
  (define stdin (GetStdHandle STDINPUT))
  (SetConsoleMode stdin (ptr-ref lpMode _int))
  (void))
(define-syntax-rule (with-raw commands ...) (begin (enable-raw) commands ... (disable-raw)))

(provide enable-raw disable-raw with-raw)

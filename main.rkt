#lang racket

(module+ test
  (require rackunit))


(module+ test
  (if-windows (check-equal? 3 3) (check-equal? 2 3))
  (check-equal? (+ 2 2) 4))


(define-syntax if-windows (if (equal? 'windows (system-type))
                              (syntax-rules () [(if-windows x y) x])
                              (syntax-rules () [(if-windows x y) y])))

(if-windows
 (begin
   (require "private/windows.rkt")
   (provide (all-from-out "private/windows.rkt")))
 (begin
   (require "private/unix.rkt")
   (provide (all-from-out "private/unix.rkt"))))

(module+ main (with-raw (display #"\x1b[31m Hello, World! \x1b[0m")))


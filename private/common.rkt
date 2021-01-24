#lang racket/base

(define (move-cursor-x x)
  (if (< x 0)
    (display (format "\x1b[~aD" (- x)))
    (display (format "\x1b[~aC" x))))
(define (move-cursor-y y)
  (if (< y 0)
    (display (format "\x1b[~aA" (- y)))
    (display (format "\x1b[~aB" y))))
(define (move-cursor x y)
  (move-cursor-x x)
  (move-cursor-y y))

(provide (all-defined-out))

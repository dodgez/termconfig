#lang racket

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

(require (for-syntax racket/match))
(define-syntax (create-color-style stx)
  (match (syntax->list stx)
    [(list _ color index)
     (datum->syntax stx `(begin
       (define ,(read (open-input-string (format "fg-~a" (syntax->datum color)))) (+ 30 ,index))
       (define ,(read (open-input-string (format "bg-~a" (syntax->datum color)))) (+ 40 ,index))
       (define ,(read (open-input-string (format "fg-bright-~a" (syntax->datum color)))) (+ 90 ,index))
       (define ,(read (open-input-string (format "bg-bright-~a" (syntax->datum color)))) (+ 100 ,index))))]))

(define (set-color-style #:fg-style [fg-style #f] #:bg-style [bg-style #f])
  (when fg-style (display (format "\x1b[~am" fg-style)))
  (when bg-style (display (format "\x1b[;~am" bg-style)))
  (when (and fg-style bg-style) (display (format "\x1b[~a;~am" fg-style bg-style)))
  (void))

(define (clear-style) (display "\x1b[0m"))

(create-color-style black 0)
(create-color-style red 1)
(create-color-style green 2)
(create-color-style yellow 3)
(create-color-style blue 4)
(create-color-style magenta 5)
(create-color-style cyan 6)
(create-color-style white 7)

(define (clear-screen)
  (display "\x1b[2J"))

(provide (except-out (all-defined-out) create-color-style))

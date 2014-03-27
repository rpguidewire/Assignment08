;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname alfs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;Question 2A
;x-coords-of-posns: loa --> loa 
;The purpose of this function is to take in in a listof Any, loa
; and return a list containing only the x-coodinate of all the posns in teh list

;;Examples 

(check-expect (x-coords-of-posns(list)) empty)
(check-expect (x-coords-of-posns(list 's)) empty)
(check-expect (x-coords-of-posns(list (make-posn 'hello 'super))) (list 'hello))

;;Function Definition 
(define (x-coords-of-posns loa)
  (map (lambda (x) (posn-x x))(filter posn? loa)))

;;Tests 
(check-expect (x-coords-of-posns 
               (list (make-posn 1 4) 'd (make-posn 2 4) (make-posn 3 4) 'd
                     (make-posn 4 4) (make-posn 5 4) (make-posn 6 4) 'd)) (list 1 2 3 4 5 6))

(check-expect (x-coords-of-posns 
               (list (make-posn 1 4) 'd (make-posn 2 4) (make-posn 3 4) 'd
                     (make-posn 4 4) (make-posn 5 4) (make-posn 6 4) 'd)) (list 1 2 3 4 5 6))

(check-expect (x-coords-of-posns 
               (list (make-posn 1 4) "hello" (make-posn 2 4) 
                     (make-posn 3 4) 'd
                     (make-posn 4 4) "hello" (make-posn 5 4) 
                     "hello" (make-posn 6 4) 'd)) (list 1 2 3 4 5 6))

(check-expect (x-coords-of-posns 
               (list (make-posn 4 4) "hello" (make-posn 2 4) 
                     (make-posn "jels" 4) 'd
                     (make-posn 4 4) "hello" (make-posn 'jelso 4) 
                     "hello" (make-posn 6 4) 'd)) (list 4 2 "jels" 4 'jelso 6))

(check-expect (x-coords-of-posns 
               (list (make-posn 4 4) (make-posn 2 4)(make-posn -3 4) 
                     (make-posn -3 4) (make-posn 6 4))) (list 4 2 -3 -3 6))

;;Question 2B
;alternating-sum: listof Num -> Num 
;The purpose of this function is to take the alternating sum of a listof numbers, lon. 

;Examples 

(check-expect (alternating-sum (list)) 0)
(check-expect (alternating-sum (list 1 2)) -1)
(check-expect (alternating-sum (list 1 2 3)) 2)

;;Function Definition 
(define (alternating-sum lon )
  (foldr - 0 lon))

;;Tests 
(check-expect (alternating-sum (list 1 2 3 4 5 6)) -3)
(check-expect (alternating-sum (list 9 3 1 0 3 4 6)) 12)
(check-expect (alternating-sum (list 20 23 34)) 31)
(check-expect (alternating-sum (list 23)) 23)


;;Question 2C
;remove-duplicates: (listof Num) --> (listof Num)
; The purpose of this function is to remove any redundancies from the list input, lon

;; Examples 
(check-expect (remove-duplicates empty) empty)
(check-expect (remove-duplicates '(1 2 3 4 5)) (list 1 2 3 4 5))

;;Function Definition 
(define (remove-duplicates lon)
  (foldr 
   (lambda (x y)
     (cons x
           (filter (lambda (z) (not (= x z))) y))) empty lon))

;;Tests
(check-expect (remove-duplicates '(1 2 3 4 5 5 4 3 2 1))(list 1 2 3 4 5))
(check-expect (remove-duplicates '(1 3 2 4 3 6 9 0 8 9 7 8 3 4 1 2)) (list 1 3 2 4 6 9 0 8 7))
(check-expect (remove-duplicates '(0 1 0 2 0 3 1 9)) '(0 1 2 3 9))
(check-expect (remove-duplicates '(1 1 1 1 1)) (list 1))
(check-expect (remove-duplicates '(1 2 1 2 1 2 3)) '(1 2 3))
(check-expect (remove-duplicates '(1 2 3 3 4 2 5)) (list 1 2 3 4 5))
(check-expect (remove-duplicates '(1.3 2.1 .3 0.3 4.5 2.1 4.5)) (list 1.3 2.1 0.3 4.5)) 
                                                                 
;Question 2D 
;;first-col: (listof (listof Num)) --> (listof Num)
;; The purpose of this function is to take in a listof (listof num), lolon and return 
;; a list containing the first item in each list. 

;;Examples 
(check-expect (first-col empty) empty)
(check-expect (first-col (list (list 1 2 3 4)
                               (list 1 2 3 4)
                               (list 1 2 3 4)
                               (list 1 2 3 4))) (list 1 1 1 1))

;;Function Definition 
(define (first-col lolon)
  (map (lambda (x) (first x)) lolon))

;;Examples 

(check-expect (first-col (list (list 11 21 31 41)
                               (list 31 22 13 34)
                               (list 71 32 3 54)
                               (list 25 2 33 54))) (list 11 31 71 25))

(check-expect (first-col (list (list 11 21 31 41)
                               (list 31 22 13 34)
                               (list 1 2 3 4)
                               (list 1 2 3 4)
                               (list 1 2 3 4)
                               (list 1 2 3 4)
                               (list 71 32 3 54)
                               (list 25 2 33 54))) (list 11 31 1 1 1 1 71 25))

(check-expect (first-col (list (list 11 21 31 41))) (list 11))


;;Question 2E
;; add1-mat: The purpose of this function is to take in a (listof (listof Num)), lolon
;; and add 1 to even item in every list and return a (listof (listof Num))

;;Examples 
(check-expect (add1-mat empty) empty)
(check-expect (add1-mat (list (list 1 2 3 4))) (list (list 2 3 4 5)))

;;Function Definition 

(define (add1-mat lolon)
  (map (lambda (y) (map (lambda (x) (add1 x)) y)) lolon))

;;Tests 
(check-expect (add1-mat (list (list 1 2 3 4)(list 1 2 3 4)(list 1 2 3 4)))
              (list (list 2 3 4 5)(list 2 3 4 5)(list 2 3 4 5)))

(check-expect (add1-mat (list (list 21 42 13 42)(list 13 21 3 34)(list 17 62 43 34)))
              (list (list 22 43 14 43) (list 14 22 4 35)(list 18 63 44 35)))

(check-expect (add1-mat (list (list 221 412 163 492)(list 213 217 123 344)))
              (list (list 222 413 164 493)(list 214 218 124 345)))

(check-expect (add1-mat (list (list 221 412 163 492)))
              (list (list 222 413 164 493)))

;;Question 2F
;;sum-at-zero (listof (Num->Num)) --> Num
;;The purpose of this function is to take in a listof functions that each take in one number
;; and sum and return all the results. 

;;Examples 
(check-expect (sum-at-zero (list)) 0)
(check-expect (sum-at-zero (list sqr sqr sub1 sqr)) -1)

;;Function Definition
(define (sum-at-zero lof)
  (foldr (lambda (x y) (+ (x 0) y)) 0 lof))

;;Tests
(check-expect (sum-at-zero (list sqr add1 add1 sub1)) 1)
(check-expect (sum-at-zero (list sqr sub1 sub1 sub1 sub1 sub1)) -5)
(check-expect (sum-at-zero (list sqr sqrt add1 sub1 add1 add1 add1 add1)) 4)
(check-expect (sum-at-zero (list sqr sqrt sqrt)) 0)
(check-expect (sum-at-zero (list sqr add1 sqrt sqrt)) 1)
















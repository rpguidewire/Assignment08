;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname composite) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

;;Question 3A 
;;composite: ((Num->Num) (Num->Num)) Num --> Num 
;;The purpose of this function is to take in two functions and create a 
;; composite of the two. 

;;Examples 
(check-expect ((composite add1 abs) -3) 4)

;;Function Definition 
(define (composite f g)
  (lambda (x) (f(g x))))

;;Tests
(check-expect ((composite  sqrt sqr) -3) 3)
(check-expect ((composite sqr sqr) 3) 81)
(check-expect ((composite add1 sqr) 3) 10)
(check-expect ((composite sqr add1) 3) 16)
(check-expect ((composite (lambda (x) (/ 1 x)) sqr) 4) 0.0625)


;;Question 3B 
;;inverse-of-square-list: ((Num->Num) (Num->Num)) (listof Num >= 0) --> listof Num 

;; The purpose of this fucntion is to take in a list of positive numbers, lop, and take the inverse 
;; of the square of each item in the list 

;;Examples 
(check-expect (inverse-of-square-list (list 1 2 5)) (list 1 0.25 0.04))
(check-expect (inverse-of-square-list (list 2 5 10)) (list 0.25 0.04 0.01))

;;Function Definition 
(define (inverse-of-square-list lop)
  (map (lambda (x) ((composite (lambda (y) (/ 1 y)) sqr) x)) lop))

;;Tests 
(check-expect (inverse-of-square-list (list)) (list))
(check-expect (inverse-of-square-list (list 4)) (list (/ 1 16)))
(check-expect (inverse-of-square-list (list 6 4 2)) (list (/ 1 36) (/ 1 16) (/ 1 4)))

;;Question 3C
;;composite-list: (listof (Num -> Num)) -> (Num->Num)
;; The purpose of this function is to take in a listof Functions, lst, each function 
;; takes in one number and returns the answer, and create a composite function with 
;; each function in the list. 

;;Examples 
(check-expect ((composite-list (list sqr add1)) 4) 25)
(check-expect ((composite-list (list sqr add1 sqr)) 4) 289)
(check-expect ((composite-list (list )) 4) 4)

;;Function Definition 
(define (composite-list lst)
  (foldr (lambda (x y) (composite x y)) identity lst))

;;Tests 
(check-expect ((composite-list (list add1 abs sub1)) -6) 8)
(check-expect ((composite-list (list add1 abs sub1 add1 (lambda (x) (* 3 x)))) -6) 19)
(check-expect ((composite-list (list (lambda (x) (- 4 x)) abs add1)) -1) 4)
(check-expect ((composite-list (list abs
                                     (lambda (x) (* -2 x))
                                     (lambda (x) (+ 8 x))
                                     (lambda (x) (/ 2 x)))) 10) 16.4)
                                     










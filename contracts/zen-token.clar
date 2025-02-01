;; Define fungible token
(define-fungible-token zen-token)

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-insufficient-balance (err u101))

;; Token details
(define-data-var token-name (string-ascii 32) "ZenToken")
(define-data-var token-symbol (string-ascii 10) "ZEN")

;; Mint tokens for meditation rewards
(define-public (mint-meditation-reward (user principal) (minutes uint))
  (let ((reward (* minutes u1)))  ;; 1 token per minute
    (if (is-eq tx-sender contract-owner)
      (ft-mint? zen-token reward user)
      err-owner-only)))

;; Transfer tokens
(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (ft-transfer? zen-token amount sender recipient))

;; Get balance
(define-read-only (get-balance (account principal))
  (ok (ft-get-balance zen-token account)))

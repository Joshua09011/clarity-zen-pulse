;; Data structures
(define-map sessions
  { id: uint }
  { 
    creator: principal,
    title: (string-ascii 64),
    duration: uint,
    music-hash: (buff 32),
    breath-pattern: (string-ascii 32),
    price: uint
  })

;; Session counter
(define-data-var session-count uint u0)

;; Create new session
(define-public (create-session 
  (title (string-ascii 64))
  (duration uint)
  (music-hash (buff 32))
  (breath-pattern (string-ascii 32))
  (price uint))
  (let ((session-id (+ (var-get session-count) u1)))
    (map-insert sessions
      { id: session-id }
      {
        creator: tx-sender,
        title: title,
        duration: duration,
        music-hash: music-hash,
        breath-pattern: breath-pattern,
        price: price
      })
    (var-set session-count session-id)
    (ok session-id)))

;; Get session details
(define-read-only (get-session (id uint))
  (map-get? sessions { id: id }))

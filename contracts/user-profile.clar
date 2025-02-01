;; User profile data
(define-map profiles
  { user: principal }
  {
    total-minutes: uint,
    sessions-completed: uint,
    achievements: (list 10 (string-ascii 32))
  })

;; Record meditation session
(define-public (record-session (minutes uint))
  (let (
    (current-profile (default-to 
      { total-minutes: u0, sessions-completed: u0, achievements: (list) }
      (map-get? profiles { user: tx-sender }))))
    (map-set profiles
      { user: tx-sender }
      {
        total-minutes: (+ (get total-minutes current-profile) minutes),
        sessions-completed: (+ (get sessions-completed current-profile) u1),
        achievements: (get achievements current-profile)
      })
    (ok true)))

;; Get user profile
(define-read-only (get-profile (user principal))
  (map-get? profiles { user: user }))


(define (problem puzzle1)
    (:domain simulation)
    (:objects who time where why conflict)

    (:init
        (maketrue who)
        (overlap conflict why)
        (overlap why conflict)
        (overlap who why)
        ; Set up home
        (= (total-cost) 0)
    )

    ; Goal to get to the end of the street
    (:goal
        (and
            (maketrue time)
            (maketrue who)
            (maketrue where)
            (maketrue why)
            (maketrue conflict)
        )
    )
    (:metric minimize
        (total-cost)
    )

)

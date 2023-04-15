;Header and description

(define (domain simulation)

    (:requirements :action-costs :conditional-effects :negative-preconditions :equality :adl :non-deterministic)

    (:predicates
        (maketrue ?x)
        (uncertain ?x)
        (overlap ?x ?y)
        (conflict ?x ?y)
        (done)
    )
    (:functions
        (total-cost)
    )
    (:action ask
        :parameters (?x)

        :precondition (and
            (not (maketrue ?x))
            (not (uncertain ?x))
        )

        :effect (and
            (oneof
                (maketrue ?x)
                (uncertain ?x)
            )
            (increase (total-cost) 10)
        )
    )
    (:action askagain
        :parameters (?x)
        :precondition (and
            (not (maketrue ?x))
            (uncertain ?x)
        )

        :effect (and
            (oneof
                (and (maketrue ?x) (not (uncertain ?x)))
                (uncertain ?x)
            )
            (increase (total-cost) 10)
        )
    )
    (:action deduct_overlap
        :parameters (?x ?y)
        :precondition (and
            (not (maketrue ?y))
            (not (uncertain ?y))
            (maketrue ?x)
            (overlap ?x ?y)
        )
        :effect (and
            (oneof
                (uncertain ?y)
                (oneof
                    (maketrue ?y)
                    (and (maketrue ?y) (conflict ?x ?y))
                )
            )
            
            (increase (total-cost) 1)
        )
    )
    (:action conflict_resolve
        :parameters (?x ?y)
        :precondition (and
            (maketrue ?y)
            (maketrue ?x)
            (conflict ?x ?y)
        )
        :effect (and
            (oneof
                (and (maketrue ?y)(uncertain ?x)(not (maketrue ?x))(not (conflict ?x ?y)))
                (and (maketrue ?x)(uncertain ?y)(not (maketrue ?y))(not (conflict ?x ?y)))
            )
            (increase (total-cost) 1)
        )
    )
    (:action solve
        :precondition (and
            (forall
                (?y ?z)
                (not (conflict ?y ?z))
            )
            (forall
                (?w)
                (maketrue ?w)
            )
        )
        :effect (and
            (done)
        )
    )
)

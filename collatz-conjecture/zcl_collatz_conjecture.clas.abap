CLASS zcl_collatz_conjecture DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS ret_steps IMPORTING num          TYPE i
                      RETURNING VALUE(steps) TYPE i
                      RAISING   cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_collatz_conjecture IMPLEMENTATION.
  METHOD ret_steps.
    IF num < 1.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ELSEIF num > 1.
      steps = REDUCE I( INIT s = 0
                        FOR  i = num THEN SWITCH #( i MOD 2 WHEN 0 THEN i / 2 ELSE i * 3 + 1 ) UNTIL i < 2
                        NEXT s = s + 1 ) . 
    ENDIF.
  ENDMETHOD.
ENDCLASS.

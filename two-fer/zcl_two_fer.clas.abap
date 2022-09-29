CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
    DATA(LV_FIRSTPERSON) = COND #( WHEN input IS NOT INITIAL THEN input ELSE 'you' ).
    result = |One for { LV_FIRSTPERSON }, one for me.|.
  ENDMETHOD.

ENDCLASS.
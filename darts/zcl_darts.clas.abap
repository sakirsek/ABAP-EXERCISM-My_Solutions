CLASS zcl_darts DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        x             TYPE f
        y             TYPE f
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_darts IMPLEMENTATION.
  METHOD score.
    result = COND #( let square = sqrt( x ** 2 + y ** 2 ) in
                     WHEN square > 10 THEN 0 
                     WHEN square > 5 THEN 1
                     WHEN square > 1 THEN 5
                     ELSE 10 ).
  ENDMETHOD.


ENDCLASS.

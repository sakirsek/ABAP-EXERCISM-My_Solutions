CLASS zcl_rle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS encode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

    METHODS decode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

ENDCLASS.


CLASS zcl_rle IMPLEMENTATION.

  METHOD encode.
    DATA: CHAR2      TYPE STRING,
          DUPLICATES TYPE STRING.
    DATA(STR) = INPUT.
    WHILE STR IS NOT INITIAL.
      FIND REGEX '([\w|\s])(\1*)(.*)' IN STR SUBMATCHES CHAR2 DUPLICATES STR  ##SUBRC_OK.
      RESULT = COND #( WHEN DUPLICATES IS NOT INITIAL THEN |{ RESULT }{ STRLEN( DUPLICATES ) + 1 }{ CHAR2 }|
                                                      ELSE |{ RESULT }{ CHAR2 }| 
                     ).
    ENDWHILE.
  ENDMETHOD.


  METHOD decode.
    DATA: CHAR2 TYPE STRING,
          REPS  TYPE STRING.
    DATA(STR) = INPUT.
    WHILE STR IS NOT INITIAL.
      FIND REGEX '(\d*)([\w|\s])(.*)' IN STR SUBMATCHES REPS CHAR2 STR  ##SUBRC_OK.
      RESULT = COND #( WHEN REPS IS NOT INITIAL THEN |{ RESULT }{ REPEAT( VAL = CHAR2 OCC = REPS ) }|
                                                ELSE |{ RESULT }{ CHAR2 }| 
                     ).
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.

CLASS zcl_anagram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS anagram
      IMPORTING
        input         TYPE string
        candidates    TYPE string_table
      RETURNING
          VALUE(result) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_anagram IMPLEMENTATION.

  METHOD anagram.
    
    INPUT = TO_LOWER( INPUT ).
    DATA(LEN) = STRLEN( INPUT ).
    LOOP AT CANDIDATES INTO DATA(CANDIDATE).
      DATA(INPUT2) = INPUT.
      DATA(WORD) = TO_LOWER( CANDIDATE ).
      IF LEN = STRLEN( CANDIDATE ) AND INPUT <> WORD.
        DO LEN TIMES.
          IF INPUT2(1) CA WORD.
            REPLACE INPUT2(1) IN WORD WITH ``.
          ENDIF.
          SHIFT INPUT2.
        ENDDO.
        IF WORD = ''.
          APPEND CANDIDATE TO RESULT.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

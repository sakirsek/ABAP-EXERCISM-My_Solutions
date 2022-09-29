CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    DATA(lv_first_strand) = STRLEN( first_strand ).
    DATA(lv_second_strand) = STRLEN(second_strand ).
    IF lv_first_strand = lv_second_strand.
      DO lv_second_strand TIMES.
        DATA(lv_index) = SY-INDEX - 1.
        IF first_strand+lv_index(1) NE second_strand+lv_index(1).
          result = result + 1.
        ENDIF.
      ENDDO.
    ELSE.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

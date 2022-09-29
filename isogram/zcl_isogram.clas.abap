CLASS zcl_isogram DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS is_isogram
      IMPORTING
        VALUE(phrase)        TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_isogram IMPLEMENTATION.

  METHOD is_isogram.
    result = abap_true.
    DO STRLEN( phrase ) TIMES.
      DATA(lv_index)  = sy-index - 1.
      DATA(lv_character) = TO_LOWER( phrase+lv_index(1) ).
      IF sy-abcde CS lv_character and COUNT( val = TO_LOWER( phrase ) regex = lv_character ) > 1.
        result = abap_false.
        EXIT.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.

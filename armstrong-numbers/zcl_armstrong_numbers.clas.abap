CLASS zcl_armstrong_numbers DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS is_armstrong_number IMPORTING num           TYPE i
                                RETURNING VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_armstrong_numbers IMPLEMENTATION.
  METHOD is_armstrong_number.DATA test TYPE i.
    DATA OFFSET TYPE I.
    DATA(STRINGNUM) = |{ NUM }|.
    DATA(NUMLEN) = STRLEN( STRINGNUM ).
    DO NUMLEN TIMES.
      OFFSET = SY-INDEX - 1.
      TEST += STRINGNUM+OFFSET(1) ** NUMLEN.
    ENDDO.
    RESULT = BOOLC( TEST = NUM ).
  ENDMETHOD.
ENDCLASS.


CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
    METHODS get_point
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    DATA(LV_LEN) = STRLEN( input ).
    DO LV_LEN TIMES.
      DATA(LV_INDEX) = SY-INDEX - 1.
      result = result + GET_POINT( input+LV_INDEX(1) ).
    ENDDO.
  ENDMETHOD.

  METHOD get_point.
    CASE to_upper( input ).
      WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T'.
        result = 1.
      WHEN 'D' OR 'G' .
        result = 2.
      WHEN 'B' OR 'C' OR 'M' OR 'P'.
        result = 3.
      WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
        result = 4.
      WHEN 'K'.
        result = 5.
      WHEN 'J' OR 'X' .
        result = 8.
      WHEN 'Q' OR 'Z'.
        result = 10.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

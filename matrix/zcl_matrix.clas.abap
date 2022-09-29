CLASS zcl_matrix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS matrix_row
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
    METHODS matrix_column
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_matrix IMPLEMENTATION.
  METHOD matrix_row.
    SPLIT string AT '\n' INTO TABLE DATA(lt_rows).
    SPLIT lt_rows[ index ] AT ' ' INTO TABLE DATA(lt_cells).    
    result = VALUE #( FOR c in lt_cells ( c ) ).
  ENDMETHOD.

  METHOD matrix_column.
    SPLIT string AT '\n' INTO TABLE DATA(lt_rows).
    LOOP AT lt_rows INTO DATA(ls_rows).
      SPLIT ls_rows AT ' ' INTO TABLE DATA(lt_cells).
      APPEND lt_cells[ index ] TO result.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_plant_name
      IMPORTING
        plant_id       TYPE string
      RETURNING
        VALUE(results) TYPE string.

    DATA students TYPE string_table.

ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.


  METHOD plants.
    students = VALUE #( ( |Alice| )  ( |Bob| )    ( |Charlie| ) ( |David| )
                        ( |Eve| )    ( |Fred| )   ( |Ginny| )   ( |Harriet| )
                        ( |Ileana| ) ( |Joseph| ) ( |Kincaid| ) ( |Larry| )   ).
    DATA(lv_index) = LINE_INDEX( students[ TABLE_LINE = student ] ).
    DATA(FIRST_OFFSET) = ( LV_INDEX * 2 ) - 1.
    DATA(SECOND_OFFSET)  = FIRST_OFFSET - 1.
    SPLIT diagram AT '\n' INTO DATA(lv_first_line) DATA(lv_second_line).
    results = VALUE #( ( get_plant_name( lv_first_line+second_offset(1) ) ) 
                       ( get_plant_name( lv_first_line+first_offset(1) ) ) 
                       ( get_plant_name( lv_second_line+second_offset(1) ) )
                       ( get_plant_name( lv_second_line+first_offset(1) ) )
                     ).
  ENDMETHOD.

  method get_plant_name.
    results = |{ COND STRING( WHEN plant_id = 'C' THEN 'clover'
                              WHEN plant_id = 'G' THEN 'grass'
                              WHEN plant_id = 'R' THEN 'radishes'
                              WHEN plant_id = 'V' THEN 'violets' ) }|.
  endmethod.

ENDCLASS.

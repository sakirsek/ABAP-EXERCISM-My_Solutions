CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES: BEGIN OF type_resistor_color,
             color_code   TYPE string,
             value TYPE i,
           END OF type_resistor_color.
    CLASS-DATA: resistor_color TYPE TABLE OF type_resistor_color READ-ONLY.
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.
    METHODS constructor.
ENDCLASS.

CLASS zcl_resistor_color IMPLEMENTATION.
  METHOD constructor.
      resistor_color = VALUE #( ( color_code = 'black' value = 0 )
                                ( color_code = 'brown' value = 1 )
                                ( color_code = 'red' value = 2 )
                                ( color_code = 'orange' value = 3 )
                                ( color_code = 'yellow' value = 4 )
                                ( color_code = 'green' value = 5 )
                                ( color_code = 'blue' value = 6 )
                                ( color_code = 'violet' value = 7 )
                                ( color_code = 'grey' value = 8 )
                                ( color_code = 'white' value = 9 ) ).
  ENDMETHOD.

  METHOD resistor_color.
    value = VALUE #( resistor_color[ color_code = color_code ]-value OPTIONAL ).
  ENDMETHOD.

ENDCLASS.

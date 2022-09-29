CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.
    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.
    DATA: gv_hours TYPE i ,
          gv_minutes TYPE i.
ENDCLASS.



CLASS zcl_clock IMPLEMENTATION.

  METHOD constructor.
    gv_hours = COND #( WHEN hours IS NOT INITIAL THEN hours MOD 24 ).
    gv_minutes = COND #( WHEN minutes IS NOT INITIAL AND minutes >= 0 AND minutes < 60 THEN minutes ELSE 0 ).
    IF minutes >= 60.
      ADD( minutes ).
    ELSEIF minutes < 0.
      SUB( ABS( minutes ) ).
    ENDIF.
  ENDMETHOD.

  METHOD add.
    IF minutes > 0.
      gv_minutes = gv_minutes + ( minutes MOD 60 ).
      IF minutes >= 60.
        gv_hours = gv_hours + ( minutes DIV 60 ).
      ENDIF.
      IF gv_minutes >= 60.
        gv_hours = gv_hours + ( gv_minutes DIV 60 ).
        gv_minutes = gv_minutes MOD 60.
      ENDIF.
      gv_hours = gv_hours MOD 24.
    ELSE.
      SUB( ABS( minutes ) ).
    ENDIF.
  ENDMETHOD.

  METHOD get.
    result = |{ cond string( when gv_hours < 10 then '0' ) }{ gv_hours }:{ cond string( when gv_minutes < 10 then '0' ) }{ gv_minutes }|.
  ENDMETHOD.


  METHOD sub.
    IF ( minutes MOD 60 ) > gv_minutes.
      gv_hours = gv_hours - 1.
      gv_minutes = gv_minutes + 60.
    ENDIF.
    gv_minutes = gv_minutes - ( minutes MOD 60 ).
    IF minutes >= 60.
      gv_hours = gv_hours - ( minutes DIV 60 ).
    ENDIF.
    gv_hours = gv_hours MOD 24.
  ENDMETHOD.
ENDCLASS.

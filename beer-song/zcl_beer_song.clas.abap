CLASS zcl_beer_song DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS recite
      IMPORTING
        !initial_bottles_count TYPE i
        !take_down_count       TYPE i
      RETURNING
        VALUE(result)          TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_beer_song IMPLEMENTATION.

  METHOD recite.
    DATA(LV_REMAINING_BOTTLES) = INITIAL_BOTTLES_COUNT.
    DO TAKE_DOWN_COUNT TIMES.
      INSERT |{ COND STRING( WHEN LV_REMAINING_BOTTLES = 0 THEN |No more bottles of beer on the wall, no more bottles of beer.|
                             WHEN LV_REMAINING_BOTTLES = 1 THEN |{ LV_REMAINING_BOTTLES } bottle of beer on the wall, { LV_REMAINING_BOTTLES } bottle of beer.|
                             ELSE  |{ LV_REMAINING_BOTTLES } bottles of beer on the wall, { LV_REMAINING_BOTTLES } bottles of beer.|
                           ) }|
        INTO TABLE RESULT.
      LV_REMAINING_BOTTLES = INITIAL_BOTTLES_COUNT - SY-INDEX.
      INSERT |{ COND STRING( WHEN LV_REMAINING_BOTTLES < 0 THEN |Go to the store and buy some more, 99 bottles of beer on the wall.|
                             WHEN LV_REMAINING_BOTTLES = 0 THEN |Take it down and pass it around, no more bottles of beer on the wall.|
                             WHEN LV_REMAINING_BOTTLES = 1 THEN |Take one down and pass it around, { LV_REMAINING_BOTTLES } bottle of beer on the wall.|
                             ELSE  |Take one down and pass it around, { LV_REMAINING_BOTTLES } bottles of beer on the wall.|
                           ) }|
        INTO TABLE RESULT.
      IF TAKE_DOWN_COUNT - SY-INDEX > 0.
        INSERT || INTO TABLE RESULT.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.

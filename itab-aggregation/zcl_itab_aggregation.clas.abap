CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    DATA: LV_INDEX TYPE I,
          LV_COUNT TYPE I,
          LV_SUM TYPE I,
          LV_MIN TYPE I,
          LV_MAX TYPE I.
    SORT initial_numbers BY GROUP ASCENDING.
    LOOP AT initial_numbers ASSIGNING FIELD-SYMBOL(<FS_MAIN>).
      LV_INDEX = LINE_INDEX( initial_numbers[ group = <FS_MAIN>-group ] ).
      IF LV_INDEX IS NOT INITIAL AND ( NOT LINE_EXISTS( aggregated_data[ group = <FS_MAIN>-group ] ) ).
        LOOP AT initial_numbers ASSIGNING FIELD-SYMBOL(<FS_SUB>) FROM LV_INDEX.
          IF <FS_MAIN>-group <> <FS_SUB>-group.
            EXIT.
          ENDIF.
          LV_COUNT = LV_COUNT + 1.
          LV_SUM = LV_SUM + <FS_SUB>-number.
          LV_MIN = COND #( WHEN LV_MIN IS INITIAL OR <FS_SUB>-number < LV_MIN THEN <FS_SUB>-number ELSE LV_MIN ).
          LV_MAX = COND #( WHEN LV_MAX IS INITIAL OR <FS_SUB>-number > LV_MIN THEN <FS_SUB>-number ELSE LV_MAX ).
        ENDLOOP.
        APPEND VALUE #( group = <FS_MAIN>-group
                        count = LV_COUNT
                        sum = LV_SUM
                        min = LV_MIN
                        max = LV_MAX
                        average = LV_SUM / LV_COUNT
                      ) TO aggregated_data.
        CLEAR: LV_INDEX, LV_COUNT, LV_SUM, LV_MIN, LV_MAX.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

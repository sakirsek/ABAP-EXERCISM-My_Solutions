CLASS zcl_acronym DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS parse IMPORTING phrase         TYPE string
                  RETURNING VALUE(acronym) TYPE string.
    TYPES CHAR1(1) TYPE C.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_acronym IMPLEMENTATION.
  METHOD parse.
    DATA(TEXT) = TO_UPPER( PHRASE ).
    TRANSLATE TEXT USING '- _ '.
    SPLIT CONDENSE( TEXT ) AT ' ' INTO TABLE DATA(WORDS).
    DO LINES( WORDS ) TIMES.
      ACRONYM &&= CONV CHAR1( WORDS[ SY-INDEX ] ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.

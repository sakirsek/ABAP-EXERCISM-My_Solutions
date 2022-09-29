CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS decode
      IMPORTING
        cipher_text TYPE string
      RETURNING
        VALUE(plain_text)  TYPE string .
    METHODS encode
      IMPORTING
        plain_text        TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
    plain_text = translate( val = cipher_text from = |{ to_lower( sy-abcde ) }0123456789 | to = |{ to_lower( reverse( sy-abcde ) ) }0123456789| ).
  ENDMETHOD.

  METHOD encode.
    cipher_text = translate( val = to_lower( plain_text ) from = |{ to_lower( sy-abcde ) }0123456789,. | to = |{ to_lower( reverse( sy-abcde ) ) }0123456789| ).
    cipher_text = condense( REDUCE string( LET cipher_text_ = |{ cipher_text }{ repeat( val = ` ` occ = 5 - strlen( cipher_text ) MOD 5 ) }| IN
                                           INIT c_t_ TYPE string
                                           FOR group_of_five_ = 0 WHILE group_of_five_ < strlen( cipher_text_ ) DIV 5
                                           NEXT c_t_ = |{ c_t_ } { substring( val = cipher_text_ off = 5 * group_of_five_ len = 5 ) }| ) ).
ENDMETHOD.
ENDCLASS.

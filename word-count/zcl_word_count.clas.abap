CLASS zcl_word_count DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF return_structure,
        word  TYPE string,
        count TYPE i,
      END OF return_structure,
      return_table TYPE STANDARD TABLE OF return_structure WITH KEY word.
    METHODS count_words
      IMPORTING
        !phrase       TYPE string
      RETURNING
        VALUE(result) TYPE return_table .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_word_count IMPLEMENTATION.

  METHOD count_words.
    phrase = TO_LOWER( phrase ).
    phrase = REPLACE( val = phrase sub = ','  with = ` ` occ = 0 ).
    phrase = REPLACE( VAL = phrase REGEX = `[':/.!&@$%^&]|[[:punct:]]|\\[a-zA-Z]{1}`  WITH = `` OCC = 0 ).
    SPLIT phrase AT ' ' INTO TABLE DATA(words).
    SORT words.
    DELETE words WHERE TABLE_LINE = SPACE.
    result = VALUE #( FOR word in words ( word = word
                                          count = VALUE #( REDUCE i( init x = 0 for word2 in words where ( TABLE_LINE = word ) next x = x + 1 ) )
                                         )
                     ).
    DELETE ADJACENT DUPLICATES FROM result.
  ENDMETHOD.
ENDCLASS.

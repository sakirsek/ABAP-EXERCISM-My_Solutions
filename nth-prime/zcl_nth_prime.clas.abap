CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.

  PROTECTED SECTION.
  PRIVATE SECTION.
  TYPES primes TYPE STANDARD TABLE OF i WITH DEFAULT KEY.

  METHODS get_nth_prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i.

    METHODS get_primes
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE primes.

    METHODS count_primes
      IMPORTING
        input         TYPE i
        primes        TYPE primes
      RETURNING
        VALUE(result) TYPE i.

ENDCLASS.


CLASS zcl_nth_prime IMPLEMENTATION.
  "Sieve of Eratosthenes
  METHOD PRIME.
    IF INPUT < 1.
      RAISE EXCEPTION NEW CX_PARAMETER_INVALID( ).
    ENDIF.
    RESULT =  GET_NTH_PRIME( INPUT ).
  ENDMETHOD.
  
  METHOD GET_NTH_PRIME.
    DATA(TOTAL_PRIMES) = 0.
    DATA(SIZE_FACTOR) = 2.
    DATA(S) = INPUT * SIZE_FACTOR.
    WHILE TOTAL_PRIMES < INPUT + 2.
      DATA(PRIMES) = GET_PRIMES( S ).
      TOTAL_PRIMES = REDUCE I( INIT X = 0 FOR WA IN PRIMES WHERE( TABLE_LINE = '1' ) NEXT X = X + 1 ).
      SIZE_FACTOR += 1.
      S = ( INPUT * SIZE_FACTOR ).
    ENDWHILE.
    RESULT = COUNT_PRIMES( INPUT = INPUT PRIMES = PRIMES ).
  ENDMETHOD.
  
  METHOD GET_PRIMES.
    RESULT = VALUE #( FOR X = 0 WHILE X < INPUT ( 1 ) ).
    DATA(I) = 1.
    DO INPUT - 2 TIMES.
      I += 1.
      IF RESULT[ I ] = 1.
        DATA(J) = I - 1.
        DO INPUT - I TIMES.
          J += 1.
          IF I * J < INPUT.
            RESULT[ I * J ] = 0.
          ELSE.
            EXIT.
          ENDIF.
        ENDDO.
      ENDIF.
    ENDDO.
  ENDMETHOD.
  
  METHOD COUNT_PRIMES.
    DATA(COUNT) = 0.
    DATA(K) = 1.
    DO LINES( PRIMES ) - 2 TIMES.
      COUNT += PRIMES[ K ].
      K += 1.
      IF COUNT = INPUT.
        RESULT = K.
      ENDIF.
    ENDDO.
  ENDMETHOD .

ENDCLASS.

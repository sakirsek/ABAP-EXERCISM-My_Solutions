# Description

> There are 10 types of people in the world: Those who understand
> binary, and those who don't.

You and your fellow cohort of those in the "know" when it comes to
binary decide to come up with a secret "handshake".

```text
00001 = wink
00010 = double blink
00100 = close your eyes
01000 = jump


10000 = Reverse the order of the operations in the secret handshake.
```

Given a decimal number, convert it to the appropriate sequence of events for a secret handshake.

Here's a couple of examples:

Given the decimal input 3, the function would return the following string_table:
| Row | TABLE_LINE   |
| --- | ------------ |
| 1   | wink         |
| 2   | double blink |

This is because the decimal number 3 is 2+1 in powers of two and thus `11` in binary.

Let's now examine the input 19 which is 16+2+1 in powers of two and thus `10011` in binary.
Recalling that the addition of 16 (`10000` in binary) reverses the sequence and that we already know what result is returned given input 3, the string_table returned for input 19 is:

| Row | TABLE_LINE   |
| --- | ------------ |
| 1   | double blink |
| 2   | wink         |

# Reference

https://github.com/exercism/abap/tree/main/exercises/practice/secret-handshake
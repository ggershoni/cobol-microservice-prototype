identification division.
program-id. HelloWorld.
environment division.
data division.
working-storage section.
  01 new-line pic x value x'0A'.
procedure division.
  display "Content-type: application/json".
  display new-line.
  display '{"message":"Hello World"}'.

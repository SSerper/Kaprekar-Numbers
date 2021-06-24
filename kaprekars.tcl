#! /bin/sh
# Coding by: Sedat Serper \
exec tclsh $0 ${1+"$@"}

# -- set max number to iterate through, with increments of 1, starting at 1
set range 100000

# -- strips leading zeros to please expr command...
proc stripLZ {n} {
  set nr $n
  while {[string range $nr 0 0] == "0"} {
    set nr [string range $nr 1 end]
  }
  if {$nr == ""} {return $n}
  return $nr
}

# -- check if nr is Kaprekar sequence, return 1 if so, or 0 if not
proc isKap {nr} {
  set sq [expr $nr * $nr]
  set sL [string length $nr]
  
  if {$nr == 1} {return 1}
  if {([lindex [split [expr $sq / 10.0] .] end] == 0) && \
      ([string range $sq 0 0] == "1")} {return 0}

  # check for both possible cases
  foreach o {0 1} {
    set fpart [string range $sq 0 [expr $sL -1 -$o]]
    if {$fpart == ""} {return 0}
    set lpart [string range $sq [expr $sL -$o] end] 
    if {$lpart == ""} {return 0}
    if {($fpart + [stripLZ $lpart]) == $nr} {return 1}
  }
  
  return 0
}

# -- check range of numbers
set i 1
while {$i < $range} {
  if {[isKap $i]} {puts $i}
  incr i
}


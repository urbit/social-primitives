/-  *people
/+  etch
|%
++  enjs
=,  enjs:format
  |%
  ++  scry-json
  |=  =scry
  ^-  json
  ?-  -.scry
    %lists
    :-  %a 
    %+  turn  +.scry
      |=  name=@t
      s+name
    ::
    %lis
    :-  %a
    %+  turn  lis.scry
      |=  person=[ship=@p nick=name]
      %-  pairs 
      :~  :-  'ship'  (to-ship ship.person)
          :-  'nick'  s+nick.person
      ==
  ==
   ++  to-ship
  |=  ship=@p
  :-  %s  `@t`(scot %p ship)
  --
--
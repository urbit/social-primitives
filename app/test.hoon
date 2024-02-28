/-  *people
/+  dbug, default-agent, verb
::
|%
::
+$  versioned-state
  $%  state-0
  ==
::
+$  state-0 
  $:  %0  
  ==
::
+$  card  $+(card card:agent:gall)
--
::
=|  state-0
=*  state  -
::
::
%+  verb  |
%-  agent:dbug
::
^-  agent:gall
::
=<
  |_  =bowl:gall
  +*  this  .
      def  ~(. (default-agent this %|) bowl)
      hc   ~(. +> [bowl ~])
  ::
  ++  on-init
    ^-  (quip card _this)
    =^  cards  state  abet:init:hc
    [cards this]
  ::
  ++  on-save
    ^-  vase
    !>(state)
  ::
  ++  on-load
    |=  =vase
    ^-  (quip card _this)
    =^  cards  state  abet:(load:hc vase)
    [cards this]
  ::
  ++  on-poke  
    |=  [=mark =vase]
    ^-  (quip card _this)
    =^  cards  state  abet:(poke:hc mark vase)
    [cards this]
  ++  on-peek   on-peek:def
  ::
  ++  on-watch  on-watch:def
  ::
  ++  on-agent  
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    =^  cards  state  abet:(agent:hc wire sign)
    [cards this]
  ++  on-arvo   on-arvo:def
  ++  on-fail   on-fail:def
  ++  on-leave  on-leave:def
  --
|_  [=bowl:gall deck=(list card)]
+*  that  .
++  emit  |=(=card that(deck [card deck]))
++  emil  |=(lac=(list card) that(deck (welp (flop lac) deck)))
++  abet  ^-((quip card _state) [(flop deck) state])
::
++  from-self  =(our src):bowl
::
++  init
  ^+  that
  %-  emit  
  [%pass /update/people %agent [our.bowl %people] %watch /updates/lists]
::
++  load
  |=  vaz=vase
  ^+  that
  ?>  ?=([%0 *] q.vaz)
  that(state !<(state-0 vaz))
::
++  poke 
  |=  [=mark =vase]
  ^+  that
  ?+  mark  that
    %noun
  =/  act  !<(?(%start %kick) vase)
  ?-  act
    %start
  %-  emit 
  [%pass /update/people %agent [our.bowl %people] %watch /updates/lists]
  ::
    %kick
  %-  emit 
  [%pass /update/people %agent [our.bowl %people] %leave ~]
    ==
  ==
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  that
  ?+  wire  ~|(bad-agent-wire+wire !!)
    [%update %people ~]
  ?+  -.sign  ~|(bad-agent-sign+sign !!)
      %watch-ack
    ?~  p.sign
      ((slog 'Subscribe succeeded!' ~) that)
    ((slog 'Subscribe failed!' ~) that)
      %fact
    ?+  p.cage.sign  ~|(bad-agent-mar+p.cage.sign !!)
      %people-update
      ~&  !<(update q.cage.sign)
      that
      %kick
      ~&  'got kick'
      that
    ==
  ==
  ==
--
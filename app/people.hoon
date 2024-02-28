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
    lists=(map name lis)  
    guild=(map name (map ship bio))
    invites=(map name ship)
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
  ::
  ++  on-peek   peek:hc
  ::
  ++  on-watch  
    |=  =path
    ^-  (quip card _this)
    =^  cards  state  abet:(watch:hc path)
    [cards this]
  ::
  ++  on-agent  
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    =^  cards  state  abet:(agent:hc wire sign)
    [cards this]
  ::
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
++  in-lists  
  |=  =name
  ^-  lis
  ?<  =((~(get by lists) name) ~)
  (~(got by lists) name)

++  in-guild
  |=  =name
  ^-  (map ship bio)
  ?<  =((~(get by guild) name) ~)
  (~(got by guild) name)
::
++  init
  ^+  that
  that
::
++  load
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
::
++  poke
  |=  [=mark =vase]
  ^+  that
  ?+  mark  that
    %noun ::%people-action
  ?>  from-self
  =+  !<(act=action vase)
  ?-  -.act
    %new-list
  =.  lists  (~(put by lists) name.act *(list person))
  %-  emit
  [%give %fact ~[/updates/lists] %people-update !>([%new-list name.act])]
  ::
    %del-list
  =.  lists  (~(del by lists) name.act)
  %-  emit
  [%give %fact ~[/updates/lists] %people-update !>([%del-list name.act])]
  ::
  ::add check if alredy in list 
    %add-to-list
  =,  act
  =/  =lis  (in-lists name)
  ?~  order 
    ::  if no order num provided add last
    =.  lis  %+  snoc  lis 
             person
    =.  lists  (~(put by lists) name lis)
    that
  =.  lis  %^  into  lis 
               (dec order) 
            person.act
  =.  lists  (~(put by lists) name.act lis)
  %-  emit
  (give-update-list name.act)
  ::
    %del-from-list  
  =/  =lis  (in-lists name)
  =/  i   %-  need
          %+  find  [person.act ~]
          lis
  =.  lists  (~(put by lists) name.act (oust [i 1] lis))
  %-  emit
  (give-update-list name.act)
  ::
  ::del person at privious index adds at new index
    %new-order 
  =/  =lis  (in-lists name)
  =/  at  (find [person.act ~] lis)
  ?~  at  
    ~&  >>  'not in lists'
    that
  ::  rearrange runs
  =.  lis   
    %-  into  
    :_  :-  (dec order.act)  :: index-1
          person.act
    %+  oust  [(need at) 1]  ::list without ~zod
    lis
  =.  lists  (~(put by lists) name.act lis)
  %-  emit 
  (give-update-list name.act)
  ::
    %new-guild
  ::  add myself as an %admin
  =/  gil    (~(put by *(map ship bio)) our.bowl [%admin `@t`~])
  =.  guild  (~(put by guild) name.act gil)
  that
  :: ::
    %send-invite
  =/  gil  (in-guild name.act)
  ::  Checks if alredy in guild (should it be allowed to send invite over and over if not %accepted) ???
  ?<  (~(has by gil) ship.act)  
  =.  gil  (~(put by gil) ship.act [%invited nick.act])
  =.  guild  (~(put by guild) gil)
  %-  emit 
  [%pass /poke/[ship.act] %agent [ship.act %people] %poke %noun !>([%get-invite name.act our.bowl])]
  ::
  %get-invite 
  ::WHAT IF SAME NAME ?
  =.  invites  (~(put by invites) name.act from.act)
  that
  ::
  %accept-invite 
  %-  emit
  [%pass /guild/[name.act] %agent [from.act %people] %watch /updates/guild/[name.act]]
    ==
  ==
::
++  give-update-list
|=  =name
^-  card
[%give %fact ~[/updates/lists] %people-update !>([%update-list name (~(got by lists) name)])]
::
++  peek
  |=  =path
  ^-  (unit (unit cage))
  ?+  path  [~ ~]
  ::  all lists names 
  [%x %lists ~]      ``people-update+!>([%lists ~(tap in ~(key by lists))])
  ::  get lis by name
  [%x %list @ ~]     ``people-update+!>([%lis `(list person)`(need (~(get by lists) `@t`-.+.+.path))])  
  ==
::
++  watch
  |=  =path 
  ^+  that 
  ?+  path  ~|(bad-watch-path+path !!)
  [%updates %lists ~]  that
  [%updates %guild @ ~] 
  ~&  t.t.path
  =/  gil  (in-guild t.t.path)
  ?~  (~(get by gil) src.bowl)  that
  =/  =bio (~(got by gil) src.bowl)
  =.  bio  [%accepted `@t`~]
  =.  guild  (~(put by guild) t.t.path (~(put by t.t.path) src.bowl bio))
  [%give %fact ~[/updates/guild/[t.t.path]] %people-update !>([%gil-info t.t.path guild])]
  ==
::
++  agent 
  |=  [=wire =sign:agent:gall]
  ^+  that
  ?+    wire  ~|(bad-agent-wire+wire !!)
    [%poke * ~]
  ?.  ?=(%poke-ack -.sign)  that
  ?~  p.sign  that
  %-  (slog 'Failed to poke ' `@t`(scot %p -.+.wire) ~)
  that
  ::
    [%guild * ~]
  ?~  p.sign
    ((slog 'Subscribe succeeded!' ~) that)
  ((slog 'Subscribe failed!' ~) that)
    %fact
  ?+  p.cage.sign  ~|(bad-agent-mar+p.cage.sign !!)
      %people-update  ::keep same update or new for guilds
    =+  !<(update q.cage.sign)
    ?+  -.update  that 
      %gil-info
    =,  update
    =.  (~(put by guild) name gil)
    that
    %kick
    ~&  'got kick'
    that
::
--
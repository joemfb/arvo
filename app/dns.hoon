/-  *dns
!:
::
::  moves and state
::
=>  |%
+$  move  (pair bone card)
+$  poke
  $%  [%dns-bind for=ship him=ship target]
      [%dns-bond for=ship him=ship turf]
      [%dns-authority authority]
      ::  XX find some other notification channel?
      ::
      [%helm-send-hi ship (unit tape)]
  ==
+$  card
  $%  [%tend wire ~]
      [%wait wire @da]
      [%poke wire dock poke]
      [%rule wire %turf %put turf]
      [%hiss wire [~ ~] %httr %hiss hiss:eyre]
  ==
::  +state: complete app state
::
+$  state
  $:  :: dom: the set of our bindings
      ::
      dom=(set turf)
      :: per: per-dependent ips &c
      ::
      per=(map ship relay)
      :: nem: authoritative state
      ::
      nem=(unit nameserver)
  ==
--
::
::  helpers
::
=>  |%
::  +join: dedup with :acme
::
++  join
  |=  [sep=@t hot=(list @t)]
  ^-  @t
  ?>  ?=(^ hot)
  %+  rap  3
  |-  ^-  (list @t)
  ?~  t.hot  hot
  [i.hot sep $(hot t.hot)]
::  +name: fully-qualified domain name
::
++  name
  |=  [him=ship dom=turf]
  (cat 3 (join '.' [(crip +:(scow %p him)) (flop dom)]) '.')
::  +endpoint: append path to purl
::
++  endpoint
  |=  [bas=purl:eyre pat=path]
  ^+  bas
  bas(q.q (weld q.q.bas pat))
::  +reserved: check if an ipv4 address is in a reserved range
::
++  reserved
  |=  a=@if
  ^-  ?
  =/  b  (flop (rip 3 a))
  ::  0.0.0.0/8 (software)
  ::
  ?.  ?=([@ @ @ @ ~] b)  &
  ?|  ::  10.0.0.0/8 (private)
      ::
      =(10 i.b)
      ::  100.64.0.0/10 (carrier-grade NAT)
      ::
      &(=(100 i.b) (gte i.t.b 64) (lte i.t.b 127))
      ::  127.0.0.0/8 (localhost)
      ::
      =(127 i.b)
      ::  169.254.0.0/16 (link-local)
      ::
      &(=(169 i.b) =(254 i.t.b))
      ::  172.16.0.0/12 (private)
      ::
      &(=(172 i.b) (gte i.t.b 16) (lte i.t.b 31))
      ::  192.0.0.0/24 (protocol assignment)
      ::
      &(=(192 i.b) =(0 i.t.b) =(0 i.t.t.b))
      ::  192.0.2.0/24 (documentation)
      ::
      &(=(192 i.b) =(0 i.t.b) =(2 i.t.t.b))
      ::  192.18.0.0/15 (reserved, benchmark)
      ::
      &(=(192 i.b) |(=(18 i.t.b) =(19 i.t.b)))
      ::  192.51.100.0/24 (documentation)
      ::
      &(=(192 i.b) =(51 i.t.b) =(100 i.t.t.b))
      ::  192.88.99.0/24 (reserved, ex-anycast)
      ::
      &(=(192 i.b) =(88 i.t.b) =(99 i.t.t.b))
      ::  192.168.0.0/16 (private)
      ::
      &(=(192 i.b) =(168 i.t.b))
      ::  203.0.113/24 (documentation)
      ::
      &(=(203 i.b) =(0 i.t.b) =(113 i.t.t.b))
      ::  224.0.0.0/8 (multicast)
      ::  240.0.0.0/4 (reserved, future)
      ::  255.255.255.255/32 (broadcast)
      ::
      (gte i.b 224)
  ==
--
::
::  service providers
::
=>  |%
:: |gcloud: provider-specific functions
::
++  gcloud
  |_  aut=authority
  ::  +base: provider service endpoint
  ::
  ++  base
    (need (de-purl:html 'https://www.googleapis.com/dns/v1/projects'))
  :: +record: JSON-formatted provider-specific dns record
  ::
  ++  record
    |=  [him=ship tar=target]
    ^-  json
    :: ?>  ?=([%gcloud *] pro.aut)
    =+  ^-  [typ=cord dat=cord]
      ?:  ?=(%direct -.tar)
        ['A' (crip +:(scow %if p.tar))]
      ['CNAME' (name p.tar dom.aut)]
    :-  %o  %-  my  :~
      name+s+(name him dom.aut)
      type+s+typ
      :: XX make configureable?
      ttl+n+~.300
      rrdatas+a+[s+dat ~]
    ==
  :: +request: provider-specific record-creation request
  ::
  ++  request
    =,  eyre
    |=  [him=ship tar=target pre=(unit target)]
    ^-  hiss
    :: ?>  ?=([%gcloud *] pro.aut)
    =/  url=purl
      %+  endpoint  base
      /[project.pro.aut]/['managedZones']/[zone.pro.aut]/changes
    =/  hed=math
      (my content-type+['application/json' ~] ~)
    =/  bod=octs
      %-  as-octt:mimes:html
      %-  en-json:html
      :-  %o  %-  my
      :-  additions+a+[(record him tar) ~]
      ?~  pre  ~
      [deletions+a+[(record him u.pre) ~] ~]
    [url %post hed `bod]
  --
--
::
::  the app itself
::
|_  [bow=bowl:gall state]
::  +this: is sparta
::
++  this  .
::  +poke-noun: debugging
::
++  poke-noun
  |=  a=*
  ^-  (quip move _this)
  ~&  +<+:this
  [~ this]
::  +sigh-httr: accept http response
::
++  sigh-httr
  |=  [wir=wire rep=httr:eyre]
  ^-  (quip move _this)
  ?-  wir
      [%authority %confirm ~]
    ?~  nem
      ~&  [%strange-authority wire=wir response=rep]
      [~ this]
    ?.  =(200 p.rep)
      ~&  [%authority-confirm-fail rep]
      [~ this(nem ~)]
    :: XX anything to do here? parse body?
    [~ this]
  ::
      [%authority %create @ %for @ ~]
    ?~  nem
      ~&  [%strange-authority wire=wir response=rep]
      [~ this]
    ?.  =(200 p.rep)
      ~&  [%authority-create-fail wire=wir response=rep]
      [~ this]
    =/  him=ship  (slav %p i.t.t.wir)
    =/  for=ship  (slav %p i.t.t.t.t.wir)
    abet:(~(confirm bind u.nem) for him)
  ::
      [%check @ ~]
    =/  him=ship  (slav %p i.t.wir)
    ?:  =(200 p.rep)
      abet:~(bind tell [him (~(get by per) him)])
    :: cttp timeout
    ?:  =(504 p.rep)
      :: XX backoff, refactor
      :_  this  :_  ~
      [ost.bow %wait wir (add now.bow ~m10)]
    :: XX specific messages per status code
    ~&  %direct-confirm-fail
    abet:(~(fail tell [him (~(get by per) him)]) %failed-request)
  ::
      *
    ~&  +<
    [~ this]
  ==
::  +sigh-tang: failed to make http request
::
++  sigh-tang
  |=  [wir=wire saw=tang]
  ^-  (quip move _this)
  ~&  [%sigh-tang wir]
  ?+  wir
        [((slog saw) ~) this]
  ::
      [%authority %confirm ~]
    ~&  %authority-confirm-fail
    [((slog saw) ~) this(nem ~)]
  ::
      [%check @ ~]
    ~&  %direct-confirm-fail
    =/  him=ship  (slav %p i.t.wir)
    %-  (slog saw)
    abet:(~(fail tell [him (~(get by per) him)]) %crash)
  ==
::  +wake: timer callback
::
++  wake
  |=  [wir=wire ~]
  ^-  (quip move _this)
  ?.  ?=([%check @ ~] wir)
    ~&  [%strange-wake wir]
    [~ this]
  =/  him=ship  (slav %p i.t.wir)
  abet:~(check tell [him (~(get by per) him)])
::  +poke-dns-authority: configure self as an authority
::
++  poke-dns-authority
  |=  aut=authority
  ^-  (quip move _this)
  ~|  %authority-reset-wat-do
  ?<  ?=(^ nem)
  abet:(init:bind aut)
::  +poke-dns-bind: create binding (if authority), forward request
::
++  poke-dns-bind
  |=  [for=ship him=ship tar=target]
  ^-  (quip move _this)
  ~&  [%bind src=src.bow +<.$]
  =/  lan  (clan:title him)
  ?:  ?=(%czar lan)
    ~|(%bind-galazy !!)
  ?:  =(for him)
    ~|(%bind-yoself !!)
  ?:  ?&  ?=(%king lan)
          ?=(%indirect -.tar)
      ==
    ~|(%bind-indirect-star !!)
  :: always forward, there may be multiple authorities
  ::
  =^  zom=(list move)  ..this
    abet:(~(forward tell [him (~(get by per) him)]) for tar)
  =^  zam=(list move)  ..this
    ?~  nem  [~ this]
    abet:(~(create bind u.nem) for him tar)
  [(weld zom zam) this]
::  +poke-dns-bond: process established dns binding
::
++  poke-dns-bond
  |=  [for=ship him=ship dom=turf]
  ^-  (quip move _this)
  ?:  =(for him)
    ~|(%bond-yoself !!)
  ?:  =(our.bow him)
    ~&  [%bound-us dom]
    :-  [[ost.bow %rule /bound %turf %put dom] ~]
    this(dom (~(put in ^dom) dom))
  ?:  =(our.bow for)
    ~&  [%bound-him him dom]
    =<  abet
    (~(bake tell [him (~(get by per) him)]) dom)
  ~&  [%strange-bond +<]
  [~ this]
::  +coup: general poke acknowledgement or error
::
++  coup
  |=  [wir=wire saw=(unit tang)]
  ?~  saw  [~ this]
  ~&  [%coup-fallthru wir]
  [((slog u.saw) ~) this]
::  +rove: hear %ames +lane change for child ships
::
++  rove
  |=  [wir=wire p=ship q=lane:ames]
  ^-  (quip move _this)
  :: XX move to %ames
  ?:  =(our.bow p)
    [~ this]
  ?.  =(our.bow (sein:title our.bow now.bow p))
    ~&  [%rove-false p]
    [~ this]
  ~&  [%rove wir p q]
  ::  XX assert that we intend to be listening?
  =<  abet
  (~(hear tell [p (~(get by per) p)]) q)
::  +prep: adapt state
::
::  ++  prep  _[~ this]
++  prep
  |=  old=(unit state)
  ^-  (quip move _this)
  ?^  old
    [~ this(+<+ u.old)]
  ?:  ?=(?(%czar %king) (clan:title our.bow))
    abet:listen:tell
  [~ this]
::  |bind: acting as zone authority
::
++  bind
  =|  moz=(list move)
  |_  nam=nameserver
  ++  this  .
  ::  +abet: finalize state changes, produce moves
  ::
  ++  abet
    ^-  (quip move _^this)
    [(flop moz) ^this(nem `nam)]
  ::  +emit: emit a move
  ::
  ++  emit
    |=  car=card
    ^+  this
    this(moz [[ost.bow car] moz])
  ::  +init: establish zone authority (request confirmation)
  ::
  ++  init
    |=  aut=authority
    :: ?>  ?=(%gcloud pro.aut)
    =/  wir=wire  /authority/confirm
    =/  url=purl:eyre
      %+  endpoint  base:gcloud
      /[project.pro.aut]/['managedZones']/[zone.pro.aut]
    ~&  url
    %-  emit(nam [aut ~ ~])
    [%hiss wir [~ ~] %httr %hiss url %get ~ ~]
  ::  +create: bind :him, on behalf of :for
  ::
  ++  create
    |=  [for=ship him=ship tar=target]
    :: XX defer %indirect where target isn't yet bound
    ?>  ?|  ?=(%direct -.tar)
            (~(has by bon.nam) p.tar)
        ==
    =/  wir=wire
      /authority/create/(scot %p him)/for/(scot %p for)
    =/  pre=(unit target)
      =/  bon=(unit bound)  (~(get by bon.nam) him)
      ?~(bon ~ `cur.u.bon)
    :: ?>  ?=(%gcloud pro.aut.nam)
    =/  req=hiss:eyre
      (~(request gcloud aut.nam) him tar pre)
    %-  emit(pen.nam (~(put by pen.nam) him tar)) :: XX save for
    [%hiss wir [~ ~] %httr %hiss req]
  ::  +confirm: successfully bound
  ::
  ++  confirm
    |=  [for=ship him=ship]
    =/  tar=target  (~(got by pen.nam) him)
    =/  bon=(unit bound)
      (~(get by bon.nam) him)
    =/  nob=bound
      [now.bow tar ?~(bon ~ [[wen.u.bon cur.u.bon] hit.u.bon])]
    =.  pen.nam  (~(del by pen.nam) him)
    =.  bon.nam  (~(put by bon.nam) him nob)
    =/  wir=wire
      /bound/(scot %p him)/for/(scot %p for)
    =/  dom=turf
      (weld dom.aut.nam /(crip +:(scow %p him)))
    %-  emit
    [%poke wir [for dap.bow] %dns-bond for him dom]
  --
::  |tell: acting as planet parent or relay
::
++  tell
  =|  moz=(list move)
  |_  [him=ship rel=(unit relay)]
  ++  this  .
  ::  +abet: finalize state changes, produce moves
  ::
  ++  abet
    ^-  (quip move _^this)
    :-  (flop moz)
    ?~  rel
      ^this
    ^this(per (~(put by per) him u.rel))
  ::  +emit: emit a move
  ::
  ++  emit
    |=  car=card
    ^+  this
    this(moz [[ost.bow car] moz])
  ::  +listen: subscribe to %ames +lane changes for child ships
  ::
  ++  listen
    ^+  this
    (emit [%tend /tend ~])
  ::  +hear: hear +lane change, maybe emit binding request
  ::
  ++  hear
    |=  lan=lane:ames
    ^+  this
    =/  adr=(unit @if)
      ?.(?=([%if *] lan) ~ `r.lan)
    =/  tar=target
      ?:  ?|  ?=(~ adr)
              ?=(%duke (clan:title him))
          ==
        [%indirect our.bow]
      [%direct %if u.adr]
    ?.  ?|  ?=(~ rel)
            !=(tar tar.u.rel)
            !bon.u.rel
        ==
      this
    =.  rel  `[wen=now.bow adr bon=| try=0 tar]
    ?:(?=(%indirect -.tar) bind check)
  ::  +check: confirm %direct target is accessible
  ::
  ++  check
    ^+  this
    ?>  ?=(^ rel)
    ?>  ?=(%direct -.tar.u.rel)
    ?:  (reserved p.tar.u.rel)
      (fail %reserved-ip)
    ?:  (gth try.u.rel 2)
      (fail %unreachable)
    =.  try.u.rel  +(try.u.rel)
    =/  wir=wire
      /check/(scot %p him)
    =/  url=purl:eyre
      :-  [sec=| por=~ host=[%| `@if`p.tar.u.rel]]
      [[ext=`~.md path=~] query=~]
    :: XX state mgmt
    %-  emit
    [%hiss wir [~ ~] %httr %hiss url %get ~ ~]
  ::  +fail: %direct target is invalid or inaccessible
  ::
  ++  fail
    |=  err=@tas
    ^+  this
    ?>  ?=(^ rel)
    ~&  [%fail err him tar.u.rel]
    =/  wir=wire
      /fail/(scot %p him)
    =/  msg=tape
      ?+  err
            "dns binding failed"
      ::
          %reserved-ip
        ?>  ?=(%direct -.tar.u.rel)
        "unable to create dns binding reserved address {(scow %if p.tar.u.rel)}"
      ==
    :: XX state mgmt
    %-  emit
    [%poke wir [our.bow %hood] %helm-send-hi him `msg]
  ::  +bind: request binding for target
  ::
  ::    Since we may be an authority, we poke ourselves.
  ::
  ++  bind
    ^+  this
    ?>  ?=(^ rel)
    :: XX state mgmt
    =/  wir=wire
      /bind/(scot %p him)/for/(scot %p our.bow)
    %-  emit
    [%poke wir [our.bow dap.bow] %dns-bind our.bow him tar.u.rel]
  ::  +bake: successfully bound
  ::
  ++  bake
    |=  dom=turf
    ~&  [%bake dom]
    ^+  this
    ?>  ?=(^ rel)
    =/  wir=wire
      /forward/bound/(scot %p him)/for/(scot %p our.bow)
    :: XX save domain, track bound-state per-domain
    %-  emit(bon.u.rel &)
    [%poke wir [him dap.bow] %dns-bond our.bow him dom]
  ::  +forward: sending binding request up the network
  ::
  ++  forward
    |=  [for=ship tar=target]
    ~&  [%forward tar]
    ^+  this
    ?:  ?=(%~zod our.bow)  ::  ~zod don't forward
      ~&  [%zod-no-forward him tar]
      this
    =/  to=ship
      ?-  (clan:title our.bow)
        %czar  ~zod
        *      (sein:title [our now our]:bow)
      ==
    =/  wir=wire
      /forward/bind/(scot %p him)/for/(scot %p for)
    %-  emit  :: XX for
    [%poke wir [to dap.bow] %dns-bind for him tar]
  --
--

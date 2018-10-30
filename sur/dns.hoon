|%
::  +provider: DNS service provider (gcloud only for now)
::
+$  provider
  $%  [%gcloud project=@ta zone=@ta]
  ==
::  +authority: responsibility for a DNS zone
::
+$  authority
  $:  :: dom: authority over a fully-qualified domain
      ::
      dom=turf
      :: pro: DNS service provider
      ::
      pro=provider
  ==
::  +target: a ship is bound to a ...
::
+$  target
  $%  :: %direct: an A record
      ::
      [%direct %if p=@if]
      :: %indirect: a CNAME record
      ::
      [%indirect p=ship]
  ==
::  +bound: an established binding, plus history
::
+$  bound
  $:  :: wen: established
      ::
      wen=@da
      :: cur: current target
      ::
      cur=target
      :: hit: historical targets
      ::
      hit=(list (pair @da target))
  ==
::  +nameserver: a b s o l u t e  p o w e r
::
+$  nameserver
  $:  aut=authority
      pen=(map ship target)
      bon=(map ship bound)
  ==
::  +relay: a good parent keeps track
::
+$  relay
  $:  wen=@da
      wer=(unit @if)
      bon=?
      try=@ud
      tar=target
  ==
::  +command: top-level app actions
::
+$  command
  $%  [%authority aut=authority]
      [%bind for=ship him=ship tar=target]
      [%bond for=ship him=ship dom=turf]
      [%ip %if addr=@if]
      [%meet him=ship]
  ==
--

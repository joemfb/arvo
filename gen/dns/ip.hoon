::  DNS: configure ip address
::
::::  /hoon/authority/dns/gen
  ::
/-  *dns, *sole
:-  %ask
|=  $:  [now=@da eny=@uvJ bec=beak]
        [arg=$@(~ [addr=@if ~])]
        ~
    ==
^-  (sole-result [%dns-command command])
=*  our  p.bec
=-  ?~  arg  -
    (fun.q.q addr.arg)
%+  sole-lo
  [%& %dns-address "ipv4 address: "]
%+  sole-go
  `$-(nail (like @if))`;~(pfix dot lip:ag)
|=  addr=@if
%-  sole-so
[%dns-command %ip %if addr]

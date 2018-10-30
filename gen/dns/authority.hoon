::  DNS: configure zone authority
::
::::  /hoon/authority/dns/gen
  ::
/-  *dns, *sole
:-  %ask
|=  $:  [now=@da eny=@uvJ bec=beak]
        [arg=$@(~ [dom=turf ~])]
        ~
    ==
^-  (sole-result [%dns-command %authority authority])
=-  ?~  arg  -
    (fun.q.q [%& dom.arg])
%+  sole-lo
  [%& %dns-domain "dns domain: "]
%+  sole-go  thos:de-purl:html
|=  hot=host:eyre
?:  ?=(%| -.hot)
  ~|(%ips-unsupported !!)
%+  sole-lo
  [%& %project "gcloud project: "]
%+  sole-go  urs:ab
|=  project=@ta
%+  sole-lo
  [%& %zone "dns zone: "]
%+  sole-go  urs:ab
|=  zone=@ta
%-  sole-so
[%dns-command %authority [p.hot %gcloud project zone]]

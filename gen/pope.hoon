::  Create a galactic generator and ames-ready fingerprint
::
::::  /hoon/pope/gen
  ::
/?    310
::  Input twitter keys
/-    sole
/+  old-zuse
=,  old-zuse
::
=+  cryp=crub
=+  [sole]
:-  %ask
|=  $:  {now/@da eny/@uvJ bec/beak}
        {{who/ship ~} ~}
    ==
^-  (sole-result (cask tang))
%+  sole-yo  leaf+"generating carrier {(scow %p who)} (#{(scow %ud who)})"
%+  sole-lo  [%| %pope-pass "passphrase: "]
%+  sole-go  (boss 256 (star prn))
|=  fra/@t
=+  bur=(shaz (add who (shaz fra)))
=+  arc=(pit:nu:cryp 512 bur)
%+  sole-so  %tang
=/  pub=pass  pub:ex:arc
=/  mag=cord  (end 3 1 pub)
?>  =('b' mag)
=/  bod=@  (rsh 3 1 pub)
=/  cry=@  (rsh 8 1 bod)
=/  sgn=@  (end 8 1 bod)
:~  leaf+"generator: {(scow %uw bur)}"
    leaf+"  authentication: 0x{(render-hex-bytes:ethereum 32 sgn)}"
    leaf+"  networking:     0x{(render-hex-bytes:ethereum 32 cry)}"
    leaf+"ethereum public keys:"
    leaf+"fingerprint: {(scow %uw fig:ex:arc)}"
==

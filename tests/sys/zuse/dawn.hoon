/+  *test
|%
::  example hull for ~zod
::
++  hul
  ^-  hull:constitution:ethe
  :+  [0x0 0x0 0x0 0x0]
    :*  ~
        life=1
         pass=2.448.360.348.730.164.860.814.441.775.703.143.856.915.192.920.
        639.124.529.297.987.279.849.833.790.775.864.413.949.853.880.667.744.
        188.597.545.066.664.466.963.044.328.182.155.965.137.512.758.548.384.
        637.214.562
        continuity-number=0
        sponsor=[~ u=~zod]
        escape=~
    ==
  [~ u=[spawn-proxy=0x0 spawn-count=2 spawned=~]]
::  secret key for ~zod
::
++  sec
  ^-  ring
  0w8.Ugyke.eUOf2.NcHRo.tZA7r.P8vP6.DGKp4.yn-BI.etdzb.ucv75.WgRob.H1-7n.
  4qCje.gc7z7.1i-3T.9~8UR.IGkGH.6NWR2
::  Ships contract address
::
++  ships
  %-  crip
  %+  weld  "0x"
  (render-hex-bytes:ethereum 20 `@`ships:contracts:constitution:ethe)
:: this produces a 1000+ line payload, so we just check that it doesn't crash
::
++  test-give-czar
  =/  zar  czar:give:dawn
  ~!  zar
  %+  expect-eq
    !>  &
    !>  ?=(^ zar)
::
++  test-give-hull
  =/  oct
    %-  as-octs:mimes:html
    %+  rap  3
    :~  '{"jsonrpc":"2.0","method":"eth_call","params":[{"data":"'
        '0xb3220694'
        '0000000000000000000000000000000000000000000000000000000000000000'
        '","to":"'  ships  '"},"latest"]}'
    ==
  %+  expect-eq
    !>  oct
    !>  (hull:give:dawn ~zod)
::
++  test-give-turf
  =/  oct
    %-  as-octs:mimes:html
    %+  rap  3
    :~  '[{"jsonrpc":"2.0","id":"0","method":"eth_call","params":[{"data":"'
        '0xeccc8ff1'
        '0000000000000000000000000000000000000000000000000000000000000000'
        '","to":"'  ships  '"},"latest"]},'
        '{"jsonrpc":"2.0","id":"1","method":"eth_call","params":[{"data":"'
        '0xeccc8ff1'
        '0000000000000000000000000000000000000000000000000000000000000001'
        '","to":"'  ships  '"},"latest"]},'
        '{"jsonrpc":"2.0","id":"2","method":"eth_call","params":[{"data":"'
        '0xeccc8ff1'
        '0000000000000000000000000000000000000000000000000000000000000002'
        '","to":"'  ships  '"},"latest"]}]'
    ==
  %+  expect-eq
    !>  oct
    !>  turf:give:dawn
::
++  test-take-czar
  =/  oct
    %-  as-octs:mimes:html
    %+  rap  3
    :~  '[{"id":"0","jsonrpc":"2.0","result":"'
        '0xb69b6818b17b7cc22f8e0a2291f58e4aa840cbf44cb2f1c94dc3d71e3cda0d94'
          '3defb87516f42ce4327820b588002aa53e52527af8d23bee4aa215fa296bdf5f'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000001'
        '"},{"id":"1","jsonrpc":"2.0","result":"'
        '0xb727e38d031162e50913b2e37a2e29d4ba457eff4f7fd4ac47dc68fcb54260d3'
          'b8bfe4789483c171f7fa359438cdcc8d268d40fe08d6c1d8b36267748d2139f8'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000001'
        '"},{"id":"2","jsonrpc":"2.0","result":"'
        '0x0000000000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000000'
        '"}]'
    ==
  =/  kyz
    ^-  [zod=pass nec=pass]
    :-  2.448.360.348.730.164.860.814.441.775.703.143.856.915.192.920.639.124.
      529.297.987.279.849.833.790.775.864.413.949.853.880.667.744.188.597.545.
      066.664.466.963.044.328.182.155.965.137.512.758.548.384.637.214.562
    ::
      2.455.718.000.840.284.920.492.237.722.671.938.413.341.955.411.945.312.
    638.361.167.187.097.711.481.986.932.531.569.955.478.938.087.263.286.158.
    823.313.739.767.009.446.819.531.923.255.637.798.148.055.143.938.146
  %+  expect-eq
    !>  %-  ~(gas by *(map ship [=life =pass]))
        [[~zod 1 zod.kyz] [~nec 1 nec.kyz] ~]
    !>  (czar:take:dawn oct)
::
++  test-take-hull
  =/  oct
    %-  as-octs:mimes:html
    %+  rap  3
    :~  '{"jsonrpc":"2.0","result":"'
        '0x0000000000000000000000000000000000000000000000000000000000000001'
          'b69b6818b17b7cc22f8e0a2291f58e4aa840cbf44cb2f1c94dc3d71e3cda0d94'
          '3defb87516f42ce4327820b588002aa53e52527af8d23bee4aa215fa296bdf5f'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '0000000000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000000'
        '"}'
    ==
  %+  expect-eq
    !>  hul
    !>  (hull:take:dawn ~zod oct)
::
++  test-take-turf
  =/  oct
    %-  as-octs:mimes:html
    %+  rap  3
    :~  '[{"id":"0","jsonrpc":"2.0","result":"'
        '0x0000000000000000000000000000000000000000000000000000000000000020'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '75726269742e6f72670000000000000000000000000000000000000000000000'
        '"},{"id":"1","jsonrpc":"2.0","result":"'
        '0x0000000000000000000000000000000000000000000000000000000000000020'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '75726269742e6f72670000000000000000000000000000000000000000000000'
        '"},{"id":"2","jsonrpc":"2.0","result":"'
        '0x0000000000000000000000000000000000000000000000000000000000000020'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '75726269742e6f72670000000000000000000000000000000000000000000000'
        '"}]'
    ==
  %+  expect-eq
    !>  [/org/urbit ~]
    !>  (turf:take:dawn oct)
::
++  test-veri-good
  =/  sed  [~zod 1 sec ~]
  %+  expect-eq
    !>  [%& sed `~zod]
    !>  (veri:dawn sed hul ~)
::
++  test-veri-not-spawned
  =/  sed  [~zod 1 sec ~]
  %+  expect-eq
    !>  [%| %czar %not-keyed]
    !>  (veri:dawn sed =>(hul .(net ~)) ~)
::
++  test-veri-wrong-key
  =/  sed  [~zod 1 sec:ex:(pit:nu:crub:crypto 24 %foo) ~]
  %+  expect-eq
    !>  [%| %czar %key-mismatch]
    !>  (veri:dawn sed hul ~)
::
++  test-veri-already-booted
  =/  sed  [~zod 1 sec ~]
  ;:  weld
    %+  expect-eq
      !>  [%| %czar %already-booted]
      !>  (veri:dawn sed hul `[1 |])
  ::
    %+  expect-eq
      !>  [%| %czar %already-booted]
      !>  (veri:dawn sed hul `[2 &])
  ==
::
++  test-veri-earl-good
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who  ~simtel-mithet-dozzod-dozzod
  =/  sed
    =/  sig
      %-  sign:as:(nol:nu:crub:crypto sec)
      (shaf %earl (sham 1 pub:ex:cub))
    [who 1 sec:ex:cub `sig]
  %+  expect-eq
    !>  [%& sed ~]
    !>  (veri:dawn sed hul ~)
::
++  test-veri-earl-missing-sig
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who  ~simtel-mithet-dozzod-dozzod
  =/  sed
    [who 1 sec:ex:cub ~]
  %+  expect-eq
    !>  [%| %earl %missing-sig]
    !>  (veri:dawn sed hul ~)
::
++  test-veri-earl-parent-not-keyed
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who  ~simtel-mithet-dozzod-dozzod
  =/  sed
    =/  sig
      %-  sign:as:(nol:nu:crub:crypto sec)
      (shaf %earl (sham 1 pub:ex:cub))
    [who 1 sec:ex:cub `sig]
  %+  expect-eq
    !>  [%| %earl %parent-not-keyed]
    !>  (veri:dawn sed =>(hul .(net ~)) ~)
::
++  test-veri-earl-invalid-sig
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who  ~simtel-mithet-dozzod-dozzod
  ;:  weld
    =/  sed
      =/  sig
        %-  sign:as:cub
        (shaf %earl (sham 1 pub:ex:cub))
      [who 1 sec:ex:cub `sig]
    %+  expect-eq
      !>  [%| %earl %invalid-sig]
      !>  (veri:dawn sed hul ~)
  ::
    =/  sed
      =/  sig
        %-  sign:as:(nol:nu:crub:crypto sec)
        (shaf %earl (sham 2 pub:ex:cub))
      [who 1 sec:ex:cub `sig]
    %+  expect-eq
      !>  [%| %earl %invalid-sig]
      !>  (veri:dawn sed hul ~)
  ==
::
++  test-veri-earl-already-booted
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who  ~simtel-mithet-dozzod-dozzod
  =/  sed
    =/  sig
      %-  sign:as:(nol:nu:crub:crypto sec)
      (shaf %earl (sham 1 pub:ex:cub))
    [who 1 sec:ex:cub `sig]
  %+  expect-eq
    !>  [%| %earl %already-booted]
    !>  (veri:dawn sed hul `[1 |])
::
++  test-veri-pawn-good
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who=ship  `@`fig:ex:cub
  =/  sed  [who 1 sec:ex:cub ~]
  %+  expect-eq
    !>  [%& sed ~]
    !>  (veri:dawn sed *hull:constitution:ethe ~)
::
++  test-veri-pawn-key-mismatch
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who=ship  `@`fig:ex:cub
  =/  sed  [who 1 sec:ex:(pit:nu:crub:crypto 24 %bar) ~]
  %+  expect-eq
    !>  [%| %pawn %key-mismatch]
    !>  (veri:dawn sed *hull:constitution:ethe ~)
::
++  test-veri-pawn-invalid-life
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who=ship  `@`fig:ex:cub
  =/  sed  [who 2 sec:ex:cub ~]
  %+  expect-eq
    !>  [%| %pawn %invalid-life]
    !>  (veri:dawn sed *hull:constitution:ethe ~)
::
++  test-veri-pawn-already-booted
  =/  cub  (pit:nu:crub:crypto 24 %foo)
  =/  who=ship  `@`fig:ex:cub
  =/  sed  [who 1 sec:ex:cub ~]
  %+  expect-eq
    !>  [%| %pawn %already-booted]
    !>  (veri:dawn sed *hull:constitution:ethe `[1 |])
--
"
RTCharterExample new installTitle: 'SimpleCurve' 
		code:
		'
	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 400.
	b shape ellipse color: (Color blue alpha: 0.5).
	b points: (0.0 to: 1.0 by: 0.05).
	b curve.

	b y: [ :v | v sqrt ].
		
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas'
	
"
Class {
	#name : #RTCharterExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #sources }
RTCharterExample >> exampleFunctions [

	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 400.
	
	(Array with: Color red with: Color blue with: Color green with: Color yellow) doWithIndex: [ :color :i |
		b shape ellipse size: 0.
		b points: ((0.0 to: 10.0 by: 0.1) collect: [ :v | v raisedTo: i ]).
		b curveUsing: (RTLine new color: color).
	].

	b y: #yourself.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleFunctionsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEgUlEQVR4XuXdfU/aUBQGcD7q
vsj+RZ3JEpZApI4wjTMajbBkI+MlikNXHUQRYyMYAtPgEl9gOiTGzOPurdLg1FlKW854zs0J
ubHBeH/t7ctpq+fmBj84hQd/CPBB8AMfBB8EP/BB8EHwAx8ECCSZTFImk6F0Ok35fJ68Xi/5
/X7y+Xz3PtvLHx4ekkz8IXQIREJIlHg8rsNIAEVRKBAIUCgUomAwqPfby7daLZKJP4TWgihH
+FMWK5ANfBBeICF8EF4gLXwQ7vsPfBBm+w98kL6BvMMH4QVC+CB8MCbI1IkhfrgFUsIH4QWy
iA/C/dwDH4Tp/gMfxHWQWXwQXiA/8UH4YERNlSrwQVwD2cYH4QWygQ/CB2PPdGX1HsjMzIxe
sj07O6NsNmvU2Nv9zmXxa+rdgOStgaytrVGhUKDh4WFaWloyauybm5t6v3NZ/Jp6NyDT1kDw
wwmMi65WWnwQx0Hm8UF4gbzHB+GDcdX1PhYfhNF0hQ/CbLrCB2E2XeGDMJuu8EGYTVf4II5h
/LJ8BQMfxBGQDD4IL5BFfBA+GImeLrjig9gOsowPwgvkAh+ED0ak5/oQPoitIAv4IHwwtm2p
nhogkUhEr5HLx6GHhobwa+pdg8TtBZG19NHRUf0mB4mCX1PvBuM3EV3bC4IfvYCkbFsx8UFs
AVnBBxmkQ118EFtBYvggfDA+2n5Qgw/SE0gUH4QPxrojh/z4IJZBPuGD8MFIO3ZCjA9iCeQz
PsigT1X4IJZBlvFB+GAkHb+Yig9iGuNaXNGt4YPwAZl3pdSAD2IKY9W1ug8+iCmQDD4IH4yQ
q1VRA2RnZ4disRj+c+p9mqoegGiaRqlUCv85dQPjisy+DgN/ynIFJNqXlQ0f5FGMVN+2fHwQ
BvsNfJAnMU7FfmMXH4QHRp3cPN/AB/knxjHZeW8VPsiAYMCDEDVYTFP4IDpGlR0GLAhRgcy8
QxcfxBWMt6wv93hwIHJiq8j2FaMmKo5zd60uGixIv7aKToCayfKvZ7AhEmKrOCHOABAg8nk/
pyGa1KRx0QqiTYhWs+kGCM9g7SNKjkDINX5ZtD3RpkXTRMPfqT8AaIrBHxf5Tc9evmtVXOFN
iNa5xksAuRXgH2U9CTCun8iZBZCDmbhr7QEui9bZ78eAWwKR/0+92WwaNfXHltnf3yeZ1ZOV
nvLgNEPfTzJUPv6qp1qZFPmK0scvaL0cEFmgSqVyIz9lzqoJ8qmTRo6oCr1Ww6Soc3pq6g89
1XSDSuu17nLjgMrFqtEvpnbpwxvNdEZ9GoVeapRQns/ClxI1Gg1zIBJia2vLqKk/tszR0RHJ
dGOtkSBuhLxHwK0bNySGaRD8+M/O1M1Mab2G3Pqq1SotLNy+0OXvvl0xNTWlT71jY2NUr9ep
3Zc/k3fi2HqeUrs9NJbj5/V6ye/3U+d4WgYxM6X1Gufn55TL5WhkZISKxSJ19u38PeFwWL/t
KRgM6p/tvny9iN1/0+XlJcmU4ye/X1EU/W+T/fYtVfhT1iBMWfiBD4IPgh/4IPiBD4IPgh/P
xB+OyefbraC3AwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTCharterExample >> exampleHistogram [

	| b |
	b := RTCharterBuilder new.
	b extent: 500 @ 100.
	
	b interaction popup.
	b points: RTShape withAllSubclasses.
	b allY: [ :c | c methods size ].
	b shape rectangle color: Color blue.
	b stackX.
	b histogramBarWidth: 10.
	
	b axisX.
	b axisYWithNumberOfTicks: 4.
	
	b open.
	b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleHistogramIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACAElEQVR4XuXZsY6CMACAYd7Y
wcHBwUfzZYgrhkESBrhUF1IJxMJRyPcnjbnkTrCftMoVfe+3pwp/CnwQPx/EB/HzQXwQPx/E
B/HzQXwQPx/EzwfxQfx8EB/EzwfxQfx8EB/Ezwfx80F8ED8fxAfx80F8ED8fxAfx80H8fBAf
xM8H8UH8fBAfxM8H8UH8fBC/OZDX69WFkfJkbdt2YfjTuiLI4/HoyrJMmtSi+Ay/lZes1CvE
B/FBfJCqqnyQrTf15/M5CnK7fSY8PKaAhP3Jn/IVN/UlIHN/65ewZMWTer223flcd2Mg93vf
n07V+/GoIOG1hdd4GJD4ihj+HP/uEUFy7InZQC6X5j18kB839eFluybIET6R7QIk3tSnJtkH
ybBk+SA+yFfhhmVd150PshOQXFfT1HH/600yu6n7INue0yE29a1Awjt++K5fApJ6m2g3S9bw
43X8LX8JyNT3nbnjpIIs+RK8G5BfjpO67MzdzvFBNgZZck7ZQHJt6r8cZ2p5m7rhueSc5pa3
qTsa8TkNl9Gv5x3bjMJomsYfGYb//7293R3wp8AH8fNBfBA/H8QH8fNBfBA/H8QH8fNB/HwQ
H8TPB/FB/HwQH8TPB/FB/HwQPx/EB/HzQXwQPx/EB/HzQXwQPx/EzwfxQfx8EB/EzwfxQfx8
EB/Ezwfxi/oDACwuepoiEkEAAAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> exampleMethodSize [

	| b classes normalizer |
	b := RTCharterBuilder new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| data |
		data := ((c methods reverseSortedAs: #numberOfLinesOfCode ) collect: [ :m | m numberOfLinesOfCode ]).
		b shape ellipse size: 0.
		b points: data.
		b connectDotColor: (normalizer rtValue: c).
	].

	b allY: #yourself.
	b stackX.

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
]

{ #category : #sources }
RTCharterExample >> exampleMethodSize2 [

	| b classes normalizer |
	b := RTCharterBuilder new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| data |
		data := (c methods reverseSortedAs: #numberOfLinesOfCode ).
		
		b interaction popup.
		b shape rectangle color: (normalizer rtValue: c).
		b points: data.
		b connectDotColor: (normalizer rtValue: c).
	].

	b allY: #numberOfLinesOfCode.
	b stackX.

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleMethodSize2Icon [
	^ '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'
]

{ #category : #icons }
RTCharterExample >> exampleMethodSizeIcon [
	^ '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
AElFTkSuQmCC'
]

{ #category : #sources }
RTCharterExample >> exampleScatterPlot [

	| b |

	b := RTCharterBuilder new.
	b extent: 290 @ 200.
	b interaction popup.
	b shape ellipse size: 15; color: (Color red alpha: 0.3).
	b points: RTObject withAllSubclasses.
	b x: #numberOfMethods; y: #numberOfVariables min: 0 max: 10.
	b size: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
	
]

{ #category : #icons }
RTCharterExample >> exampleScatterPlotIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEX0lEQVR4XuWc20pbQRSGfRBf
oHc+Qh+iF70qpd71IPgEXigUL0QEFbWoBe96UKhoTesBEi2C4AkUtZXYakXtSWtikdbfzpok
smtj467RaL4fhu2OZkjmc601/xqSksNDvi6TSvhLwAfCFx8IHwhffCB8IHzxgfCB8MUHwgfC
Fx8IX3wgfCB88YHwgfDFB8IHwhcfCB8IX3wgfPGB8IHwxQfCB8IXHwgfCF98IHwgIVVZWamG
hgY1NTXJ7qenp5VIJHT879bX12XjX3NpbU0aGhIfxxmAVFdXq7W1VW1tbVpcXFQsFtPe3t5f
i7q9vZ318T+A/Pghg8LHcQEpKxcMvvhA+ED4y8wHwgfCB8IHwgdyXkC0uioNDkovXogPhB8h
xQMkEon4xW5ubj5x0dec4cvl1PnKExBrnSwtLWl2dlaNjY1ZF/00Tp0vfsriA8lV0Pko+BHC
B/JHZExNHT2uz5+l8XE+uIICCTwuk4PCx3GFUpadmfCB5BmId+OuiGdd8H+4dHcChnHx/KJe
TECWl5eVMYiZs/XTOHW9e6dgCpIzj4pG/bm63r/3gw8kpDY3N936DXmnbq2T9vb2Uzv1bPXA
Q/nwQUok/OADKXDKIkO4dEB8VNTUHBV88yiC1h5+UUdve9PFXF1d0sKCTnLuV1H69ElXD0i6
mPtWya9fOsm58yOEn7LATv3GDenuXamiwrtvfvudHyHFCSSZTKqlpSX0mbqePJFzkVJnp1Rb
e9R291vdrS2pp0d8IP+zq3AaGBgIfaauL1+k798l5/R9ukq33a2o6+DAu3U+kAKkrKAzP95K
0coKv3VynkDk0ptKS6Vr16Rbt6QHD6Tycvk0FWitB6+Kx/lOnVLU9fOn1N+f2uV9/ChehMRi
UlWV9OiRVF8v3bwpvXqVipDAR9ns9xcCxHUJPIz0QEaIvn1LpS4r5L29slaDvw8Ucb19ezFA
3DnOEZCXL4VPWcGiXaizcg/FIuVYC4eRssrKpJIS6c4dqaNDun9fFg16/lx6+JBvHAuSsgzM
GT5pq9HRlJl8+lT56qwWFZCdnR1NTEzkPFNfcelp7c0b7V2/ruS9e0o+fqykc/YGKsxIuny/
9fq1H8mxsdDPzzbi8fhhPuaxYR2JfOwo/xvI7u6uRkZGcp6p2wvdnpmRbt9O7bTs52g09AvX
s2f62t2tr5GIlP5HOKsMSL5k7aGCArnwImy7sjQMEz9lnVNKy6W+vj7t7+/LvsojeD/jIi3s
XDbH3Nyc84T9slQ6PDzsr90u8jL3YV+bXXvdNr7HNUUtQoLv+1IBOW1KyyVrYNobtK/ysK/w
yNyPuToSdi6bY35+3h2/DGpyclJ1dXX+Wuu6zpn7MPNFXerd2Njwz111/srATDmza++76FMW
f9vLFx8IX3wgfCB88YHwgfDFB8IHwhcfCB8IX3wgfCD8JeAD4YsPhA+ELz4QPhC++ED4QPji
A+ED4YsPhC8+ED4QvvhA+ED4yrd+A46HB/nwt5ceAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTCharterExample >> exampleScatterPlotSimple [

	| b |
	b := RTCharterBuilder new.
	b extent: 290 @ 200.
	b interaction popup.
	b shape ellipse size: 15; color: (Color red alpha: 0.3).
	b points: { 2 @ 3 . 6 @ 6 . 10 @ 5}.
	b x: #x; y: #y min: 0 max: 10.
	b size: 10 min: 4 max: 10.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
	
]

{ #category : #icons }
RTCharterExample >> exampleScatterPlotSimpleIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACtElEQVR4XuXcS2vCQBSG4f59
cSWooOBfUCgVvGwUESlKUEFpVrpQkSwakShK6bE5EVvBXlJN67TvBwMqOJg85kwmo7nZ7fgx
KTf8XcAH4YcPwgfhhw/CB+GHD8IH4YcPwgfhhw/CDx+ED8IPH4QPwg8fhA/CDx+ED8IPH4Qf
PggfhB8+CB+EHz4IH4QfPshPRHo90fYvQabTabBh3W5XPM+TRqMhtVrtZGNns5louzrGw4PI
7e2+2bb8O5DNZiPaFKLnf+uq1aqUy+WTDV2v17JYLK4P4jhvIP5jdMlSFCNKlv8F0oYfQ0wB
4Q/qfBA+CB+ED7Ifn/yTm+CE4fFR+CDXxnDdtzO4+3s+iBEod3d7kPmcD8IfQ44yHA6lUCh8
OBvX1yeTCR/kN0ASiUSwo/v9vsTjcfno6DBhps4/y+KXLD4IH4QPwgfhg/BB+CB8ED4IH+Td
yw9PTyKWZfQSq9Eg6XRaDhPEVCp18Uw9wDhcpFuthA/yzegMPZlMSiaTkWw2e/FMXY+MV5Dn
Zz6ICWOIeB4Wgz+o80H44YPwQfggfBA+CB+ED8IH+TqDwUAqlQp/Td0UEJ2dr/xLHPw1dX7J
4oPwQfggfBA+CB+EHz4IH4QPwgeBghzW0j9bU9dZ+ng8FkWJoo1Go11Ufelnc103kr60nyj+
j3/xjxxyudyna+o6S4/y0omCRBXdgVEdvdrP1UH4+WNjSJiSFiZa8vL5fPB+x3Hk+Pk5Oby3
WCzKdrsN7kRxbl9hbzFiBEiYkhYmlmVJLBYT27ZluVxKp9MJnp/bX71el1arJaVSSdrttjSb
zbP7CnuLEX7J4pcsfvggfBB++CB8EH74IPzwQfgg/PBB+CD88EH4IPzwQfgg/PBB+OGD8EH4
4YPwQfjhg/BB+OGD8EH44YPwwwfhg/DzRV4AybhQuggV/YIAAAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> exampleSimpleCurve [

	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 400.
	b shape ellipse color: (Color blue alpha: 0.5).
	b points: (0.0 to: 1.0 by: 0.05).
	b curve.

	b y: [ :v | v sqrt ].
		
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleSimpleCurveIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEF0lEQVR4XuWdz07qQBTGfVHj
3vgIbtS40R2+gks3muB/MS60icYdibogIjFGpKEItKUIBzn1chf3Um7hdoYz831JMyvozPxy
ZubMmdNZGAzwJUkL+F2ADwRf+EDwgeALHwg+EHzhAwEEUqlUiMu9vT3K5/M07kdvb2/ED373
zaZmk+j6migVEMdx6Orqio6Ojuj09HTsj4IgoEajgQ9kBnHfhWFIDCXTIYv/GL9706nXI3p4
CClNn+EDUSy2Bt/3qVQiUjqp4wOZbBGPjz8gtK2y8IGMV7fbncoi8IEo0ucnzWQR+EAUqFbz
6e6uR3N1DPGB/PRBp9MhEZ46MpBqNRg6dj5p8dTxgSQriiJS3W58ICnUaPRpf7+tpb34QP4h
Xjn1ej1tbcUHkujYBTSPNuID+UP9fp/a7fbMjh0+EIOHJ3wgE5exMtoDD6Q5DExIqg8kEJ60
n57COFAkrW5wQGioZrM1t0l7aiCbm5tUr9dpa2uLFhcXE2Pqr6+vxgFhi2BvW3Id/wKytrZG
l5eXdHJyQjs7O1bE1IdVpYODthH1tX7IMsEqYIB8DqNGpg2rVgL5+Ajp5sbMRYd1QFqtFi+k
jF2SWwOkXu+K9CsggbhulFlMGx+IZVsfsEB4nrBhiLICSK0WDXdnQyvjMcYBYSePg0gDS2UU
ENvmC2OBeB5RPh9CHKoQD4RDqlmfDsQHMqNM2xi0FghH9EqlyOgtEKuA+H4gNqIHB4Q3BwfA
EgXExPiFciCj/PRcLkfFYlFLTJ1ThItFDz8BaBwQzk8/PDyk29tbKhQKWmLqbBlJedv4Q5bm
ISuLvDx8IBkBQXL4xAOp1UJIP0MkENftWBPhMx6IrYElY4Gg7U2JBoIQzzACCG8Wlsv4y1sx
QHw/hN0sFAcEfxIXBoQzWvG7WQgQfMsQBOTr62vuKcb4QH6JT4nYepDNSCD439ISBgR/7hAE
BD++IQwIf5UTv1szBMJ56rzndH5+PnWeOr7PoQAI56nv7u7S8vLyVHnqfCLd5lPpRg1ZvHno
uvjWIQrIywu+dYgBgj+RCwOCfvxTHBB8RxAfCD6QJCD4Z6uEAcE/uCAMCP4KC99C8IHgzyGG
AME/hSgMCH7sAx8IPhD8IcsQIPjWIQxItVrFByIJCP4OryYgozz1Sfepczy9XC7HVwKpfvhd
nudpedfz8/NAx3u4PUn30SfmqU+6T53j6bo+xs8V13XwjoHoELcnNRB8GTaHpBnSstDx8XH8
aQ8u7+/v4+szVLynUqnE+St87GlUrqysKGvX6uoqbW9vx/8/Kv8LSJohLQtxx1xcXMRAzs7O
4uszVLzHcZzfV3PwvMjl+vq6snYtLS3RxsYGvb+/xyX+kGXrshdf+EDwgeALHwg+EPwuwAeC
rwn6BvfjN85RY4CMAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTCharterExample >> exampleStackingX [

	| b |
b := RTCharterBuilder new.
b extent: 400 @ 300.
b points: { 5 . 6 . 7 }.
b connectDotColor: Color red.

b points: { 1 .7 . 10 . 4 }.
b connectDotColor: Color blue.
 
b allY: #yourself.
b stackX.

b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.
b open.
	b view canvas
]

{ #category : #sources }
RTCharterExample >> exampleStackingX2 [

	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| data |
		data := ((c methods reverseSortedAs: #numberOfLinesOfCode ) collect: [ :m | m numberOfLinesOfCode ]).
		b shape ellipse size: 0.
		b points: data.
		b connectDotColor: (normalizer rtValue: c).
	].

	b allY: #yourself.
	b stackX.

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleStackingX2Icon [
	^ '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'
]

{ #category : #sources }
RTCharterExample >> exampleStackingX3 [

	| b nbOfCurves normalizer |
	b := RTCharterBuilder new.
	b extent: 400 @ 200.
	
	nbOfCurves := 3.
	normalizer := RTMultiLinearColorForIdentity new numberOfColors: (nbOfCurves).
	1 to: nbOfCurves do: [ :i |
		| data |
		data := (100 to: 1 by: -1) collect: #atRandom.
		b shape ellipse size: 0.
		b points: data.
		b connectDotColor: (normalizer rtValue: i).
	].

	b allY: #yourself.
	b stackX.

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleStackingX3Icon [
	^ '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
vr2R/R85Fzp1QM2XCQAAAABJRU5ErkJggg=='
]

{ #category : #icons }
RTCharterExample >> exampleStackingXIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD8ElEQVR4XuWdTUtqURSG++HO
GllNGiTUoFGDBn2REWSWmUGGpH1Q1KjCyMEtSZG0oNd7tndwD3nsfO2je+33hSgoVrYezz7r
2e5qqt/nj0mZ4m8BPxD+8APhB8IffiD8QPjDD4QfCH/4gfAD4Q8/EP7wA+EHwh9+IPxA+MMP
hB8IfyYKZH9/H6VSCUdHR2i1WqhUKvj5Ne12Gy8vL1DvWRpVrzcwESAKhIKyt7eHWq2GQqEw
9EC+vr7w/v4O9Z4BxsUF0Gh00e0Cxi5ZHx8fFDDOzv5D2NriBzLRLC8PA7i9TRYKP5ARmZvz
bnw+zw9k7Mlmf2/64WFyUPiBuAInl5f+zeYHMoY4QyPcN3C/HBwkA4UfiJPra+D0NFyDg1xJ
/EAi5OQEeHqK1tztbf1QqIEo4ev1oje104F2WaQFEuZ+8Vt0yyIlEC/hixOdskgHZJTwxYlO
WaQC4id8caLLTTyBrK6uDopnMhnPb6K23Z+fn8VsvwcVPmOBlMtl3N/fD7bYO84o8fPzkrbf
wwpfnOiQRauXrCjCFyc6rkJrgWSzb5GFzysNp9g4ZNFaILncZ+zHBzUfHx8D9TqC/rxxZdFK
IFHHULy9AevrGIBA9KbGkUUrgdzdBW8ISqV/I5gDwgRZtA5IkGeneyky7Sq1CkirBXx+DjdC
11I0DjexCojbxF9zOeD8XPtSxA8kYKpVIMpUZJosigbiXooO8jDynhZWFsUB8ZqKkjx0oCNh
ZFEEEL+pqFAwG0gYWTQSSJipKJ+HiB3noLI4BGRzc3Nwsl19fOG86Oy125vE9vureppHmIrC
SOCkE0QWh4BcXV1hdnZ2sP2ufi3B60pIYvs9yhU3jsPP45ZFsVPWKAk0PX4DiFggSb4cyw8k
ggT2Bec3WRQJJKlztSbIojggpktg0Kys/IEVQEyXwLj9EwVEigTGiSggkiTQeiDSJNBqIFIl
0FogUiXQSiDSJdA6INIlMDaQm5sb7O7uGnH63RYJjAXk1tm0zzsDvwmn322RQCuWLAYJFAWE
QQLFAGGRQBFAmCRQBBAmCTQeCJsEGg+ETQKNBrK21qSHYRQQlj+qKdZD+IHwA+EHwh9+IPKA
zM/PY2Fhwff0+8PDQ7/ZbA4OY+t4U/V01ZJSLxCQxcVFLC0t+Z5+VwV1br+PeoBs9fj/XYX0
e0iQJS1Mer0eZmZmtNVzv+Kpo97j4yM2Nja01fv+/sbOzs7IeqGBBFnSwkQte9PT09rquV/x
1FGv6mywpdNpbfWKxSJSqdTIevxLli1jL3/4gfAD4Q8/EH4g/C3gB8IffiD8QPjDD4QfCH/4
gfAD4Q8/EH4g/OEHwh9+IELyF1gaID+8e6nSAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTCharterExample >> exampleTwoCurves [

	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 400.
	b shape ellipse color: (Color blue alpha: 0.5).
	b points: #(0 1 2 3).
	b curve.

	b shape ellipse color: (Color red alpha: 0.5).
	b points: #(0 10 20 30).
	b curve.

	b allY: #yourself.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleTwoCurvesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABeCAYAAADVA7GfAAAD9UlEQVR4XuXdXUsyQRQH8L6n
36Ev0lVdFdVddRlBEN4IQRpdZkGQGG74EiSL+ZKa2unxPzwbomvPkzrrmfkPLJuizu78ds7Z
0W1n4+uLv2gqG/xNwA/CX/hBHAY5ODiQp6cn+fj4MOu4NzUaDbPwl+WKXF3JjyD5fF5SqZSc
np5KEARmHfdBr6+vwg+yXOn1ejK8ufkZpN/vS/TiyfV06Xa7wt+ki5fRaCSDwUBWlkP4Qexg
8IMow+AHUYbBD5Igxrx8zA+iGIMfREmY4gdRisEPogyDH8TSCHxRDH4QCxjoHct8Bj+IIgx+
EAU5gx9EMQY/SMKDPn4QxzD4QZRh8IMow5gBqVar0ul05OXlxVRYLpf5fzG0mMD/CfL5+Sln
Z2dycXFhKr2/v4+tvFQqmYV/BG4ZBAAPDw+CggsZCoUCfw9Z4aCPP4c4hsEPogyDH2TNCZwf
RMmpLT+IIxj8INMYYSjd6+u17hs/iJKewQ+iEIMf5O+prRYMepB1jDP4QRzCoAXRikEJohmD
DkRbAqcG0XRqSw/iCgYFiEsY3oO4hjEDkslkZGdnR9LptNTrdTk+Po7dmUqlIrVaTfgTuGWQ
y8tL2d7eNkuxWJT9/f3YHXp7exPNvcRVDC9DlssY3oFoH/RRgfiA4Q2I62HKKxCfMJwH8Q3D
aRAXB33egviK4SSIj2HKWRDfMZwCYcBwBoQFwwmQ3uOjjNZ8eSc/CGHPUA/CiKEWhBVDJQgz
hjoQdoxYkKOjI5lcxxUbP+HyY8wBeX9/N42CWRLmvWnVFznwY/xHyPrpP1BX2Tv4MRTlEH4M
RSD8GIpAAIEb3fA3vwIQ/p6hCIQfQxEIP4YiEH4MRSBI3vwYSkD4e4YiEH4MRSD8GPGhG+0W
fTGLa8u2toZiHYQNAzcMxYScaGjcYnc4HH4/xhe1vx0ArxTEhxF4qyXf248vWFvjJ9rttmlo
PG42m9+PVYcsVzBwRGPi5cmGxYK/w7Apt7d9929gpgED9SNETMZobFej0VgodDgLYjtn1GoD
qVbb5ojGkY2C53FUI2YDADE7ep76LGtRjMkzjumjN0qIUTgpl0VKJeG9UC5qYPxMOz/xtUxD
TmNESXD6aJ4MJ3jPb47m8evNkkSJtj+pxo+bk34GZHNz02zQvP9RR4luxh8lR+yErZsOY6OT
mkwfvTbJGyLETWgwA7K7u2tCRTabFQ1HLX0P4S+OJfUgCOTk5ESitc2Nw1kU1jiFnTeXySrD
1d7enhweHlqvC+X8/NzUkc/nZSkQbPjz87M5S8KMPDY3GjkKs/wgT93d3VmtC/OmYI1Qbbuu
MAzHA9Bbs2+5XE74Q5Zv4xD+wg9CU/4Ab70DS6oUn88AAAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> exampleTwoCurvesSimple [

	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 400.
	b shape ellipse size: 0.
	b points: #(0 1 2 3 10 20).
	b curveUsing: (RTLine new color: Color blue).

	b shape ellipse size: 0.
	b points: #(0 10 20 30).
	b curveUsing: (RTLine new color: Color red).

	b allY: #yourself.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b open.
	b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleTwoCurvesSimpleIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEU0lEQVR4XuXd2y8rURQGcH8+
b4hLEby6BBFxqVupayJRl+MBx6mouEaKqLh+PXuN9Dy0RZ3OTL/2W4k0kbR77F/tPTNrrbYu
m9UPpqjTnwJ9EP3QB9EH0Q99EH0Q/dAHEQOBi8bGRiwtLWFhYQF3d3fY2NhA/pPu7+9xdnYG
e9SfwgBBrq6uMDk5iZmZGUSjUSQSCcRisYJJf3l5we3tLexRfwp/Hu4dDzeB8HXJenx81Mfw
GUMfhAxDH4QMQx+EDEMfhAxDH4QMQx+EDEMfhAxDH4QMQx+EDEMfhAxDH4QMQx+EDEMfhAxD
H4QMQx+EDEMfhAxDH4QMowAkk8kgEol4uXJ7tN8dHR0Vzamfnp5K5dTDwCgAsSKHqakpr8jB
JntlZQVzc3PyOfWwMPSXLDIMfRAyDH0QMgx9EDIMfRAyDH2QfIzl5dAw3DD6lYss/xlvb8DJ
iT4IzTI1MAD9UlIWjNVV6JeSMm3g8bg+CA1GLAb92l4WjNdXuBuy+iA01xmDg9AvtmbBcDfN
9Yutma7Av9vI5UAqiTE/D/3qdxYMl7/D+bk+CAWGxdAQym9HsJbokZER2IR/1afOnlOvNIbd
p/yf5xWA2AcGpFIpjI2NVW2feqUxLBYXod8fwoIxOwv9/hAWjOdn4PJSH4QCw8Jtv/oNOywY
dhjlvkbVg7BglLOR1wwIE4a7WtDuoGLCeHoCbm6EQZgwLEZHodvSxobxkzu5NQfChuHXRl6V
IIwY0Sg0ewwZMdyfj3RaEMTDcH95lizcTXC9pk/G/wyLpiboNX2yYrisRHhNnywgrBg7Owi3
6ZMBhBXDanLtilwKhBXj4gLY20PlunD7+vq8wdva2ooeRBA5dVYMi/V1VLYLd90dwf7+vpc3
f3h4CDynzoyxtQWtLlxmjPZ2aHXhMmP090OrC5cZY3cXWl24zBhWqW69HDIgzBipFHB4iIoe
W6ggzBjv78B3DZk1BcKMYRHWhR8FCDtGby9oji1wEHaMnh5QHVugIOwYlTy9DR2EHWN8HLCN
XAKECSOZBFpaPlrL7PHgANSdX76DVArD3QP9N+FWgT49jarso/cVJAwM++RUm3BLpSYSQGdn
OImjqgPxG8Pe8ZEIYNUda2tAVxdgpTfZGg9fQMrBuL4GrIrDlpqJCcA+goJxs60akFIxbHNt
bv7YXHNLTlY//AUphmHrusv8ehOfW3L0p7kMkCa3frS2tnqTuOXyl8VSuJZLTyaT2d+/zvHn
Twb19Rlsb2e83na/f9LptJe/D+K1839sHBsvjLFs/koC6ejocGcunV5O3T4DvtjZlOXS7QXD
6FO38e3L9MN4d9o4YZXIlgyiH1W2h5SypPl3e2Mc+WMGEbmv6QhjrOPjYwwPD386fz8GKWVJ
8yvi8bi76HtCbswgLzbtazoO3Lm31aJ1d3cHNtbm5iYaGho+nT/9JatWTnv1Qx9EH0Q/9EH0
QfSnQB9EP76Iv5jwA2uZpidXAAAAAElFTkSuQmCC'
]

{ #category : #accessing }
RTCharterExample >> label [
	^ 'Charter example'
]

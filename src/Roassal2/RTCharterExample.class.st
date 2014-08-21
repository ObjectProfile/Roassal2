"
RTCharterExample new installTitle: 'CosAndSin' 
		code:
		'
| b |
b := RTCharterBuilder new.
b extent: 200 @ 200.

b shape rectangle size: 0.
b points: (0 to: 3.1415 * 5 by: 0.01).
b y: [ :v | v sin ].
b x: #yourself.
b connectDotColor: (Color red alpha: 0.4).

b shape rectangle size: 0.
b points: (0 to: 3.1415 * 5 by: 0.01).
b y: [ :v | v cos ].
b x: #yourself.
b connectDotColor: (Color blue alpha: 0.4).

b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.

b open.
b view canvas'
	
"
Class {
	#name : #RTCharterExample,
	#superclass : #RTAbstractExample,
	#category : 'Roassal2-Builder-Charter'
}

{ #category : #sources }
RTCharterExample >> exampleAgeOfRoassalAndTrachel [

| methodsRoassal methodsTrachel greatestAge b | 
methodsRoassal := RTObject withAllSubclasses flatCollect: #methods.
methodsTrachel := TRObject withAllSubclasses flatCollect: #methods.

methodsRoassal := methodsRoassal select: [ :m | m numberOfLinesOfCode < 300 ].
methodsTrachel := methodsTrachel select: [ :m | m numberOfLinesOfCode < 300 ].

greatestAge := (methodsTrachel , methodsRoassal collect: [ :m | m date asUnixTime ]) min.

b := RTCharterBuilder new.
b extent: 300 @ 300.
b interaction popup.

b shape circle color: (Color blue alpha: 0.3); size: 5.
b points: methodsRoassal.

b shape circle color: (Color red alpha: 0.3); size: 5.
b points: methodsTrachel.

b allX: [ :m | (m date asUnixTime - greatestAge) / 3600 ] .
b allY: #numberOfLinesOfCode.

b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.
b open.

b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleAgeOfRoassalAndTrachelIcon [
	^ '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
AElFTkSuQmCC'
]

{ #category : #sources }
RTCharterExample >> exampleCosAndSin [

| b |
b := RTCharterBuilder new.
b extent: 200 @ 200.

b shape rectangle size: 0.
b points: (0 to: 3.1415 * 5 by: 0.01).
b y: [ :v | v sin ].
b x: #yourself.
b connectDotColor: (Color red alpha: 0.4).

b shape rectangle size: 0.
b points: (0 to: 3.1415 * 5 by: 0.01).
b y: [ :v | v cos ].
b x: #yourself.
b connectDotColor: (Color blue alpha: 0.4).

b axisX.
b axisY.

b open.

]

{ #category : #icons }
RTCharterExample >> exampleCosAndSinIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFlklEQVR4XuWb20vcQBTG+48K
ffClLyI+9aUIXS+vRUXBUqyCUEURURFtxRt4wz7og2yrWNdbixZ1XXcRlbOdM+2sk5jNzmxs
Nsl3QJpkz5c05ze3MzN5USziW5TsBX4I8IHgGz4QfCD4hg8EHwi+4QPBB4Jv+EDwgeAbPhB8
wweCDwTf8IHgA8E3fCD4QPANHwg+EHzDB4Jv+EDwgeAbPhB8IPiGDwQfCL7hA8EHgm8YQDY3
N0kd9/b2UkdHB7l9CoUC8R8+jpBryMLCAqVSqSeBPz09pXT6uHSdfv0i+vrVGBC7f/tGTr24
EJY+VkD6+vpoaGiI5ufni/zvw8OD54vmco81hL5/J7q/Nw4Iu+vnrLf5PwbVJ7IP4Sbrxw8i
ur5+BCMuVNIJ95LPs+trACZSQE5OREB2dx8DIi5U0gn3kk81er12SL0GwUSfaCCHhyIgWhD4
QiUdB1EdP9EbBFTXSyCW+kQDMYWgG0NwtP8h6xMPRC+x1ZRSW70YOzh+Pzl8CPT8RAGhiwuy
GfEId6ev6JBt9HqHXlav9Ul4QMTL25Rwr+CHqY8lkM7OThocHJQv1djYSNls1jNTv7q6kh2q
TZvuFbyg+lrnJP8dSGtrK83MzMiXur29pebm5qJXpn58fCyB2JRQL98w9bEEsrS0RNvb2zJT
b29vp7u7OyrbZFmOcPQcpJr2PkoZejT7kH9Zsldna9Spiwth6iGGvbUY+kYpN4kOkL09sgmI
X9BN9OVqx3MATQaQra3SS5+fuwIiLti0/yYBDaqHqiEmAfHzCUOffCBaLTBpcvxqURj65AMR
q3Qm7btJ0MLQJyJTL7emfnNzQ79FcljpXpzDXP8bgvo1K7qf30hM9/NrlkzuF8tMvdyaOmfp
BwcHpDY78N/RUd5xnj86osvLS5nR/51qKTh+L4ipF3Ws++l6/Zz1Dj9N734++50aFJjYZerl
1tS5BF64mgWvUZBpSWW/3d3rilm43/305yeqhpg0aQyKS2JDQ0OpNulN0srKCr199Uqe8++Z
zD3PiZXgquZmamqK6urq5PHY2Jos2T09PbIw6E3S69cddHZ2Rl1dXfLa4qdPUsfPYY16vvJR
92DjuTj1jEQC4Recnp6WQDY2NqilpYW8RkHv3ryR501NTfTyZTO1tbUR9z0SiLaZob+/Xx6/
fz9Gi4uLxPfmgOqjqFRqQB4rIKxn3fDwsNToz2cfdQ8+50Jwb7EjJnZA1tfXaXl5mbZEYjg6
OkrpdJrco6DV1VWa+fCBuPnb2dmhtbWMbAZVYNwdOvt9/PhF/jsyMiKDrEZR+XyeBgY+Cz7n
NDExQZOTk3KWmXWzs7NSo56vfNQ9+Lc9LV+CmcuKQuLn9oGeXGTzm3Hl/VOO3zz2X/npn0zb
e3T47rV2eCCVcoggUxu1XoSKLZBaB74WzdZ/BzI+Pk5zc3PyxbhD5gTQCwavqbuvezVNNotH
XrlMEH3sgeRyOaqvryce2ahrPDpy+6k1dZMJQJtl16CbGBJZQ1Tyx7WDA9/d3U1VN1liLGrT
DHlNIAbR4/chNd5VktgaUi0Q99CTvxlJ0rcgsRz2ujvh7EnWakfIE/3hpZXevTYCD0QfaXFw
9STQZHtOUH3YI63IA9HbcfmFk/79hsEXUrqeM3SH3mBjXdj9SOSBBP3C6Tn1+EAMhrEm91aD
A6VXH5Ta6hMDRK076Fm7Saaul1KxAuv8SldcsBlZ/fzp0osLpvpMJiFAOFPf398X6w9/F4R4
fV3P2vVMvdKaddD9trXcrxupGsJAeFWQM3WVtRfxLfp9CL7hA8EHgm/4QPCB4Bs+EHwg+IYP
BB8IvuEDwTd8IPhA8A0fCD4QfMMHgg8E3/CB4APBN3wg+IYPBB8IvuEDwQeCb/hA8IHgGz4Q
fCD4hg8E3P4AVhfZNUN554EAAAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> exampleCrosses [

| b |
b := RTCharterBuilder new.
b extent: 400 @ 400.
b shape cross color: (Color red alpha: 0.3).
b points: (RTShape withAllSubclasses flatCollect: #methods).
b x: #numberOfLinesOfCode.
b y: [ :m | m getSource size ].
b axisX.
b axisY.

b open.
b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleCrossesIcon [
	^ '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
CI38A5O2Qrits48mAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTCharterExample >> exampleEbola [

| tab data b |
"Preparing the data"
tab := RTTabTable new input: (ZnEasy get: 'http://mapstory.org/geoserver/wfs?typename=geonode%3AEbola2&outputFormat=csv&version=1.0.0&request=GetFeature&service=WFS') contents usingDelimiter: $,.
tab removeFirstRow.
tab replaceEmptyValuesWith: '0' inColumns: #(10 11).
tab convertColumnsAsInteger: #(10 11).
tab convertColumnsAsDateAndTime: #(3 4).
data := tab values reversed.

"Charting the data"
b := RTCharterBuilder new.
b extent: 400 @ 200.
b interaction popupText: [ :row | row at: 12 ]. 
b shape ellipse 
	color: (Color blue alpha: 0.3);
	size: [ :row  | (row at: 11) / 5 ].
b points: data.
b connectDotColor: Color blue.
b allY: [ :r | r at: 10 ].
b stackX.

b axisConfiguration noLabel; numberOfTicks: tab values size.
b axisX.
b newAxisConfiguration noDecimals.
b axisY.

b highlightIf: [ :row | (row at: 10) > 100 ] using: [ :row | row third year ].

b open
]

{ #category : #icons }
RTCharterExample >> exampleEbolaIcon [
	^ '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
BAAAAABJRU5ErkJggg=='
]

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

	b axisX.
	b axisY.
	b open.
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
RTCharterExample >> exampleMethods [

	| methods trachelMethods b |
	methods := Collection withAllSubclasses flatCollect: #methods.
	trachelMethods := TRObject withAllSubclasses flatCollect: #methods.

	b := RTCharterBuilder new.
	b extent: 200 @ 200.

	"Data set 1"
	b shape circle color: (Color red alpha: 0.3).
	b points: methods.

	"Data set 2"
	b shape circle color: (Color blue alpha: 0.3).
	b points: trachelMethods.

	"The same metrics for all data points"
	b allX: #numberOfLinesOfCode.
	b allY: [ :m | m getSource size ].

	b axisConfiguration withThousandsSeparator.
	b axisXTitled: 'LOC'.
	b axisYTitled: 'Size'.
	b open
]

{ #category : #icons }
RTCharterExample >> exampleMethodsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFJ0lEQVR4XuWcb0hbVxjGjx82
Co5R+mGD9cM+jH0Z3coGWwdjDD8UaWFQOgZ+7JpPpd/mPrRQtGCUqTArRGfSuVXBjrTUCLai
MWLUOPwbjU7FNIKVoUsgVUFTEfNk5xybkGWaObrG630eOMTc+3LB93dz3vO+571XJBL8MpIE
vwv4gfCLHwg/EH7xA+EHwi9+IPxA+MUPhB8Iv/iB8IsfCD8QfvED4QfCL34g/ED4xQ+EHwi/
+IHwix8IPxB+8QPhB8IvfiD8QPjFD4QfyP+sxcVFtLa2ore3F2tra1hYWMDIyAhKS0sT6+vr
GB0dRbr98vIy1DgsR0QigBqmBeL3+1FZWamH0+lET08P7HY7LBYLJiYmNKh0+1gsBjUOyxHx
OKDGXufw8CH4pyz+KYtf/ED4xQ/kb7Hh6VOowQ+EHwg/EP4pi1/8QPiBZNHMzAw6OjpQX1+P
lZUV9PX1YWBgAF6vV8/ZKnM3UqZueiCzs7PweDyYmpqCzWaDy+VCd3c3urq6MDg4qDN3I2Xq
WYP/s2f8mbqRYCAU2i10ycEPxChgnhe7+IHwxxB+8QPhFz8QfiCHEYjVyigHgZgfCD+Q/66t
rS1UVVVpZ4yPj6OhoUH/rRJDI+6pmx7I9vY2ysrKUFtbC6XOzk7s7Oxoh+diTx03b4IfiFGm
qtu3gceP+YHkUsHpmPa7BjA2BshpMZfdIdRAMnf2NvtGMNEcSB3DxgbkfJiTWhM9EF3Yk8E+
HYgGJCvGKSAyJmF+frcAuLkJ9T11XMYlfY0cVmzNDSTDkQgGocfQkHY8Wlp0vEjGjCSMbNfg
B/IiQJ7f5anv4TDw6BFitp+A5mZgehoqmKTOG3RPxVwxRN794R+adQVcBfCYx4dQl/xVXL8O
RKPArVumCOhHapUV/i2IeI10/IMHgMMBFBUBTudu7DBYK49hgTQ1NemtWtUFn+yGV8fVPnum
7X6Zut6xGx4GiouBGzeA6mrItB9oa9sN9nfuHNmcI+dAAoEA+vv7dYOD2l9XnfDz8o5Wjyds
yKXqfpm6XhlJJ0d/7UT0Fxdw9Spw8iRw+jRw8SLQ2AiUlAAWi4bCXzrJQSBXn9FQFNHyeuDS
JcTe/xjlH9wF7srh8yG+E0d88cmRKx4e2RiCmhpEv7iA5RPvwf32ZbjzzqLl2DfAvXs6kId7
AojMRviB5ASG3Y7Q8Y9w/80rcIqvERPHEM57A/PvnkfwRzf2yjX4gbwsGOfOAWfOwCEssIkr
qBDXEBTvwJP/JfxF35sqgB8NIKdOAfn5uCbKUSW+k58VsOZb8bvDh82VVdPvlxgKiMonvK+d
xwXRiq/EfXwihvCpGMSTyyW6XJIgkKGA/Ony4S3xB14VW/hQjKFYVKOtoEZXchMkMhSQs6/0
Ik8Ar4t1VJ2oMFUGbiggk5OTOhFM737P1NLSkjy/hM8/28Dwtz8jmShmjogssaux3/mXabe6
umoOIAqEytqT3e972ah/eGw0gjWvP+uvQjnlII45LDvTJoasMgSQg0xp6gEgt9uNgoICfV51
s9TV1f3DNvkqj/b29qx2SuntSfvZWa1W/dBRVFYH/u16pgFykCnNIUvuQ3KXsLCwUK6Ag9pJ
jbLImGmnCpiqqqxe7ZHNLr09KZudqlKrV4PMzc1lteOfsvinLH7xA+EHwi9+IPziB8IPhF/8
QPiB8IsfCD8QfvED4QfCL34g/OIHwg+EX/xA+IHwix8IPxB+8QPhB8IvfiD84gfCD4Rf/ED4
gfDrBfUXObawXi/NDtIAAAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> exampleNegativeY [

| b |
b := RTCharterBuilder new.
b extent: 200 @ 200.
b points: (0 to: 6).
b y: [ :v | v - 4 ].
b x: #yourself.

b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.
b connectDot.
b build.

b view add: (RTEllipse new color: Color red) element.
b open.
b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleNegativeYIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADfUlEQVR4XuXbT0sqURjH8d5i
u/aC76BNJkLlGyhoUbvARQuNFmEmWbhIqIWQlKTSH5TA6B+BFaKP3We4Rsx1rvdajmfO9wdi
NYdDMx/nnPPMwalejx+TMsW/BHwQfvggfBB++CB8EH74IHwQfvggfBB++CD88EH4IPzwQfgg
/PBB+CD88EH4IPzwQfjhg/BB+OGD8EH44YPwQfjhg/BB+GGAnJ2dyfHxsejPKysrkkgkxN2m
3W7L6+ur6LupF0r/P2vukJ2dHedk4vG4ZDKZP07s5eVFGo2G6LupINVq1Q6Qg4ODXiwW03fJ
5/Nyenoqk/wEjpL7+3vBzSGmgviJwQcxDIMPYhgGH8QwDD7IgNVes9kUfmFoCEi9Xp94LcQH
MWCY8hVke3tb9vf3nZPVeuTm5mZgpf78/DyxT6cpGL6AaHXearWcE35/fxdFMalSNwnDtyFL
n2FpxV4oFGRvb8+YSt00DKPmkLu7u3+6OE9PT72faNfH+Kn+rAO5urrqvb29ybDXd9vpXFUu
l0fqj3+HjOEOcQ9T/DvElcfHR9GVmM4hOs94zTGaXC7nHEun055PjYvFoqRSKeeYuz83xvLy
8tD+ut2unJycDOzPShBddcmvKIguj3VV5tV2Y2PDOZbNZmV9fd2zXSgUco597c+NoQuMSCQy
tL+FhQXRtu7+rAU5Pz+X2dlZKZVKsrW1JdFodOAJX15eyvT0tOzu7srR0ZHMzc0NbKfzw/z8
vNOu35/Xako/DMP6040pRfnaH79St2xpO3GQcDj8eVHW1takP3aPs1JX4KBh+AKiE3F/7Ncc
Hh7K4uKijLtSv7i4CByGb3fI7z1157W5uSmdTkfGOWQF8c6wdg4JMoZ1IEHHsArEBgxrQGzB
CDyICXvgfJAvMWEPnA9i4TDlO0ilUnEunj63ur6+/vaeuq0YvlXqWp33fx/0mPt/KnWbMXyt
1PUR9u3trayuro68p247RqDmEAJGIED070F9UGglCOXOCAQIDcNoECKGsSBUDCNByBi+gSST
SanVas6F9txTL5Wse1BobKW+tLT0+ZUErz311syM0d9Tt27Ienh4kL/tqfNj2BzCDx+ED8IP
H4QPwg8fhA/CDx+ED8IPH4QfPggfhB8+CB+EHz4IH4QfPggfhB8+CD98ED4IP3wQPgg/fBA+
CD98ED4IP3wQeD4A8HkkRcbog0EAAAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> examplePointAspects [

| b |
b := RTCharterBuilder new.
b extent: 200 @ 100.
b shape rectangle color: Color red.
b points: (RTShape withAllSubclasses sortedAs: #ageInDays).

b shape circle color: Color blue.
b points: (TRShape withAllSubclasses sortedAs: #ageInDays).

b stackX.
b allY: [ :c | c ageInDays ].

b axisConfiguration noDecimals.
b axisX.
b axisY.

b open.
b view canvas
]

{ #category : #icons }
RTCharterExample >> examplePointAspectsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADW0lEQVR4XuXaQUtiURjGcZd9
nPkG4arPUe2DvkAuWlTSwhZSuWnrKgJJwiCpNmFNq6RNZEKJm6IUrSwe577HnDG6pjOMdvP/
wOFKHcnO797znnOvoWaTnyAlxB8CPgg/fBA+CD98ED4IP3wQPgg/fBA+CD98EH74IHwQfvgg
fBB++CB8EH74IHwQfvgg/PBB+CD88EH4IPzwQfgg/PBB+CD88EH44YPwQfjhg/BB+OGD8EH4
4YPwQfgBgOTzeWUyGYXDYeVyOUUikQ99KpWKSqWS7Djoz9NoSLu70sKCdHMjLS/r3d/U3p50
eela0z5rNttqPp/7W4IkEgkdHR1pYmJC6+vrmp6e1sdBauj+/l52HORnKRalThD7maE4iDcE
jY9LGxuujSRIv6nX6wPBsMG/uJAmJ1vNr4+7KtoI/Bry7yA22C8v0uJia7APD6Wpqfev233c
G7yz3F0FNvh2JRiEHb3GL+r/GaSvN3SCeBjIor69ve3+8VQqpefnZ8ViMfkV9evr66EUdfwq
6+DgQOVyWaenpyp6VTWdTn9ZUeeDBKCo80H4IEwQW0H108+bK+VaAJa0gSnqtVpNa2trrmjb
8W+K+thYaxNnKyl7bUta2+BZ64pgS9m5udaSdmZG2tzkg3QW9aenJ+3s7Hh7g0PfQfcr6m0E
3zP+7u73/sEtX0Ohdwj8KWuIU5Y74w0loPsIflHngwwXpPPu66heFUMH2fSKqtWRaDTqO6C+
Rf3tLmvn3dfvXh8CA7K/v+926/Pz874D6rtTb9/25k9ZXz9lFbd+il9DAgQy9YMPEgwQeyo3
pCdzaJCHhwcdHx93PeutmBcKhebJyZ3OzuoynG7N+n32+0H2GxmQarWqbDbbFcSKeWtgGn+e
7nVJvwPzVf1GZsriJ0Agvaa0duyJ4+3tbc9+s7Ozurq6ku1/Puv3+PiolZUVxePxnv3smEwm
hQDpNaW1Y3eNz8/Pe/az/Y49oVxaWvq0r21UV1dXZV9V6tXv9fXVfZ2JP2Xxpyx++CD88EH4
IPzwQfgg/PBB+CD88EH4IPzwQfjhg/BB+OGD8EH44YPwQfjhg/BB+OGD8MMH4YPwwwfhg/DD
B+GD8MMH4YPwwwfhhw/CB+GHD8IH4YcPwgfhhw8CyC/G4RpvzYtWLQAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTCharterExample >> exampleScatterPlot [

	| b |

	b := RTCharterBuilder new.
	b extent: 290 @ 200.
	b interaction popup.
	b shape ellipse size: 15; color: (Color red alpha: 0.3).
	b points: RTObject withAllSubclasses.
	b x: #numberOfMethods; y: #numberOfVariables.
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
RTCharterExample >> exampleScatterplotWithHighlighting [

	| b |

	b := RTCharterBuilder new.
	b extent: 290 @ 200.
	b interaction popup.
	b shape ellipse size: 15; color: (Color red alpha: 0.3).
	b points: RTObject withAllSubclasses.
	b x: #numberOfMethods; y: #numberOfVariables.
	b size: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
	b highlightIf: [ :c | (c numberOfLinesOfCode > 2000) or: [ c numberOfVariables > 10 ] ] using: #name.
	b open.
	b view canvas
	
]

{ #category : #icons }
RTCharterExample >> exampleScatterplotWithHighlightingIcon [
	^ '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
rkJggg=='
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
RTCharterExample >> exampleSimpleValues [

| b values |
b := RTCharterBuilder new.
values := { 5 . 6 . 7 .-1 . -3}.
b extent: 400 @ 300.
b interaction popup.
b points: values.
b connectDotColor: Color red.
b allY: #yourself.
b stackX.
b axisXWithNumberOfTicks: values size.
b axisYWithNumberOfTicks: 6.

b open.
b view canvas
]

{ #category : #icons }
RTCharterExample >> exampleSimpleValuesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEUklEQVR4XuWc2y8zQRjG9691
7dKdxCEIIg4R4UJCiMYhXAiCENIQLpogJCLlwilcFKXox9Ov76Yjvu728G3b7bv7PMlmRXbM
mF/3mfedmY6VyfBLkyz+LuAHwi9+IPxA+MUPhB8Iv/iB8APhFz8QfiD84gfCL34g/ED4xQ+E
Hwi/+IHwA+EXPxB+IP/q6uoKW1tbkJ/Pzs5wc3OD/GdSqRTkCuo/nk6nIVcggPT29sJ0utx3
d3cdDb+9vYVcQYSB6Wmk5+fxenERDCDZt8O+39/fo6WlBWGwApyfA9Eo5P7zu8ND8I8hfkL4
/gYWFoBIxLXjMTvLD8QvS8LcHARIyWfv7sAPxCdLKqucMtuyAh0lfX4WtaSygCizLSvIUVLy
6akqnanJtqywW1LQbMsKcpRUtXoU2ZYDyPr6OhKJxE+W3t/fD3P3K1P/nyipanUqsS3XN2Ry
ctJu3PX1NaampmDutczUa2lJQbItB5Dp7Kfz9PRU5rIynZ2deHt7g7lrjJLCZlt1G0NeXl6q
FiWFybb4p9+V2RY/EGW2xQ9EmW3xA1FmW/xAlNkWPxBltuUAcnBwgOHhYbtB3d3dOD4+xu81
dj8ydWbbcgB5eHjA2NiY3aCRkRF0dXXBrLHXMlPnt60CQGZmZhCLxexMfXFxEU/Z5M2ssfPb
Fv8YQmdb/ECU2RY/EGW2xQ9EmW3xA1FmW/xAlNkWPxBltuUK5Dy3jLq0tITNzU3XBoU5U6+n
bbkC2d7ethvR3t5ecOk2zJl6PW3LFUhzc3Nmb2/PbsTg4CD4besQ/GMIqW3xA1FmW/xAlNkW
PxBltsUPRJlt8QNRZlv8QJTZlgOI5B1mY3W9dr8z25YDiGTna2trvu9+57etAkB2dnZwdHRU
cvd7IpGwL68KanljW7Wq36rkDz4+PuL9/d3TJWWDWj51eVmV+qsKhD/aUhRljY6OYmBgoOjh
NMXU0NDw87yX8uUsDxTT7yDFS/3xnh5c5M5J8VK+sbERz8/PruU9AZHp+dbWVhQ7nKaYJiYm
Sh5uU6p+E4B4+WaXCVK81t/W1obYyorn8h8fH5AZdbfynoBEIhF8fX3B6+E00hgJGiopX8ny
gAlSKjlc5zMa9Vy+o6PDPhrKrTz/GOJRf7Ifylqct8UPxKPkO5Kp8XF/gAwNDdkVyR5f2Qkv
A0/+q8WaqTsirmwfITsm1ARIMplEPB6HGXRFZid8U1MTf6ZeCMrJCZAb06r+hggQGTTlu+oy
6PT19WF/fx/Ly8v8nV8KTO7ABf4xJEQWxg9EmYXxA1FmYfxAlFkYPxBlFsYPRJmF8QNRZmGu
QH5n5jLVLl+Nzn+GP1OvzMLS2Rlet7kw18RQMnaTma+urtpT7fnP8WfqlUnmwuQq6w0xmbmZ
It/Y2ODveJ/EP4bwA+EXPxB+IPziB8IPhF/8QPiB8IsfCD8QfvED4Rc/EH4g/OIHwg+EX/xA
+IHwix8Is/4C4qXo1rkeJMkAAAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> exampleStackingX [

	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 300.
	b points: { 5 . 6 . 7 }.
	b connectDotColor: Color red.

	b points: { 1 . 7 . 10 . 4 }.
	b connectDotColor: Color blue.
	 
	b allY: #yourself.
	b stackX.

	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
	b open.
]

{ #category : #sources }
RTCharterExample >> exampleStackingX2 [

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

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

	b y: #yourself.
	
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

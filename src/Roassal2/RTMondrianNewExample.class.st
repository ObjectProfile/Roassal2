"
RTMondrianNewExample new installTitle: 'SystemComplexity' 
		code:
		'| b |
	b := RTMondrian new.
	b shape rectangle 
				withBorder;
				width: [ :cls | cls numberOfVariables * 5];
				height: #numberOfMethods;
				linearFillColor: #numberOfLinesOfCode within: RTObject withAllSubclasses.
	b nodes: RTObject withAllSubclasses.
	b edges connectFrom: #superclass.
	b layout tree.
	b build.
	b open.
	^ b view canvas'
	
"
Class {
	#name : #RTMondrianNewExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-NewMondrian'
}

{ #category : #sources }
RTMondrianNewExample >> exampleArrowedLines [

| b |
b := RTMondrianViewBuilder new.

b shape circle size: 30.
b nodes: (RTShape withAllSubclasses).

b shape arrowedLine withShorterDistanceAttachPoint.
b edgesFrom: #superclass.
b forceBasedLayout charge: -500; nbIterations: 50.

b build.
^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleArrowedLinesIcon [
	^ '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'
]

{ #category : #sources }
RTMondrianNewExample >> exampleClasses [

	| b |
	b := RTMondrianViewBuilder new.
	b shape rectangle 
				withBorder;
				width: #numberOfVariables;
				height: #numberOfMethods;
				fillColor: Color white.
	b nodes: RTObject withAllSubclasses.
	b gridLayout.
	b build.
	^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleClassesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAADOElEQVR4XuXdTW7CMBBAYW7K
UdjBMdjBLWDHMWAHtyCtkaYaTcexQ5zEzpuN1SSklT/s+Cd2N1237rher93lcnm38vduOj4I
H4QPwgfhg9QSj8eju9/vfJDcCJklmZablv6d9hgf5DcjQrUSqpfb7fbebrd/P9vzJaqfcA/J
/HBPOVZD9VZNlSUZIvF8Pt+73e7f+RIZpkuBBglfhPCF4IM4IH3XlX7oT3FfPshKgg/CB+GD
8EH4IMNjv99/WjlDWkh8kAnifD5/mrev12tUGu4TStiYlA+iqiDdD5D+hk3lfOy64/H4KWmS
xo7b8zWNd1UFovsGHojXh+g7nxoK4YNkguhhjZwM/3YMypYUPkgEZO5vMB8kE8SWlA4QVYMQ
Y8PPAj6I20OfIo2di/1ePkj3f4IqdT52nfQvNLRtSp9OJz5IqbGsFIh3fazlZu/Hr7JmAOlr
4sr9wpBLmJnkg1QCwn+ojwAZeh0fZCaQEr1yPkhFIPx+CB+ED8IH4YPwQfgg/GCA2CGMsYOK
fJCRIQN+HojuO+jjduqWDzJRSdEgASoGYj+r58ZzQr9VzwfJAPF617Yk9fXCh0ZNQE2A2JIy
FKTmElEtiLzGk/MeVekSwgf5Mghvn/D7IXyQeD9kyRLAn1NXzw5ZmpzKmLEP577P80EyMmaq
1pF3Xz5IZd9UPggfhA/CB+HHOpq9uenYz/NfJe0BSTWLvXd3LYhuRcleKSHlgxQEKTGk0gLE
qkBSEVuLyAdxQi8RmDv4L1s7cTgcPs8GL42dCxmZe+2QlA/itJL0zKB3TEpT7mopu3ucd8+a
9mVcHERaT94gY9+Cm1wQOzfvzdXzq6zMkpMC0ai1bpWBBLHfeHkLhQ+yMEhre/SuHoQ/lsUH
4YPwQfggfBA+CB+ED8IH4YPwQfggfBA+CB+ED8IH4YPwQaIgMomlJ7P4IAuCrD34IHwQPggf
hA/CB+GD8EH4IHwQPggfhA/CB+GD8EH4IHwQPggfhA/CB+GD8EH4IPxggUyxNUbL22tUt3FA
at263gDA/js9fU+98rZvz9/aVl01X2XFQOx1rSwExYDwnyEzg+hqp+WFn82D2A0HWo8fkhzJ
rlx6vgkAAAAASUVORK5CYII='
]

{ #category : #sources }
RTMondrianNewExample >> exampleColoredNodes [

	| b |
	b := RTMondrian new.
	b shape rectangle 
				width: [ :cls | cls numberOfVariables * 5];
				height: #numberOfMethods;
				if: [:cls | '*Layout*' match: cls name ] color: Color red;
				if: [:cls | '*Builder*' match: cls name ] color: Color green.
	b nodes: RTObject withAllSubclasses.
	b edges connectFrom: #superclass.
	b layout tree.
	b build.
	^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleColoredNodesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFhklEQVR4XuWay07cQBBF/WdI
+SY2QZHYZsEy6yTrfER+Iksk3u83DK8Bppw5DnfUNMYzA3Z43Gu1bI/tcnWd7up2a4qy9Ndb
UuEfAn8g/vIH4g/EX/5A/IH4yx+IPxB/+QPxB+IvfyD+8gfiD8Rf/kD8gfjLH4g/EH/5A/EH
4i9/IP7yB+IPxF/+QPyBvAHd3NzE2dlZ+AOZQoPBIO7u7qLf78fl5WX0er04PT2Nk5OTODo6
qsrx8bH2ZVMZ3vPgfG9vL9bW1sY+N4HdB37gG37i7+3tbaDOgSwvLwdldXU11tfXY2NjI7a2
tmJnZyd2d3fj4OBg5ByFlkjBUfYElQpQFFye4dnt7e1qv7+/H4eHh6PKch37BFHvH5aS/crK
SnXONY7xiT0+4SO/8yzHFI7TQAEdn9Rr2HOeB1s+YhebvAc/qYPuoQCbehAX+ca9ad1kI6vL
g7K0tFR7nJdCDqROUHgRlZUzVF7O4AC/KYCU4UtGAeNcwcKO7uU5QGKf+7h2dXVVVZp71HM4
vri4qIKDDe6h8kDd3Nys7uf4+vp6ohbLfdijND0DTHwgFmpo+EidBQzf1SC5fn5+XvX61A4N
hIaA31xXY+YZfuMaGUP3yBZ1KnLi7AmmAs11giBnMMyx7qcCGMcwBhU4XqbWqZcRDH7Dhhzh
eX5XD1PLppLcw3u4xrFs8cxL0gIBS3sPIJ5jA795HlvAJj74S1EWUANSPRV87uf9j1KWKHMR
KZ8SQLVS9nJ6GJgS4wSIaxyj+fLftnC7ELO92cpJQOlFvwa/YrG/WMHGWeXs9Bzb+EMF/vT+
xNfB1/Jb79soTVLBrnK3Uh0+dTFWEF9gKCNRR2DR4Kk/jZzfipx6ks9qnSJolMezg4dbru/x
PZajPr+qyDbHv+N3YGcmZqpUd59KOh1QaXikXqCkjaltUY+03un5IyBcVJqYbrrWDERqAiIR
FODND7cfw62r3kBrJV0znjFu0VK5Ru+nN9IQNKHQuNIGKBpXOl5zTp0pRd6tcIaWMv38uT0g
bYp0TIUJJuObZo+kZI1JgKDe6RQd8Ryx4DrphEJqIdUAUjZIp22luSKdiaSD26QzGInx48vd
l6pVc/y/gfCdQHDY0/I1sQAAEwRaOXAIniBpgpA3QOykQJXOKBoHeI5Mgm3NEAUJaDxHmRZU
BYQX1OXT53RFQDZ167aAkFp5nwLGOcECAscEPvn2KQGj1kwhmIxX9Jb7ycSoaJKhom8uCr0j
uRb6MNUkJf3u0jSdc1IfMR03DhbXc3MRP39GXYWnGURpCQJB939qKtkWECqZ282PyclAk316
iaa7CqAG8Sa/sMGzlPx3xUmDswox0DuBn94/JvUXZXz69Ch4GmSm6R3ZbKx2nt0WEFrxOCDT
aBK/6oCks6Y02CmQ+2+Psi4eEwOhe6UDXd2YkW6f+58jPefldF+lj7aB0AOVruoAdQHkKaU9
7eWDegOQfIBrmlXlW54q2l6oTAdcxMD6WkDaXe2tAZKvzdTNuF4TCL1BSzPqfbnP7375PRJp
OURTNlokFU6ncOOAdClmNSkQ9Zguv67/O5B8wEqWM6Ku+74mkLw3qMdozMoHWH8gHQPJlzC0
1pWuC9kBmR+zdSmtRTUt3H1oIG/JYa0IN01zn7PK4A/khUCaegAfYu8eyEfSe55t+f8vyx9I
t5p2UdQfiL/8gfgD8Zc/EH8g/vIH4g/EX/5A/IH4yx+Iv/yB+APxlz8QfyD+8gfiD8Rf/kD8
gfjLH4i//IH4A/GXPxB/IP7yB+IPxF/+QPyB+MsfiL/8gfgD8Zc/EH8g/vIH4g/EX/5A/IH4
yx+Iv/yB+APxlz8QfyD+8gfiD8Rf/kD8gfjLH4i//IH4A/GXPxB/IP7yB/Ih9ReUe2Cwge8u
vwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTMondrianNewExample >> exampleForce [
	| b |
	b := RTMondrian new.

	b shape circle size: 30.
	b nodes: (RTShape withAllSubclasses).

	b shape arrowedLine color: Color black; withShorterDistanceAttachPoint.
	b edges connectFrom: #superclass.
	b layout force charge: -500; nbIterations: 50.

	b build.
	^ b view
]

{ #category : #sources }
RTMondrianNewExample >> exampleForceAndNested [
	| b |
	b := RTMondrian new.
	b nodes: RTShape withAllSubclasses forEach: [ :cls |
		b shape rectangle color: Color blue.
		b nodes: cls methods.
		b shape line color: Color black.
		b edges connectToAll: #dependentMethods.
		b layout force.
	].
	b edges connectFrom: #superclass.
	b layout tree.
	b build.
	
	^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleForceAndNestedIcon [
	^ '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'
]

{ #category : #icons }
RTMondrianNewExample >> exampleForceIcon [
	^ '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
MAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTMondrianNewExample >> exampleLayoutPartition [
| b |
classes := (RPackageOrganizer default packageNamed: 'Roassal2') definedClasses.

b := RTMondrian new.
b shape circle size: 5.
b nodes: classes.
b edges connectFrom: #superclass.

b layout
		for: [ :c | (classes intersection: (Array with: c superclass), c subclasses) notEmpty ] use: RTTreeLayout new;
		for: [ :c | (classes intersection: (Array with: c superclass), c subclasses) isEmpty ] use: RTGridLayout new;
		horizontalLine.
b build.
	b open.
	^ b view canvas
]

{ #category : #icons }
RTMondrianNewExample >> exampleLayoutPartitionIcon [
	^ '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
SUVORK5CYII='
]

{ #category : #sources }
RTMondrianNewExample >> exampleLegendInPopup [
	| view |

	view := RTMondrianViewBuilder new.
	view interaction noInteractions.

	view interaction popup group: [ :group :el |
	
		| background elements cls legend1 legend2 | 
		elements := RTGroup new.
		background := (RTBox new color: (Color green alpha: 0.8)) element.
		
		el model timesRepeat: [ 
				cls := RTEllipse.
				50 atRandom > 25
					ifTrue: [ cls := RTBox ].
				elements add: (cls new size: 10; color: (Color purple alpha: 0.5)) element
				].
		RTGridLayout on: elements.
		
		
		"Legend Good"
		legend1 := RTGroup new.
		legend1 add: (RTBox new size: 10; color: (Color purple alpha: 0.5)) element.
		legend1 add: (RTLabel elementOn: '= Good').
		RTHorizontalLineLayout on: legend1.
		
		"Legend Bad"
		legend2 := RTGroup new.
		legend2 add: (RTEllipse new size: 10; color: (Color purple alpha: 0.5)) element.
		legend2 add: (RTLabel elementOn: '= Bad').
		RTHorizontalLineLayout on: legend2.
		
		RTVerticalLineLayout new gapSize: 0; on: (Array with: legend1 with: legend2 with: elements). 
		
			RTNest new centerOn: background elements: (Array with: legend1 with: legend2 with: elements).

		group add: background.
		group addAll: legend1.
		group addAll: legend2.
		group addAll: elements ].

	view shape rectangle size: #yourself.
	view nodes: (1 to:50).
	view gridLayout.
	
	^ view view
]

{ #category : #icons }
RTMondrianNewExample >> exampleLegendInPopupIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADgElEQVR4XuWbsW7qMBiF+4oI
0T4G5QloxVMwdGJC3WDswMAEA4JSCRaoOrWVKE9A7ZsT4SpNY8dX1dUlfEc6SmL/RFE+Y/tP
nAtr+TolXfBvAR8IX3wgfCB88YHwgfDFB8IHwhcfCB8IX3wgfPGB8IHwxQfCB8IXHwgfCF98
IHwgfPGB8MUHwgfCFx8IHwhffCB8IHzxgfCB8FUdIJeXl+b29tbEbJfLpX18fDT9ft9+fn6a
+/t7q7LE6f7NzY3h3/ZfAplMJub9/d3kt9Pp9Nu22+2a9XptVquVGQwGRkB6vZ6dz+f24+PD
PD8/84Hwu6wzBNJqtdLWrW7J7Sct3u52u3R/s9nYw+GQ7ufr3L/i+vrae7zf77/+QfJ2u7Um
kTt2MXwgfCCn32Vp/BiPx+bl5SUdL4bDoZU1XiTb1CqfzWbp+CHzgVRgDNFEQGCL4MoC4gA7
yHwgR93d3ZmHhwfrLGWPfWWj0cjkf6tjlXtio84bKk/OY4vOo7KzG0OcpeyxryzfNck6VnlM
rO+8ofJ2u22bzeaPcpXxgfCB8IEggCgDzw64UnbAlVXmZlW+2RUfyInOst7e3r5mWM4qS8Db
LHgffF8DkPlA+Pr/Y0hRdp614pXVF9X5uiyXECrBLKo7dkemqPWXdWPuH6Lf++pD15U9Px8I
HwgfCB8IHwgfSKWB6Obmp516IyggRVPPer3OB1Klae/r6+uPPMT5+JTXFlkPIIsaR1luItdq
NT6QqinUUOSTAaLVJFoxUuSrq6u0Zfnq3UqT0DlkKVQfG6NMvdFoBGNUX3bNsdctq+vWKpuY
uH82qMcM4GXPqWL7/7+J8T06yY8nZd1T7HXLutGa5MTE8YHwgfCB8IHwgfCB8IHwgYQzdedO
p5NOe30Jme/NIR9IBRLDUFLmEjNfFp/J5oMNSFZ9WSM6vn1kA6myyhpTbKb/60zd2X0XUhaX
/W6kzE9PT3JUbEyGnok1Z/cKN+/8Amuf9dcOPdHNr+dNHBUbM3ZkY/lA+ED4QPhA+ED4QPhA
+ED4QPhA+EBOG0h+9XuR1+u11ffpoUcWbrWK+369zIvFgg+kynIfpJZZixn4QPjiA+ED4YsP
hA+ELz4QPhC++ED44gPhA+GLD4QPhC8+ED4QvvhA+ED44gPhiw+ED4QvPhA+EL74QPhA+OID
4QPhiw+ELz4QPhC+QvoDvX+dONQ5jLYAAAAASUVORK5CYII='
]

{ #category : #sources }
RTMondrianNewExample >> exampleNestingAndPopup [
	| b |
	b := RTMondrian new.
	b interaction noInteractions.

	b interaction popup group: [ :group :el |
		| background elements | 
		elements := OrderedCollection new.
		background := (RTBox new color: (Color green alpha: 0.5)) element.
		el model timesRepeat: [ 
				elements add: (RTBox new size: 10; color: (Color purple alpha: 0.5)) element.
				].
		RTGridLayout on: elements.
		RTNest new centerOn: background elements: elements.
		group add: background .
		group addAll: elements ].

	b shape rectangle size: #yourself.
	b nodes: (1 to:50).
	b layout grid.
	
	b build.
	^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleNestingAndPopupIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACO0lEQVR4XuXbzYrCMBQGUN//
IXXnUsGFgos6c4VAJjQ/ZaDang9KMbZReuJNK+3h9fLzTTn4h8AH8eOD+CB+fBAfxI8P4oP4
8UF8ED8+iB8fxAfx44P4IH58EB/Ejw/ig/jxQfz4ID6IHx/EB/Hjg/ggfnwQH8TPdkDO5/P0
eDymufX9fv+zvl6vr1hOp9N731jnbbGdf9hX+oXcbrc3zC/WGyByPB6ny+Uy+SB+ydp3yYrR
ncpUWYby8jT3Xipntdfl9mV/aRsfxAfZVsmKAxvzQyzxOh3YmEOiLeaPWHyQDc4hOW4JnJB9
kOzsKT845cGqtT2fz6ncN15H+8i2tX5b7bV+om13c0itnNTaytIUS7pmGdm21m+rvdZPtPkg
PogPQoCMziE+yM6u1JdO6j6In++cQ3plo1aWeu+1+myN/pF9e5/bez/174P4ID6ID+KD+CCb
Bpk7HW2devogOzvtncNv/XHYGyA+iJ/PzCGjI6tXanrlZsk2I5818p1H+xr9XqO/MB/EB/FB
fBAfxAfxQXwQH+RjIHExlt+iky/pfl4fZEWQtTJ10rqKL6/mawNodBD5IBvPNJBV5pDW7aD/
HVFL+hwdzd/+SIQP4oP4ID6ID+KD+CA+iA/ig/ggPshXgrRuLMgfOSsfS6stPgjy18m0ID6I
Hx/EB/Hjg/ggfnwQH8SPD+LHB/FB/PggPogfH8QH8eOD+CB+fBA/PogP4scH8UH8+CA+iB8f
xAfx44P48UF8ED+t/AB/sRc/XKQU+AAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTMondrianNewExample >> exampleNestingAndTitle [

	| b |
	b := RTMondrianViewBuilder new.
	b shape rectangle withTextAbove.
	b nodes: RTShape withAllSubclasses forEach: [:cls | 
		b shape rectangle color: Color white; size: #numberOfLinesOfCode.
		b nodes: cls methods. b gridLayout ].
	b flowLayout.
	^ b build
]

{ #category : #icons }
RTMondrianNewExample >> exampleNestingAndTitleIcon [
	^ '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'
]

{ #category : #sources }
RTMondrianNewExample >> examplePartitioningAndNormalization [
| b classes |
classes := RTLayout withAllSubclasses, RTBuilder withAllSubclasses, RTShape withAllSubclasses.

b := RTMondrian new.
b shape circle size: 5.
b nodes: classes.
b edges connectFrom: #superclass.

b normalizer
	objects: classes;
	normalizeSize: #numberOfMethods min: 5 max: 30;
	normalizeColor: #numberOfLinesOfCode using: { Color green . Color red } using: #sqrt.
	

b layout
		for: [ :c | c includesBehavior: RTLayout ] use: RTForceBasedLayout new;
		for: [ :c | c includesBehavior: RTBuilder ] use: RTForceBasedLayout new;
		for: [ :c | c includesBehavior: RTShape ] use: RTForceBasedLayout new;
		flow.
b build.
	^ b view canvas
]

{ #category : #icons }
RTMondrianNewExample >> examplePartitioningAndNormalizationIcon [
	^ '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
Re7mS7a9SVe4O7xv1OZpiL5PjSbXN5V1ijWFda5KnJn5x33z/9XIDigXFrfsIwt67OyoG6iG
0lOHtAZCfnqi849kFNlOiXeYtRG1qVXrzq/cvHSKGDtQguGzyYmAQwSPFJDSFkvaAKGF0e60
b+h07WjnTpSZTiIZ9/aziI50K9z/XXd+FTNLZydHda+uufhnD/4cmw6EbKtuVIfr9msp60St
SZMwLxVU0IUvaRP0oNaOlACRDZcicv6cyGVdj+zzVvyy55m4u8FkDptGmtCO9k0Bkgqz9MCA
yH2rAzU6HNpQcBmOOWKDMwJOeXpDXrEZKW2iPo/yU76oW21WbMT0xXox0XgmYESx49ymwgiE
F/D+QV3mAfmf/wZaA02fueLFo+8n9M424rWlSjq/Fsp7DVJGb50kEp0XVNuqhWmiaJ5MUuHA
Wwk7nU76JCbaFCB66GHH0tb2ym3ulVpr05E/kAegWE9tpQpQgPzwxR/I56TztvNsOjsjgBwP
X/yVZiaLv/gD4Q+Ev/gD4Q+Ev/gD4Q+Ev/gD4Q+Ev/gD4S/+QPgD4S/+QPgD4S/+QPgD4S/+
QPgD4S/+QPiLPxD+QPiLPxD+QPiLPxD+QPiLPxD+QPiLPxD+4g+EPxD+4g+EPxD+4g+EPxD+
eiD6P5rJTjj+5tZzAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTMondrianNewExample >> exampleRadialTree [
| b |
	b := RTMondrian new.
	b shape circle size: 10.
	b nodes: (1 to: 100).
	b edges connectFrom: [ :v | v // 2 ].
	b layout radialTree.
	b build.
	^ b view canvas
]

{ #category : #icons }
RTMondrianNewExample >> exampleRadialTreeIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAK00lEQVR4XuWdBZPkOAyF9///
gmVmZmaqZWZmZkbP3ZcaTflyBjlx0pm2qqZ2djud7uhZ0hPYO2NionwZkswoXwXlA1K+lA9I
+YCUL+UDUj4g5Uv5gJQPSPlSPiDlA1K+lA9I+VI+IOUD8l/5+/ev+fr1q8l1P+41a9asiTNn
zphPnz5Vvx87dux/9+f1379/m/IBqcmcOXMqpaWK+Vd43969e40LkLNnz5pfv37xu7l9+/Z/
rrl161Z1zYkTJ8znz5/N2rVrzcuXL035gEwqZ/v27WploMilS5caAWTfvn3O98rq5/6u13nf
ly9fzKVLl6YsqnxALLlz545KIStXrjRbtmyprsUCfNfduHGjeu3t27fOa54+fVr9O27t27dv
xvX65cuXzdgDcvr0ae9DPn/+fOq1P3/+mH9XbRVj6te9ePEiqqhnz54FrxEX9fDhQ+OzxCau
dFoBgoIn3UMUkNi19+7dCyr8w4cPJmR17969Mx8/fvS+jisj9vz8+bNyaQcPHjRjBQgPj6Dg
J0+eeB9u0aJFZv369UaYkO86YsSPHz+qH9fruDNffBFX5bMO29VhoQBy6tSp8QEEN8VDXbhw
wdQtwcW6Zs+ePfX63bt3vdeiUN/rKJDPlFhSBwPQsRLfvR89elS99ubNGzN2Luv169dVIH78
+PGUm7h+/XrwQXEZtmJcAuVF6bin+mtYjs/dnTt3Lsisvn//bmJuEVo9FkEdtyWrOmQpCBbl
CuoWE6roK34+lbWFyAWWd/HiRdM0Fk5L2osr2L9/v1m8eHFQcefPnzcut1O3wFRAfIngpk2b
ookq7xUGGHJ7gwLk2rVr0ex39+7d1cO7Vnidgq5YsSJ4jQ2aL9BrhM+ZO3du8P1i2Tdv3qy+
f8jaBgOIlsfH3BaydetWo0kchTVp8hTJdWzW9urVq+j7hCHC4vi8Xbt2Gc0zjBwQslzcjSsL
rsv9+/ezPRDs6uTJk6r72bFMAwaWjPUBShsr7BWQycLdVKDFbb1//960BSTm1lItE3KxY8cO
gzWFiINd+zpy5Egv1pAVEErdKIQvLoomyYqtQKGabWtdDx48qCq4basGLqDt/MglPCOUetAs
C0UDDu5rwYIF5sqVK6ZJLInlLSkxSSwElodoLT927ZIlS6rFqL3nSGnvZG9iggQR5dK3gPrC
96msbtiwwZCl+95PqTz2GakUNJRr2KJpoGGVMEvtPQeXh9SFUgaAABZA4e6kRI4cPXo06vZS
yxz1xpVPYpVj4pDUvqQp5uvD9AYIvtvXe2grgIR1SdGxqeLqEqr21sswoSRRXicXwmXyXVlA
IwWk6/4BNJq8AUaE9dSDfIzJNRVfRViSWr4LCWIXcaMVIARtiodaNpRDWJm4NXoVKEeT86QI
JITSDgpH8RAU+V0AGSTtxV/aZXBWa6jnkVtIBFGOHXM0QnHSLnugaNyeUHbKKKtXr55+5Xdx
V/QZKFnDxTF1WIdvDKcLgYlpyyYINSu+X1fubmSAsKpcihCqu2fPnl4fGNcZ+75cA52NtYKn
JSDaoNznA7gSSVhgDKxiAEnJtnMJeQn0k3wDWj4xjaWzxNDVTOpScJkLFy6c1mAkAUIFNHX1
SS9cW8FtI/S+NdXcsQEExVLy0MzGYh380LOYN2+ecQ0n9B3gxw4Qyg+yAvkdv43PhuMfPny4
KoUDgouFacrybaUPKxwMIACB+xFlkynDpgCFAWqsJ9abgHp22fRJyUumPSDS5PclftoAru1n
NxEZzivGZeVSJMU5XJivgdVENm7caIY0MO2Kv9u2bTMjpb0hkZHTq1evZgHlwIEDVZdylErH
e1AToxDKYsNF8ydlHoiNtqw0EkAYH6XHTUzJEYxD+0f6EAqsq1atMlLnC80pDw6Qei4DQWgb
7HNZWopAdJhH9tFtXDOxVxpZ2S2EXkTbskQoDvFg9kBbivRVxcU1olzNIIRNx137H7Mkhuzp
ICDjIqCZrExpGsWmxDVMDHNvsimzj/oVn3Ho0KFqHiC1hdyJyyI42asCk2VV0wuZP39+1aii
18y/2ZMjUF3tkJpNYQFZ0/yirM7K7UI5BGiUX59GQQ9d5T1qQOjSkQSyUvCdMZOlXIKZNtkm
RntY9nVgWXw2iqeKDFhYIwxGtj1LMG2rDOLZsmXLqsabxuq6GAVSA7Jz587kfjariL3hqS1X
RDOVKGUZWa18Dn9vMhWDdVtbp5PiIp+bq5aWxLJiY6D1L6odv/HFk7YEgtKOEAm+u31PLA4r
rvduIBapg3hipYACsFgwpSXoL//OVP9IaS9upm2Ftw2YdUHBojQUFnO3qRaNe4PiAkidlHD4
AXF2ZIDgLnLsNspdsme+lyM2tDlGm/krYiwLCjaaes5KNkBYHaxA2cTZVnLnFqFNpb7nyVHD
Sq2xJQMCDyfAY6awKCnFswL58Fw5Qe49falJZ45iKn2i48ePd2shKJ0Nk/USQheuL9e9mk5Z
5tzx1YvLgm52tTs150b+poDMnDnTrFmzxvhiXBd72Ge08I2drR5YDp+RY8arTSWYKZbNmzdP
dUnxBMw2k5AClOwgGzkgbBdIOfvKofApbo7CoIVQZfw29THKFTJxngPcLsiAWAh5DGARO6HU
sCr2KTadee6s/A7tq1NXkjHcnGT9oWw8VwzJAWpsZ5WdZwCIZo9L74AI5WMF1SksGXPX243J
zPl8KrRt76VZ7TYr02zL6w0QTJcfzNlXfNMG7Da5yORxS4Z2cVtr414a2kzi6TskpzdAKL3D
t/H78qVjCtf61zZBvR5sWSRt2sUwtVjBkxgCIG1OX53RlsHwBTh2wn7wXCWRNjulXKCzYJrG
lL6OAszmsiiZaMomKflF7HSgphZIDFu+fLlJoe70Ydj/woLrcqgiCyDWaQnBL0qjKmVTD7NM
TXa5anIDZrk4ACCVFuOaYVJdbQDKAgiuxXeyaJuEUnPMhTZvCAmFRG1DDLcnJEFO1CaODs5l
xXIS8g9Wlaa3TvCFRiLa8jXXklXTl2jKpKTEEhu0sPvp69atM9qpxEEAgktAqVrXgDLs5pR2
6Cx1/inmfmOHyzCNaBdZBw0IboOHsldrKBfAXZBMuQbetEdXsMJxIU2JgJ37UEmI3QfXm9NV
dQoISaG9nzwWAEOUUtvHt09iyDGiA5vq6oCZkbksVj0rKRZoOTmIKqrrNQ2bgYbambRmkI1D
CELxRvKVPg9G6BwQKaOH6DAxI+TO2BYXy11c55TEgrsm0ZPEVA7F6XJisVeWFUv8Qk2umOIo
UvoGEgjQPvflGgFy5Rw2IH3swR8JILgD2fEUG/chgfMNHMguX1ecYXXHyuBMP4Ym5xnh6Xsj
UO+A1LP60BA2KzRUe4KBhfamM/MbikFSBPRl9uQ1/D8mYw0I1JRyCMkfXUNfz1oCqi/YS+wI
TTiSw4QIhTSWWBRD2eM+0hjC9gafSxB2E5r6I/aE/DqKRny9DNs6+R4MWhcNSMitycoOMRss
JNR5lP6Hr0rAILgcyMl5WbmP6xsLQFjxMoEOEyJHcbVENc0miRHQZhcoBHxKIEN6/qFaSOXT
+dO1O4vchdiDkBS69p/AzDi4DAuio9nFyE4xgNjiSgplWzV5jLC2On2V/3kHEHB7Q3BHYwGI
T2S1YyF9/ocr5QNSmJQPSPmAlC/lA1I+IOVL+YCUD0j5Uj4g5QNSvpQPSPmAlC/lA1K+eOUf
eVqoeUse4lsAAAAASUVORK5CYII='
]

{ #category : #sources }
RTMondrianNewExample >> exampleSimpleNesting [

	| b |
	b := RTMondrian new.
	
	b nodes: (1 to: 20) forEach: [ :each |
		b nodes: (1 to: (each)).
		b layout grid.
	].
	b build.
	^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleSimpleNestingIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABeCAYAAADVA7GfAAACz0lEQVR4XuWZzY3CMBCFqZY2
aIACoAyogSMFUACcOMGJU7L7VjvS7Mh/sPwk+Z40smKPEuSP57GTWd/zNSTN+FPAB8IXHwgf
CF98IHwgfPGB8IHwxQfCB8IXHwhffCB8IHzxgfCB8MUHwgfCFx8IHwhffCB88YHwgfDFB8IH
whcfCB8IX3wgfCB88YHw9SYgh8Oh2+/3veJ6vXb+2vefTqc+9qvvnn4LPYMPJKPNZtMtl8te
8T2Jnb/2/ZrI2G8TXOpfLBb9er3+0263Wz4QPpCJLVl+4jWxikeAKPhAniA+kIEB4Rf1DyxZ
qaWqNF6beI1dLpeuBMaWw1ogi3qqmJfGc0uWHz8ej10s6r646xm5cWtXqxUfCB8IHwgfCB/I
AIHsdrtOE5OK8/n8A0QTorBta9z22njM80Cs37ceSByPwd/2OgfpX+rPERGIjcc8D2Q+n/ex
9UDiOB/IAw7StlVRGpfLcuO6d2ncBwaIJkT/0lLcbrfu941vMZTTkmehZ+verfmK30Nq028e
bVFPLRE+7OViLc+WsFqef4ViS1ZrSC15WipHCyTWgBgGpJaXqimp2tFSQ3yrQm/XBiSOx98y
aiB8h/AdwncI3yETcEgE8gyH5IDUHBKBTNYhOgsISim0PdWZopZn55JanoWdQ1rzFZN3yBhV
cggfyIeA8B3C1/h2WY/utu6pDffutl7pmMGfQ1K7rdLuyVoPpHYOSZ1HUrusd+y6+A7hO4Tv
kI8ASX3N860BiV8GcxG/JJburdYDacn3QHx/KfgOeYFDfDv5GlL6R/6nhuS+kbfWkFaH8GtI
4ht76lt7zhk5IDWHpN5p8R3yQYdEIJNzCF98IHwgfPGB8IHwxQfCB8KfAj4QvvhA+ED44gPh
A+GLD4QPhC8+ED4QvvhA+OID4QPhiw+ED4QvPhA+EL74QPhA+OID4YsPhA+ELz4QPhC+nqov
6Ocd2QtwZA0AAAAASUVORK5CYII='
]

{ #category : #sources }
RTMondrianNewExample >> exampleSimpleTree [

	| b |
	b := RTMondrian new.
	b shape rectangle size: 10.
	b nodes: (1 to: 100).
	b edges objects: (1 to: 100) from: [ :v | v // 2 ] to: #yourself.
	b layout tree.
	b build.
	^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleSimpleTreeIcon [
	^ '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
8QfEn76P/gCZdK8iJGbd0AAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTMondrianNewExample >> exampleSimpleTreeLayout [


| b |
	b := RTMondrianViewBuilder new.
	b shape rectangle size: 10; borderColor: Color black.
	b nodes: (1 to: 100).
	b edges: (1 to: 100) from: [ :v | v // 2 ] to: #yourself.
	b treeLayout.
	b build.
	^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleSimpleTreeLayoutIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAFQUlEQVR4XuWbuU7sMBSG82S8
Ei1ILAUSPAodLRJi6aCkQKJBghKExL5vnstn3YNyfZ0ZJ/FkwvxHGiVxvByfL7b/OFAMBvrW
Jyv0Q6APRN/0gegD0Td9IPpA9E0fiD4QfdMHog9E3/SB6Js+EH0g+qYPRB+IvukD0Qeib/pA
9IHomz4QfdMHog9E3/SB6APRN30g+kD0TR+IPhB90weib/pA9IF0YbOzs4Ozs7PB8vKyPhB9
IOJAPj4+3N3dnfv8/HT39/fu9fXVle+7b3t+fna3t7f++PX15fNw/fT05K/1gTQwAk7gAfD4
+OiDm7uNt7c3D/Xh4cG3w49z0t7f350kEJ5oAkBwCDrB7+PDwehilDHaGGU2Cl9eXuiC+3VA
cJpg0wF7MnN2pA9Gf8Lpkb4y0m0U9gYIiy4/ZUuJQdGlEuKnbCkxyA6EYWoqyNaH8lBlKDNt
cc6R62mGQDysnxhx4ZqYhAqxNRAqtbXAVFETWYljtpijbqZhfWHNMMk9bM0hnx1rAek6aLlg
d2nExWR6U4hRILzx2ltvn6aV8nR4cHDg8HFtbW2ivu3t7flYbW1teb/GInt/gyIiCPg4aaFw
c3Pj/eA4tveQ36CIVldXHT7OzMxMdIRsbm76WHHMDoS5j3mQoceP8769OYfzNEfbv5qEP6yt
9kKYY2ov6Ii9RVdlmnSnw4elSrGYpO5i8QdAbGPTtoAaA6mjlLrudMrDUhUs/DMpOQ4Y9i5V
FSceniZgijZO7ezseKWD0shlqCbqpO4cshqYZdXY1relpSW3v7/vUlXhysqKbx9VOCyvqcai
TwrDBEXuj025VGMT31LLmGos+qQwMFQTdaKiutxDGpdvqWVMNbYCYqqCl7Vcb+emWobN0XWM
emwBblunffuoUw95U/KbIChyLWoWyDZrUvi9oC3omAxtKk1ZD8r+pfhWLjOq3dp7WeFT0kR9
VNmwzsVANYXRBkqszCjfymVCoGFMf1TW3NycS1mkUBjkTVELCwsLLmWPiXbn5+dH5tve3k5W
c+TDz4R8yepnWH9ivlWVIS2MdehvkapA6qqFlEU0te06aq7r/sR8qyoT8y1MK1IVSF21kLLH
lNp2HTXXdX9ivlWVifkWphWpKqCuWhj2YcaM7x38UhZ86kwRDZPoz/X1tYuMnOiaE279sJiX
dyIKk5vDtkKaqIVRnS3fT807aivEfOuyP/b3W+HDEtvyoa6wHmD/B6SOKklVC6MCmAokrKMq
bwihq/7YyCnXGYNowEK/wpH/AwSVgArIpRZsLg2VDPWTL2yHtLCdv3tQ/6TFVCHl8ClsZ9z9
sTyHh4fO/FpfX/f7XbS7uLj4o8C4zz3bV6OMKT3SLSbFuNRClZKZpna+A+mvAcCR642NDX/O
Im912Dn3RpUpSsNzcH5+zhw3KD9lpIXqhrRQgnIdLm6UI2/5KZ2mdo6OjgaXl5dud3fXl+f6
+PjYn5+cnPg6yufcIw/nVWWKUW/MsTT7c9BwXg73/+1vYlPq/K3t5P5oV4QLWLjAxb4U4lTM
sVi+sKPT1s7YgZQbMCfLaaajQwWC/MNiSqdcftrayQ7E5jXmRua1i4sLZ/Pa1dWVY17jaHMc
+cK5kLnWylDe5kzSrfy0tsMacnp6mu/fEVJW/iZqQakMELOPkGErfxO1oFQm6wgZ6FuvTB+I
PhB90weiD0Tf9IHoA9E3fSD6QPRNH4g+EH3TB6Jv+kD0geibPhB9IPqmD0QfiL7pA9EHom/6
QPRNH4g+EH3TB6IPRN/0gegD0Td9IPpA9E0fiL5F7A9htB21NeOvdgAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTMondrianNewExample >> exampleSystemComplexity [

	| b |
	b := RTMondrian new.
	b shape rectangle 
				withBorder;
				width: [ :cls | cls numberOfVariables * 5];
				height: #numberOfMethods;
				linearFillColor: #numberOfLinesOfCode within: RTObject withAllSubclasses.
	b nodes: RTObject withAllSubclasses.
	b edges connectFrom: #superclass.
	b layout tree.
	b build.
	^ b view
]

{ #category : #icons }
RTMondrianNewExample >> exampleSystemComplexityIcon [
	^ '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'
]

{ #category : #sources }
RTMondrianNewExample >> examplenestedTree [

	| b |
	b := RTMondrian new.
	
	b nodes: (1 to: 100 by: 10) forEach: [ :each |
		b nodes: (1 to: each).
		b edges connectFrom: [ :v | v // 2 ].
		b layout cluster.
	].
	b layout grid.
	^ b view 
]

{ #category : #icons }
RTMondrianNewExample >> examplenestedTreeIcon [
	^ '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
QmCC'
]

{ #category : #'as yet unclassified' }
RTMondrianNewExample >> label [
	^ 'Mondrian'
]

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
RTMondrianNewExample >> exampleClasses [
	| b |
	b := RTMondrian new.
	b shape rectangle 
				withBorder;
				width: #numberOfVariables;
				height: #numberOfMethods;
				fillColor: Color white.
	b nodes: RTObject withAllSubclasses.
	b layout grid.
	b build.
	^ b view canvas
]

{ #category : #icons }
RTMondrianNewExample >> exampleClassesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEo0lEQVR4XuWdSU/rMBSF+f/q
BtgCYti2ZdgwlkGsQawYNiD+BOyclxO9U7kmtpO0aZycK0XnpZl4/mr73ms73ciy9dnDw4O5
uroytl5eXs71/v4+u7u7m2u+efX29tarvJ9vn5pvpZp1aBtZgkYg3CcIex8F9/T0ZG5ubsxk
MjE7OzvzfZ7Hz919Xp/i/70XQPgNd4E0vb8+kCWBrLpA9YHoA9EHog9EH4g+EH0g+kD0gegD
0QeiD0QfSM+BfH9/m4+PD30g67LpdLqQg1q16QNJzPSB6APRB6IPRB+IPhB9IPpA9IHoA9EH
og9EH4g+EH0g+kD0gegD0QeiD0QfiD4QfSD6QPSB6APRB6IMBLPpLy4u9IG8vLwUhVFHz87O
ss/PT1NVHx8fM2y8B/7N41Wfi2tg1MECcVdQcXZJZAXVwqqn0WiUvb29maOjI+Oq3QzZi3x4
Pbbd3V0znU4zrtyynxeb7TL4JstXAD4gMasCpKQ/0QdCe35+zmaz2Z8C4LyrVQJBzULNcA3P
x9+hD6SiN7QqIDWeOT/3+vpaH0hKQPRryJJA0LnnnlGxscPWB9KCVQXiK9w6QOB9Aag+kESA
6Efq+kB0Uif6QPStX0AQeOVbEYD5omQe44tgYi+aCWnoBTahIBDXM2Dl3yMHBJ7N7+/vApDz
8/PCfXUL2u1bYkC+vr7MeDzWB1IFSNk5BELDaiqkPagxIMju2gBor6+vRRLSBlQWjesDiQCJ
eV++GkQATbw6fSANgLy/vxskIn1AlnGzJYDQjo+Pi8RdGRB8o9GfAFzdOEUfSGKBI4ZlmzRR
+kASieRDpg9kCWNfssp74n7MHA8WyOnpaXZ4eGhsPTg4KBQTCtCnbG9vV1bUjK2tLa/u7++b
k5OTUs37MRNSuUgdyiFcX6D48/PzJ8JG/IA4An0F3FqeR8VxxCH2K2LRt3Af33zUKGYC3P2u
XxXbKRDX1bUL3EoQFp9jTLzO4JE7GY6BpdXvLByfTCbFcQKSAAJ3d29vLwjEvYbf/LrPis1O
RO203/ErmVy0C8OebRIC0tRQo9p8gc2gvaw2gPTVkgBCF7NJ06QPpCW3t4n7G3N7Q7q5uWlC
KgGEHoztbZUNTtmf0euit+W6ua6i77BzW7HzfSrVZLlA4JJiEnQZEP0mKxFvSx9IYt5W3UBQ
H4i++zt8IPrub4Jur63IzFIBys3I+jK59nUhDT1fAoibXCxze30/Cmbnp6AcA0Emlxlde8pQ
7EfFQs9d96BUMkBcb4txCpXuMJsye0KDz5YFwjWIEkBY8O6PfNUxZGhxH59x7lZdIKxh+p16
S+YD4RZ8KiAGD8QHSN/L0geiD0QfiD4QfSB1rY25W0OI1M3/CL3QPGKeT0Qr09ggUj7Y5FXU
CGroGSGVCQztgSpaWWGgiXEHj3xrQdzzuBTBN5PFVq4R6eLNDUkAsfcj7b43Eq86n7dJ5rhL
MJ2/DWidQLpsivSBLFFD9IG0CIR9ij6QloH0raAHC4Re1VCtd0CGbvpA9IHoA+klkC7W9+kD
6XAygT4QfSD6QPSB6APRB6IPRB+IPhB9IPpA9IHomz6QJO0fZYSVk1u3qCcAAAAASUVORK5C
YII='
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
	b open.
	^ b view canvas
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
	^ b view canvas
]

{ #category : #icons }
RTMondrianNewExample >> exampleForceIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAGXklEQVR4XuWdh3LjOgxF9f8f
md5776HfHk+QwWNAFZuUKAEzmkwi21rjEu0C5DarlX+pSRr/KvAPiH/xD4h/QPyLf0D8A+Jf
/APiHxD/4h8Q/4D4F/+AdMv393c4PDwMu7u7K66zs7PgH5AJRYMh19XVVfAPyEQSgyGXf0Aq
AmR/f7/VQj4+PsLFxcXa1d3e3gb/gGSU8/PzPy7r+fk5XF9fB4DBfSHy+s/Pzz+vPzk5Cf4B
GSBfX1/h4ODgV5Gsbn3/5uaGe+sLMAAiUvrv6y8vL4NlVSQH/gHpKYaCV/f398HKuB4eHkyF
i2vCGqz7uDH/gBSIEymF/wNkfR8gl5AEVAfI8fGxCcjr66up8Pf395BKlXmPf0AGiLXqX15e
TCU+Pj6Gp6enYLkrAUzHJv9p74ZCtiSuCjBQbMrvS1YVxxlijLYU/3VIZiGFtdwNgZ2fcY3x
9vYW/BeGGTmr1L0YFFJffuK65G9WVuYfkA0kjgd3d3emYvXfJTaIRYwVtHkuVrtYQPiCXRmT
Fgn0gEgicHp6ug7wY9QYUeZW/JmTAELt0FZTWPJTta92dnb+R6WU/HfCHAzl02YJSKrqRumk
t9yXwI7LwkUl2N8wdp1UuthsKqJNQm3KsaidxQJCTZFibi05Ojr6o5zSXURiV4o7izuasNOL
rUNS6fHe3t6vAlBGF4g5BBdKLCGR0DFLs9QWc7B4QHSGBjhjpKE8J1UnlYpps506GaM61wVo
H0CwGv+AFJI2Po3YggvrS4y6AEQXjCUkrnFwXTxPxy1NjOaqiWYNSE4r+cmo1gomeRBaxgJi
kWnvJoKSqOa5UFCuvkeKyhkTiNkBQkoZK4xMi7Q0N5Uj9EyK8PQPSCKroRhry4Q2BUQXnm1W
yIKQgpU4koN9bnJV3aymkmSfpbB/K7m3S5E5L94jjS7pUKZcllY8lsj303GLz4rfs60bbXLT
C6yUEn7XUpjM+na5LQYnLCIzThCEu4IFaCs8+X5Yz1DGehRA2hSVOaD/KcJktQIIncNUGlyi
iEuNHVUJSClaXFyjVnysGK1o3FFqfChHX6PEYF4RQDBnVm2b68LXSgq7zbhn6vkAJ67M2tog
cWTbOkjcHPGkikqdL94W2FAKrVkdDC1ae9Mir4+FsjB0HKl5Mr4pUbC1pYko3spOtKsRvkjc
ExYk3UP5XQOi27o5exOzBSTTqh7sugBO+CR9UZto98HvTMeTWdU+1Tg6ILgv4Yz0hZ/vijco
VIovfupxIO4TO7SFUjdY+0zGGumpGhBWqVTVVuaTUpI14BDXENol9rHGeB/K4gDRARMqQVYp
KxvlW4riNQTXLr7I6qWnBg3izAkXWCrlrRYQq1HDMFsOjqkt3qSsqc/7Uxa2CEBKj+dYMWBI
4RlX+Kn9J/4BGZBJxfNRbaxqqp4hwM9he9vWgFhTiCUm0gGhT3WdowKffVAnXlDYsZJzNIy2
kZpT2moLw5Iy9/0iiwPEv4X4F/+AdEnpfSP+AfEPyHwFuoZtDpCNc9wqvShALNKy5Lipf0A6
ZIodT/4BaZFNaBzYZghS3FwNRznNChDoemKDxWURLyyqXtgDeKyYVrHOWpkalDmNkgaryaQb
Xz/9j9C19x2AUjt7sRT/gHSI7FHvMwOFolG4DOul+jLW5EsNx9HOAhCrCWbR8JrY1BRKiq63
PnNqtriZS+zoCtZxH0RbD/es8aTYSgDef1DvKXHAjldybAXx/bZ6hPfWclhmMzdKhCwrnq2y
qBKrL5Orz+8fkBZhZccA6T48qa12V7Wfwzh7QGLrIG1tO1gzFU/8A5JBrNXep1qXuWGshxHT
mppaSwSkMyOz0uhaQJkVIFqR7CW3XmPtbNLT8LgrCzAsxT8gA8Q63S112D6gyJaHWNHUJ0MO
cPYPSJrLyjaQZ33OFHvS/QOSqNBr+m8tZgOIFRu23e2L+0LGOn9rUYDgUn7GVtdX7n2CtZyO
PRtycYzn1DAX3PgHo7u2cQsI3T3dop0i8+HZP/TLeiv12AA1NRZ9YxySnBKrzz5mfGlqsQwr
pR17a0Oqih+zrdtUEidWJQ5yGSqpTaJtW7YXCUjqgJgpsh6LnBxzz0k1MST23bRsJ3SfYapj
OqrKsogZuKm57xN0Uan7B8S/+AfEv/gHxD8g/sU/IP4B8S/+AfEPiH/xD4gL+Q8PrYYCdfCw
MAAAAABJRU5ErkJggg=='
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
view open.
	^ view view canvas
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
| view |
view := RTMondrian new.
view interaction noInteractions.

view interaction popup group: [ :group :el |
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

view shape rectangle size: #yourself.
view nodes: (1 to:50).
view layout grid.
view open.

	^ view view canvas
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
	b := RTMondrian new.
	b shape rectangle withTextAbove.
	b nodes: RTShape withAllSubclasses forEach: [:cls | 
		b shape rectangle color: Color red; size: #numberOfLinesOfCode.
		b nodes: cls methods. b layout grid ].
	b layout flow.
	b build.
	^ b view canvas
]

{ #category : #icons }
RTMondrianNewExample >> exampleNestingAndTitleIcon [
	^ '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
AAAASUVORK5CYII='
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
	^ b view canvas
]

{ #category : #icons }
RTMondrianNewExample >> exampleSimpleTreeIcon [
	^ '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
8QfEn76P/gCZdK8iJGbd0AAAAABJRU5ErkJggg=='
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
	^ b view canvas
]

{ #category : #icons }
RTMondrianNewExample >> exampleSystemComplexityIcon [
	^ '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
9IFIyy8ElWqfhvnNkQAAAABJRU5ErkJggg=='
]

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
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #sources }
RTCharterExample >> exampleLabelledBars [

| b |
b := RTCharterBuilder new.
b extent: 500 @ 200.
b interaction highlight.
b points: RTShape withAllSubclasses.
b allY: #numberOfMethods.
b stackX.
b histogramWithBarTitle: #name.
b axisY.
b newAxisConfiguration plain.
b axisX.
b build.

b build.
^ b view
]

{ #category : #icons }
RTCharterExample >> exampleLabelledBarsIcon [
	^ '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
QmCC'
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
		data := ((c rtmethods reverseSortedAs: #numberOfLinesOfCode ) collect: [ :m | m numberOfLinesOfCode ]).
		b shape ellipse size: 0.
		b points: data.
		b connectDotColor: (normalizer rtValue: c).
	].

	b allY: #yourself.
	b stackX.

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #icons }
RTCharterExample >> exampleMethodSize2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAHTElEQVR4XuWcW3PaRhTH+13z
CfoJ0ufkJXlIJkmbaZrmoddJ27RJHTu1Ox5fG5uLMZiLuUmgC7oLJATi7+4uAZwEp3YLNs35
z5xhVwgL7c979pzdFZ+cnNDXIukT+k1AHwh90QdCHwh90QdCHwh90QdCHwh90QdCHwh90QdC
X/SB0AdCX/SB0AdCX/SB0AdCX/SB0AdCX/SB0Bd9IPSB0Bd9IPSB0Bd9IPSB0Bd9IPSBMEVR
hFu3biGZTKLdbmN9fR1ra2t490PNZhPcRvWjgy24jgH6zTljILVaDc+fPxcgUqkUlpeXsbS0
9F5DB0EAx3HGxzmMXq9LH8hVuiwOhX7z0QdCHwh9IP9DIF3HQhzRH0MWBohXKIBDod+cC+Sy
0OvTB7IoQApZBYFKPw9ZHJflhtBL+/SBzBqI53m4d+8ewjAUjfv06VNMi6Z4li7L8lvHHV2j
D2TWQHiGzqHcuHEDuVwOkiTh2bNn/5ipc5XZwI5+TB/Kogzqhl5A3/ToA1kUIC3VRux16ANZ
pEx9EEb0gSwCkIqzhXZkwDYbQEx/HLlyIOp2AqFhwWwV0Tdc+kCuGogrKzDsEgydzWn59Ccd
rxyIqehQajm0tCIGAf1JxoUY1KM4gJTeE8cQD+hDmQWQRqMhGvLu3bsYJYpnram/m6lz2fUK
5ArrLdljxG5HWK9h0B9X/i2QbrcLbjwLTyQS515TH6nTM2FVJLQNB1E4dF2Dbg+x49MHchV5
iB1KONr+UxzvBiHiN1Mp9POTKwICJl2tIf/oh2GP6wT8kDgvdtr0oVxaYrhXRdsaNrjhF+EU
q5OQuGXB1gwEtofQ70CtyPTBzBsIh9GPhiuGupHBcX4yFd+PeuA26iW+5dAHchkuSy+3RN0J
ZSR2qnAKlakujU+txPSXe+cLZD37GTJ7v+J0w7tNHa79/uxvuF86CelHXfMF4qUe4WB/Eh4X
rVX0/CGMo4MmygWdzXO1hfHe49suYttH3/IQ1XX6cGYNpF7YRk1ewuvVlDh2LC2L15AN6EEn
EjY61zLa8Nxh9MVXGEUC2Q7pQ/kQkGw2C76efnqH+4cy9UQ6i2L+d3iGhuNCDdXSEnhO0j1j
AB8MAFt/ex9XX6c/2E8Fcvv2bdEw6XQaN2/exFm943SmbuzvwZYTyBdeot938e1Xz05s6xhK
IXVmI7umC999u2fwaZaoqokZY258vBmVe5qN8LAG+i7rnFGWmVuCpD4HTwbb/mvINQVScxOD
Xm9qI8Ys2lIbDvierotcV3g6tnYflRUMOh+fq5vNeki7CtNJoXO4gqachWmts+jWE+sjueIm
2sFkE10UT8qOacCyNahNB5rivjfefEgcBu85o5kA+kBOAZG1n6FZ25AqP6F88BRK6yv4nRy6
fRVNK4l0cQVGkEMUs8nH7rZ45eZ36nCiJML+cKxSZBs8KrvI9xiwgGDwEQUFMwFy+PUjVPNZ
dCMTjf3vsNJYPYl6Llw3hVYiA2XjNaRqAZarI2v8dtIbDBswbAencpcYdrQLr3cAx+qgG/Zw
ETf2sYw3MxtDQkVBvZhHrfYjtn9YQ72uYecojVLpG+aSXkKX/kJlf5lFYF/A1dOQ5JfMTa1A
bj6BZ2aFGepL5uaWWcCQgqJtQG48ZuW8sJa+A0n6ZZzPZFMNNOrWW/nNh8abfssZr9F084s7
nzYTIBpbUw/eJIJ2cg/JtVvQTdY7rAMoyiZUdQsl10JGKyPz+ku4hscAtVAv55FNr4z/TkM5
Bje/3oRXk7G39QKd0IXtq2g0CzhMriIIM8Kk430WpU2Sykpuk4HxYbPe5VosEVVz4/dalSQ6
bmtSL+yAz6sJOJ0WusHkPc88mjz30vVgO+VxPQhb4Daq+0EWk1C+JyLMcRjPyvzYuM7Wis46
d+ZA9nd3waGM6sm9T2E01oTlSp/jsPg5VGlN2GHyIRRbFlbIZ7Dz+wZKUlPY5m5a2Kj+y7cv
WJZfEZbY3sOrn15Ar5WE1YtPoEl/sHwmLaxRezAuK7U/UCt+DUvNCOPlZmWVlQ+ESeUvWOBx
JEzXXrGe+Yr10LwwRX4Mi/VIbqq+hXrj+3Fda71i/2Qr8MMjYar5iDWsLSzqNtFpZ8Z1XubH
RnUeeZ4+N+gcYa4ui77mmBjeuXMHo9dpH+JZerVaFTvj5238WrZtX8q1KpXKyWVch9/PWbMg
7wHhGxwePnyI+/fv48GDB1M/xLP0aZsc5iH+xS+rN3IglyF+P+cGQl//syjrPC5tFuK/JCEy
+zc/96Hr85mm5ztrdllQcv36dXEt0xxGQ9N22/xXvftA1LRtVhcGch6XNgttbGwgn+d5zfDn
PvjNDAaz34DHG4Tfy7Vr18TPifAHleI5bRh/94Goadus6LusjyUxpC/6QOgDoS/6QOgDod8E
9IHQF30g9IHQF30g9IHQF30g9IHQF30g9IHQF30g9EUfCH0g9EUfCH0g9EUfCH0g9EUfCH0g
9EUfCH3RB0IfCH1dWH8DoNfjw4zIKDgAAAAASUVORK5CYII='
]

{ #category : #icons }
RTCharterExample >> exampleMethodSizeIcon [
	^ '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
AElFTkSuQmCC'
]

{ #category : #sources }
RTCharterExample >> exampleMethods [

	| methods trachelMethods b |
	methods := Collection withAllSubclasses flatCollect: #rtmethods.
	trachelMethods := TRObject withAllSubclasses flatCollect: #rtmethods.

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
b build.
^ b view
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
b build.
^ b view
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

b build.
^ b view
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
RTCharterExample >> examplePopulationUSA [

| b  tab |
tab := RTTabTable new input: (ZnEasy get: 'https://www.census.gov/popest/data/state/asrh/2013/files/SCPRC-EST2013-18+POP-RES.csv') contents usingDelimiter: $,.
tab removeFirstRow.
tab convertColumnsAsInteger: #('POPESTIMATE2013' 'POPEST18PLUS2013').

b := RTDoubleBarBuilder new.
b pointName: [ :row | row at: (tab indexOfName: 'NAME') ].
b points: tab values allButFirst. 
b bottomValue: [ :row | ((row at: (tab indexOfName: 'POPESTIMATE2013')) / 1000) asInteger ] titled: 'Pop estimate'.
b topValue: [ :row | ((row at: (tab indexOfName: 'POPEST18PLUS2013')) / 1000) asInteger ] titled: 'Pop +18 estimate'.
b build.
^ b view
]

{ #category : #icons }
RTCharterExample >> examplePopulationUSAIcon [
	^ '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
XcWjA7UAAAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> exampleRandomScatterplot [

	| b |
	b := RTCharterBuilder new.
	b extent: 300 @ 300.
	b shape ellipse color: (Color blue alpha: 0.3).
	b interaction popup.
	b points: ((1 to: 50) collect: [:v | (v / 2) asInteger atRandom @ v atRandom ]).
	b x: #x.
	b y: #y.
	b axisXWithNumberOfTicks: 4; axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #icons }
RTCharterExample >> exampleRandomScatterplotIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADlUlEQVR4XuWdPWsiURSG83Nt
BfsUdmqRiAYNWOQHBAtDRGwk9gkIEkxSKEaLFFGERC08xuPuLMvufKvz9bwwSMJMdO7jnHvP
e8+9Odtu+YqSzvhNwAfCFx8IHwhffCB8IHzxgfCB8MUHwgfCFx8IX3wgfCB88YHwgfDFB8IH
wlfkgazXa7m4uJCbmxvRn7vdrnQ6Hfn3vOl0Knoc8gGfnkT4QBw0Go3k/v5e9PXx8VHa7ba0
Wq3/Gu77+1vm8/lBDbr7E3wgx5RC4QciPhA+ED4QPhA+ED4QPhA+ED4QPhC++ED4QCKh19fo
Z/18IHwg8dDdXTjwAgOyXLq/QS/n8vuQnRaLhVQqlT/2e71eF7MnQa339/f3/e/f3kTcNrSX
c/lAtr/mPxSKYb+Px2NpNBonsd/5QCIQsqKqzUZEj1OG28CAJCEMfXyI6GEHQ++TP8rihyw+
ECyQsPIBPhC++ED4QPiKfh5Ctkkil4ccY9zOBxLhkJWEstNEAUlC2elBQIrF4s7b2Qi/Uw8Z
yGQy2TeyFlifn5+LXfW7Yb/zdUIgq9VK9Oj1elIoFE5a/c4HEoE+RDtn2jIETGKodrnTHAYf
CB8IF0jcwl/oQPjWSYSA8K0TYMiK2xcBa79HNVTy50P4QE6nOBRT84HwgZgDIdshgQBRM7Hf
74tbIF6mcPnV7z6UzWb3Tq9WvlttMONU/W41/ORXv/uyJJ72yxHUgs/n82L1dLi13zX+++kD
klZIl6jqd6c+6uuLv6Qt0Op3pyKHOBRBhDLsvb2NZ5hxWo4QWyCfn/EE4mbBTmLyEKtOnV/9
HlKmrk9NXJ8cPhA+kOOGLCMM6TD00JHP3yEtCeGNvwrXZ07Dz0MCVlg5S2BAHh5kZ6OI+L1Z
yvx7YEAMGIdYGATD8aRAtOFfXrxPUGkmb4y4nDpqvrn4W5eXl1Iul8V4NTtHrffhcLjfmMbr
MZvN9tZ93K49dK9730Curq6kVqtJtVqV6+tr0w+h1rvf5Qh6g35vLo7XBtaHxE3NZlN0ridx
fYibkGb39Omr3WykmYyFROl02vbfaNhdm8lkZDAYiNUeYGYy9g9b7kYdXt83MCBuQpqVdBay
VCrZzkaayVhIpNPL2qhWC4nsrtUvUCqVstwDzEzG/mG5XE6en589vS8/ZNHzEL74QPhA+OID
4QPhiw+ED4QvPhC++ED4QPjiA+ED4YsPhA+ELz4QPhC+QtYPIMsvvK/HaI8AAAAASUVORK5C
YII='
]

{ #category : #sources }
RTCharterExample >> exampleScatterPlotSimple [

	| b |
	b := RTCharterBuilder new.
	b extent: 290 @ 200.
	b interaction popup.
	b shape ellipse size: 15; color: (Color red alpha: 0.3).
	b points: (Array with: 2 @ 3 with: 6 @ 6 with: 10 @ 5).
	b x: #x; y: #y min: 0 max: 10.
	b size: 10 min: 4 max: 10.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
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
b build.
^ b view
]

{ #category : #icons }
RTCharterExample >> exampleScatterplotWithHighlightingIcon [
	^ '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
rkJggg=='
]

{ #category : #sources }
RTCharterExample >> exampleScatterplotWithTitle [

	| b |
	b := RTCharterBuilder new.
	b extent: 300 @ 300.
	b shape ellipse color: (Color blue alpha: 0.3).
	b interaction popup.
	b points: RTObject withAllSubclasses.
	b x: #numberOfLinesOfCode.
	b y: #numberOfMethods.
	b size: #numberOfVariables min: 10 max: 25.

	b axisConfiguration 
			numberOfTicks: 4;
			title: 'LOC'.
	b axisX.

	b axisConfiguration 
			numberOfTicks: 4;
			title: 'NOM'.

	b axisY.
b build.
^ b view
]

{ #category : #icons }
RTCharterExample >> exampleScatterplotWithTitleIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFaElEQVR4XuWdzU8TXRTGUWNc
mBj/BJcm6saVrowrN279AxAWxjVhpSkJJBQInwEEBEkQlKYEEptSwAJa0kQpUsSYFAQFQUQQ
KV/DR8Kjc2YyUl4Lb/nqTHme5GbadO7cmfObe8+dc3vvJP3+zS8rKYnfBPxA+MUPhB8Iv/iB
8APhFz8QfiD84gfCD4Rf/ED4xQ+EHwi/+IHwA+GX5YG0trais7MTDQ0NkO+BQAAOhwO1tbXg
N7dJQNxuNzo6OjA1NYVQKISWlhaMjIzwA+FvssiArK6uorCwcMc7/907wOsFFhbAXzuOCog0
R7J1uVxobGxEXV2davAFiK+I3G98HPjwYUpLL1/yAzkyID6fD9PT0+jv70dlZSWys7MRDAbR
3d29zejLy4DfH1YdvAKpKfymtoAPWVhQIDWF38wWAaIoCj8MfiD8QPiB8APhB8IPhB8IPxB+
IPxA+MUPhB8Iv/iBsAKRoKKMDvIDMRGIhN9FRUVFcDqdSEtL04w+Ojr6j/EnJye1UcPjajx1
UBSSTAUi4feJiQl4PB4IBAm/+/3+qDUlHA7jONcSSwDh9yH8Tp0fCD8QfiD84gfCD4Rf/ED4
gfAD4QfCD4QfCD8QfiD8QBIJSElJCTY3N8EPxCJA2tvbkZycjObmZs3gAwMDWF5epgu/WwbI
4OAgMjIykJOTg6GhIfT09EQNsx/38Du/D+EHwg+EHwg/EH4g/ED4xQ+EHwg/EH4g/EDiAER9
0MeLF0AoZP3ZvK9eAV++HOw84wakt1c37OvXezvh9XXA4wFmZ60PRK5PoCQEEDlZI/HPXbcI
kCdPgPx8YGyMH8iRALHZbDED+fEDePQIePpUryX8pj9EIAUFBdoqQHa7XTNseXl5VANHht/X
1nQQFRV62u344sATwWdYBkhWVhbq6+vRq3pqCb9LmD3aeMj372F4vQqcTt3Ab9/qTZaaFV+/
7mxwASeOnB/IIevzZwUPH0JLz58DKytbjl0+75Tv2zdAahQ/kEPWx48KLl0Czp8HLl8Gmpr4
fYepQJxOBWfPAidOQNveuQPI3c9vdpOANDUpGgwDyO3betPFb3aTgNjtCk6f1oGcOgVcvAgU
F/MDMQ3Is2cKzpwBkpKgbS9cABwOfiCmAXG5FK1mnDwJnDsHlJXxwzAVyL17ilY7JN28Cbx5
8y8Q/iVk4wjkxo0tILduAZWV+jOJERH99El/JgkG+aHEBcj161tArl4FHjzYDuTXLx2IjHkk
shGrq6v/rnWfnp5u3fD7tWs6EOllXbkCpKZCDbVsByCf/++pXKLDVg7ZF6tdR1lIQeJ2paWl
aphoFpYHIj2s+/eBjAzg8WM9riUplriVEW7hb7IOoJ8/AQOI9LJsNv0pPRDQh2MNI8cS2VVj
l5DED2QHRa71LtW1TO3P/ncfGXp9/34cbvck7t5d0f50vZckofv5+fk95zM770H/R7AvIEtL
S9pa78PDw5CxkJqamqgnEQxOwucL7+sEpT3e78UlYt64+JBEU746WLOm9jD2mk8cuqwdZlkf
EkuTFikxQm5uLoxXYciyT/JWHrnbVtSBkwp1iNH4Hi3/4uKits/MzAyMYxnlSr6dJg2Nqd03
mXQktX1ubg4yMyyyHJmYtFu5MkAnw9iyZpjsZ7xdKNbrjhuQWJs0QxsbG8jMzISxFpesvSVb
eUeJHKOtre3v92j5ZcKQQJG0rjovOZZRrkwuysvLi5pPXrkhk44kdXV1oa+vTzOoUa4Ydbdy
5XUdKSkp2n6pap/e6/Vq1yA3hfxWVVUF/iaLv9vLL34g/ED4xQ+EHwi/+IHwix8IPxB+8QPh
B8IvfiD8QPjFD4QfCL9M1x8VaX6HWdsx8AAAAABJRU5ErkJggg=='
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
b build.
^ b view
]

{ #category : #sources }
RTCharterExample >> exampleSimpleCurve2 [

	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 300.
	b shape ellipse fillColor: (Color blue alpha: 0.3).
	b points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	b y: #numberOfMethods.

	b curve.
	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #icons }
RTCharterExample >> exampleSimpleCurve2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFFElEQVR4XuWd3U/TUBiH/Tu5
5YY/gAu9kZhhRhBCIIMAygViZgJTpsjHhMkSLkwIH2YJCMQlIyDqFjbY1m7A+Ol5u1QG7qMb
HSv+nqRpA+lJ+z7tOe17es4e/P7Nj5N4wB8CfiH88AvhF8IPvxB+IfzwC+EXwg+/EH4h/PAL
4YdfCL8QfviF8Avhh18Iq5De3l7kcjnwh6hJQiT43d3d8Pl88Hq9GBgYMGT09/djcHDwmpij
oyPIwh+++shmgW/fgIpCzs/P4XK50NnZaSxra2uYnJzE0NAQxsbGru2s6zpOTk74hdyCdDoH
W9sQkcIf1vqRG4BfiIPI5/P8QpwEAH4h//V7CL8QfiH8QviF8AvhF8IvhF8IP/xCnMXl5SX4
hTiIi4uL2oV0dHTwC2kQZ2dn1YWY6fdoNAq/3494PI7V1VUj23tzJ0m9Hx4e8gupk3g8C1Vr
WUu/b2xsQDqn1tfXEQ6HjcXj8fCn320VolUXwt+G3B2ZTIa/UXcS6XSaX4iTOD095RfiJCq1
v/xCmkAymeQX4iQSiQS/EP4qix/+Rv2+kEql+IXwvxjyUxZN0/iFOIlKsbsmZHNzE8FgEPxC
Gks2m7UmZGpqCu3t7YjFYsYOKysrCIVC/Ol3m7HUHyJEIhG43W7IU8DOzg4WFxcRCARQ6u7g
T7/XT7kPrfnbkCZRVxcuv5DGwf+Rg8Mo9+U7vxD+O4Qf/jaE/ymLH9veQ/iF3A2Vxv/zC2kC
4bDOL8QpFCYN4G/UHUM0egGRwi/EIWxtnVaMW0kh8/PzkFQ8vxD7yWTy1oXI1+4yDEFS8Lu7
u5ienkapwPOn328jJGNdyMjICFpbWyEzALW1teHg4AAzMzP86Xeb+PkTiETStVdZ/G1IYwiF
NIgUfiEOQLUAqsNPqxozfiENJp8HhoezePdOr3p38AtpIMkksL0NvHihlZ09jl/IHSBD1b5/
h7ojUpif15FIoKY48QuxmTdvdPj9uiGlnv35hdiACoWSoMHt1hAOX94qLvxCbsHGBvD2LfDy
ZRpfv8KWePALsdAmfPoE9YIMfPyoqXZBUw11Ck+fauoFOoe5OZQd4swv5NZX+5kR8EDgKuiP
H2uYmACCQSAWA378QMVsLb+QGjg+BmZnC8F9/jyNhw91lbvT4XIVrvYvXwoBj8cBaReacYyO
EyK3vwREAmMGx9z+/PkqoLJWuU9j/eoV8OiRjidPCosE2tyWv8uVLovHk/q7/69fcOQF1TAh
8lZaHFCph80AmgEdGEj/E8TOTl1VHTrevy8sHz5cbfv95yWFSNl21uOOEmLO9V5qzncTSb3v
7kbR25syrjpZirefPUupQB6rBi+hApYw1q9fZ+D1avD5NPW/wvrwUDPS+zJMWMqUbTuW+1Be
ubnz/xFizvUuqfjR0dGSO0nq3c7+EDlIOyf3v8/lNfX3Q6QzTCb9X1hYcGR1U8sAJqtUO9+a
hVip0qzQ19eHrq4utLS0YHl5WfU1b6mqba7k/FxWKJ7va1Y1LMPDwzDv+HrKk7Ex5gCm8fHx
v2XIeJl6yjTPzzxfGYtTHM+6hVip0qwgI7Oky1jm4ppQD/rbKjW6tLRUcn4uKxTP99XT02Nc
hXt7e3WXJ8dnDmDa3983yjUn0Jcqu1pX7E3M85NjkYtR7jw5vps/B8L/k0f/y2MvP/xC+IXw
wy+EXwh/CPiF8MMvhF8IP/xC+IXwwy+EXwg//EL4hfDDL4QffiH3hD80D8Gucb+qHgAAAABJ
RU5ErkJggg=='
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
	b points: #( 5 6 7 ).
	b connectDotColor: Color red.

	b points: #(1 7 10 4).
	b connectDotColor: Color blue.
	 
	b allY: #yourself.
	b stackX.

	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
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
		data := ((c rtmethods reverseSortedAs: #numberOfLinesOfCode ) collect: [ :m | m numberOfLinesOfCode ]).
		b shape ellipse size: 0.
		b points: data.
		b connectDotColor: (normalizer rtValue: c).
	].

	b allY: #yourself.
	b stackX.

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
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
b build.
^ b view
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

{ #category : #icons }
RTCharterExample >> exampleUsingLegendIcon [
	^ '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
AAAASUVORK5CYII='
]

{ #category : #sources }
RTCharterExample >> examplehistogramAndLegend [
| data b |
data := {
	Dictionary new
		at: 'COLOR' put: Color gray;
		at: 'TIME' put: (DateAndTime fromString: '2014-10-30 12:11:28.0');
		at: 'SECONDS' put: 4;
		yourself.
	Dictionary new
		at: 'COLOR' put: Color gray;
		at: 'TIME' put: (DateAndTime fromString: '2014-10-31 12:11:28.0');
		at: 'SECONDS' put: 5;
		yourself.
	Dictionary new
		at: 'COLOR' put: Color red;
		at: 'TIME' put: (DateAndTime fromString: '2014-10-31 12:41:28.0');
		at: 'SECONDS' put: 15;
		yourself.
	Dictionary new
		at: 'COLOR' put: Color green;
		at: 'TIME' put: (DateAndTime fromString: '2014-11-01 12:11:28.0');
		at: 'SECONDS' put: 7;
		yourself.
	Dictionary new
		at: 'COLOR' put: Color gray;
		at: 'TIME' put: (DateAndTime fromString: '2014-11-02 12:11:28.0');
		at: 'SECONDS' put: 1;
		yourself.
	Dictionary new
		at: 'COLOR' put: Color gray;
		at: 'TIME' put: (DateAndTime fromString: '2014-11-03 12:11:28.0');
		at: 'SECONDS' put: 4;
		yourself.
	}.
b := RTCharterBuilder new.
b extent: 300 @ 200.
b shape rectangle size: 0.
b points: data.
b y: [ :entry | entry at: 'SECONDS' ].
b stackX.
b shape rectangle 
	color: [ :entry | entry at: 'COLOR' ].

b interaction 
	highlightColored: Color red.
	
b histogramWithBarTitle: [ :entry | entry at: 'TIME' ].

b axisY.
b newAxisConfiguration plain.
b axisX.
b build.

^ b view
]

{ #category : #icons }
RTCharterExample >> examplehistogramAndLegendIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEaklEQVR4XuWcSU/rMBSF+8cf
QrACVkiAgB8BAjYgVGAB7JhBzPM8z4MYTl9P9CKhRxq7bWKcnFtFKeKoHj772r6xUyiV9M0n
K+hXgT4QfdMHog9E3/SB6APRN30g+kD0TR+IPhB90weib/pA9IHomz4QfSD65h2Qt7c3tLa2
oqurC/y7vb0dnZ2d+F/38vKC29vb4K5f7SkCeX9/R3NzMxYXF9HR0YGenh709vZGAqHGGZBC
IfJCQwP0XdY/29nZcVcZ+kD0gegD0QeiD0QfiD4QfSD6QPSB6APJLZDR0VEcHx8HhXx+fkZ3
dzf6+/t/LAD1F4aOgExMTIDhE14bGxsYHh7G4eEhhoaG9IHouyx9IPpA9IHoA9EHog9EH4g+
EH0g+kD0gSgBGRkZCQq6vb0dWWD9haFDIJ+fn0Ehp6amUCwW9YHou6zagTQg+lNEEfpAfgFI
AeVP6efnD/7oA9EHog9EH4g+kJwBQYzpA/kFII2NjZHX+Pi4fg/RB+IhkL29PfT19QWZX1hY
CJ6nn5ycVL3ZmhUade3u7mYKSDkfiCqHbWOsG8js7CxaWlqwvr4OrtRZ6W1tbVUDsa1o34GU
84Ko/I2NjSFTLksfiD4QfSD6QPSB6APRB6IPRB+IIhDb9YU+EEdAbCvaCyADAwMYHBzEx8cH
mpqaKj7CnZ6eLmV1YZgpIGtra1hZWcHl5SWOjo4qAmEYRP/FAQ5dFl8i8Pr6WnOFPzw8RMbB
atXx3Aobiut0bXW/PoaYCjEzMxOcM0lCRxiMs/GsSqVem0a6tjrvgbACWYivry8koSu7RyOM
NNK11XkL5OrqKjgSxwLEFcJWd3p6ivn5efB43d3dHVyla6vzGsjBwQH4POX+/h6Vdjx+HwtM
Ok4Y+JucXITnHuv5vaR13gNha76+vjYWgBMFk/vhlJv35eXlWBi2v5eGzlsgS0tLQUu+ublB
Ejq6p8nJSWxubsJlurY6r4GwR7Alzc3NxU4NbXX8H3vF4+MjX5AGV+na6rwHUnZTJQ66Jldl
o2PP4MVZzf7+PlylW43OWyD08VwX8Pv5+Tnq1YW9gzOpi4sLuEq3mvx5C4SF4LogbFn16mgc
MzjVNFVekulWkz+vgdCt8M6dKUnpOKCa3EUa6drovAYSLpLi3EqedN4CYWsKp6FxA25edF4D
4bx8a2sryDxfSJN3nddAvoe843w8dU9PT8514frBpAtjUyad10DYmniZwgihhtPWuMWcrS6M
idnqTOsH2xhbJnpIeCLXRvfjTEeNujAmZqszPUSzjbF5CyR0U3GtMy0d3ZRrnddAWAj6W5Ob
SkPHyjO5qaR1meghtoVIQ2cTaU1a5yUQ7rE6OzsLKi7Od+dF5zUQxnGYedPzh7zovAbCKSHv
jHhyh0XedV4D4bqAm+J4jytEXnSZ6CHcDLe6ugoVnfdAOAAq6TI57dU3fSD6QPRNH4g+EH3T
B6Jv+kD0geibPhB9IPqmD0QfiL7pA9EHom/6QPTtu/0FqmGYm4sjmtYAAAAASUVORK5CYII='
]

{ #category : #accessing }
RTCharterExample >> label [
	^ 'Charter example'
]

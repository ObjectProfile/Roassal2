"
RTGrapherExample new installTitle: 'histogram' 
		code:
		'
	| grapher dataSet |
	grapher := RTGrapherBuilder new.
	grapher extent: 300 @ 200.
	
	dataSet := RTDataSet new 
		points: RTShape withAllSubclasses; 
		stackX; 
		y: #numberOfMethods.
	dataSet barShape width: 10.
	grapher add: dataSet.

	dataSet := RTDataSet new 
		points: RTShape withAllSubclasses; 
		stackX; 
		y: #numberOfMethods.
	dataSet dotShape color: (Color red alpha: 0.3).
	grapher add: dataSet.

	grapher resetAxisConfiguration.
	grapher axisY.
	grapher axisXNoLabel.
	grapher build.
	
grapher open.
^ grapher view canvas'
	
"
Class {
	#name : #RTGrapherExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #sources }
RTGrapherExample >> exampleEbola [

| tab data b |
"Preparing the data"
tab := RTTabTable new input: (ZnEasy get: 'http://mapstory.org/geoserver/wfs?typename=geonode%3AEbola2&outputFormat=csv&version=1.0.0&request=GetFeature&service=WFS') contents usingDelimiter: $,.
tab removeFirstRow.
tab replaceEmptyValuesWith: '0' inColumns: #(10 11).
tab convertColumnsAsInteger: #(10 11).
tab convertColumnsAsDateAndTime: #(3 4).
data := tab values reversed.


b := RTGrapherBuilder new.
b extent: 350 @ 150.

ds := RTDataSet new.
ds interaction popupText: [ :row | row at: 12 ].
ds dotShape ellipse 
	color: (Color blue alpha: 0.3);
	size: [ :row  | (row at: 11) / 5 ].
ds points: data.
ds highlightIf: [ :row | (row at: 10) > 100 ] using: [ :row | row third year ].
ds y: [ :r | r at: 10 ].
ds interaction popup.
ds stackX.
ds connectColor: Color black.

b add: ds.
b axisX; axisY.

b build.

b open.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleEbolaIcon [
	^ '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
Ifwxffgff5Jw1WkAY5wAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleScatterPlot2 [

	| b |
	b := RTGrapherBuilder new.
	b extent: 290 @ 200.
	b interaction popup.
	
	ds := RTDataSet new.
	ds dotShape ellipse size: 15; color: (Color red alpha: 0.3).
	ds points: RTObject withAllSubclasses.
	 
	ds x: #numberOfMethods; y: #numberOfVariables.
	ds dotSize: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
	
	b add: ds.
	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
	b build.
	b open.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleScatterPlot2Icon [
	^ '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
VgAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampledoubleCurves [

| f g b ds xValues |
f := [ :x | x ].
g := [ :x | x * x ].

xValues := (0 to: 100 by: 0.1).

b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds := RTDataSet new.
ds points: xValues.
ds y: g.
ds x: #yourself.
ds connectColor: Color green.
b add: ds.

ds := RTDataSet new.
ds points: xValues.
ds y: f.
ds x: #yourself.
ds connectColor: Color blue.
b add: ds.

b axisX; axisY.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampledoubleCurvesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAErklEQVR4XuWc20sqURTG+2d7
6qGnXnqoFIrEJ4kkrOhiIKQIUUnTdMPqxSAqKCroQkfnona/39Y+rQ0TdjBRjzrjfB8srJzR
cX6z117fmm0tQuDLSWrBPwX4QPCFDwQfCL7wgeADwRc+EHwg+MIHgg8EX/hA8IUPBB8IvvCB
4APBFz4QfCD4wgeCDwRf+EDwhQ8EHwi+8IHgA8EXPhB8IPhyLpC3tzd6f3+XkclkiP9mmiZx
8M/Wc/intkFAUqkUHR0dybi+vqb29nbyeDzU09MjH63nrO01TSMOlBN6d3dHj4+P1DAgra2t
tLi4KKO7u5tWVlaot7eXvF4vJZPJ7+es7Z+enogDAcbz87Pw5D3i9fWV8OcQm/X5+UkT+oQc
IfiTugOkmAqdGWf4VZYTpBkaxc044Ze9DtD9/T2NG+OiVpUlPpD/m8TJn/OL/6mq8IHUcBKf
ycwILv3xnbpDJnFN1+w3hre3t5ROpymXy0l/wW690J1bjt3NOjVOhWqq5AinzorH49TX10d7
e3uyZWK5c8ut/6hAXObUs9kszWXmZMpyDJDDw0MaHh6mhYUF6urq+nbnPp9PuvbCbd3k1Dk7
BM2g7OfV6z3w55Ay9XVRybYIt0fqKXwg5cGoeXmLD6RKcXoa18fFzc1NQ9IuPpAS4spR/aOK
y8vLhs2B+EB+0cfHB81mZkWjK0R8IL+MDAmjDsYPH0gVIyORTtgCoyogfDes8B66m5w6f4b5
9LxtMKoCEo1GpQlkV97W1uYap87VlBwZNh9rxUAODg6os7NT3kNfW1tzhVNn0zetTTtidMPP
Iey8fTlfzdvo+ECqEPemvHmvvOvnlGOCBaLrOg2ZQ3XvTeEDKUOb2U2aTc/WtWuLD6SCslbN
qo4tMmCAPDw80IA5IAzDcHTFBwHky1uIiBZpSPscH0jpkpaiWpQUQ2maFfkVA9nf36dEIkHB
YJC4bNza2qL19XVpEgOBAA0ODjrCqfO9b3/WL3gxRjNdRFU59aWlJbnAob+/n1ZXV0lVVVIU
hTo6OigUCtnq1K1REdNj9PLy0nR9NdekLF4FwnNFIBsQ+Xy+aRucrgDCd/RCZkikjFTTf3ur
qYFw/4kXOnOKaoYKyrVArq6uZNsjZIQc1YeCAsKpiOcGTk1hLUyNWgWCD6TIaIhpMQrrYTlH
uCU1NQ0QHglfc4NQ0gpF9IgYMUaIoQgQtThhBDCAZDpJXLLyJL1xsSEh1GtBs2uB7OzsEDft
ijl0SxcXFxQO6z9iakoXHBNTGTH5FeEpTf7+73alYnJSKxljYzpFo5qwI/gCswUIt0x2d3dl
G2V0dJR+a2Fw64Sv+ErDartUu2+1J4b3s2NfVzl1/JRVo5RWTNzA5FUsJycnVPg65exb2PSs
dF8W9+oqfV/rf77w9vxFJv6shcfgGCDlpLRi4gbl+fk5LS8v0/Hxsewml9ugLGx6VrovXzi8
FKjS9+UmJgdvz6/Bx7+9vS2PAT9l4acsfOEDwQeCL3wg+EDwhQ8EX/hA8IHgCx8IPhB84QPB
B4IvfCD4QPCFDwRf+EDwgeALHwg+EHzhA8EHgi98IPhA8IUPBF/4QPCB4KtM/QXWS8k76Tz9
LAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> examplehistogram [

	| grapher dataSet |
	grapher := RTGrapherBuilder new.
	grapher extent: 300 @ 200.
	
	dataSet := RTDataSet new 
		points: RTShape withAllSubclasses; 
		stackX; 
		y: #numberOfMethods.
	dataSet barShape width: 10.
	grapher add: dataSet.

	dataSet := RTDataSet new 
		points: RTShape withAllSubclasses; 
		stackX; 
		y: #numberOfMethods.
	dataSet dotShape color: (Color red alpha: 0.3).
	grapher add: dataSet.

	grapher resetAxisConfiguration.
	grapher axisY.
	grapher axisXNoLabel.
	grapher build.

^ grapher view
]

{ #category : #icons }
RTGrapherExample >> examplehistogramIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADa0lEQVR4XuXb3UtiQRzG8f5a
/4aEIIjAy7rpMuquojJ6EyIKjS4qgl6oFCpfWozdCzUVKiIe9/xmnbAyazc12+8Dw8Rh6Bzm
c2ZOvw6nr1bjp5fSx58CPgg/fBA+CD98ED4IP3wQPgg/fBA+CD98EH74IHwQfvggfBB++CB8
EH74IHwQfvgg/PBB+CD88EH4IPzwQfgg/PBB+CD8fF+Q6elpTU1NaXl5WQMDA7Jji4uLWlpa
UuO4h4cH3d7eyvp2XKyKRfFBmmRvb0/r6+uKRqOamZkJ5qmoVCql09PTZxNWqVS0v78v6z97
oaVSqZaPxVzPB2l2t9Zzd3fXcgWk0+m23NUGkclk+CCfDR+ED8IH4YPwQfggfBA+CB+ED/KN
K3Ur9gYHB2uTk5NuwmOxmCKRyKtKPZlMtqVS54O8U6mfnJwoHA7LfrZjQ0NDGh4e7milzgf5
y1jVzt+y+M8QPggfhA/CB+GD8EH4IHwQPggfpBMgiURCOzs7ssm2d+Z2bG1t7dXE8yv1LoFs
bW2pv79foVBIm5ubyuVyqlarryadX6l3CeTs7Ezb29vy1fnu7q7GxsbE37L4zxA+CB+ED8IH
4YPwQfggfBA+CB+kkyAbGxsqFAquBuFX6l8MMjEx8fQZwv39Pb9S74UVYp8g+P9j8St1/jOE
D8IH4YPwQToJouAdisrlZzian9f/ClJZXVUpn1dPgliyqdSfCc1kVF5YkE1sNpl0E6zzc+ni
Qp0C0dWVrHUTxK7VWs+C+Av0rXGCM+m0a61WzWdAcoeHrgXvbmrVkRH7LpIP0hKkfsz+lLZV
Y305GlUpm1U7QJqd82n13NxIwRtQv61+W5CjoyMdHBy8WaW/rNQ/CtLYv9zi/PibeFzWGldU
ZWVFpetrt2/b/u1Xg9VKzc5pEH7ibDu1c/6Ix12vx0fXGleUH+8RXV//bt5fjxs/Our6roOc
B/u+tbeqdF+pXweT5HvDuby8fLddBM+Tj4yzlgtujH/5HT/n5pQ9Pm46Ph+sGGvNxlv7NTvr
xhfGx1uex9I1EFsdx8HFtarSnz1Y66nx87XPEH74IHwQfvggfBB++CB8EH74IPzwQfgg/PBB
+CD88EH4IPzwQfgg/PBB+OGD8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DzofwGc3EH7cin
41IAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> examplescatterPlots [

| methodsRoassal methodsTrachel greatestAge b ds | 
methodsRoassal := RTObject withAllSubclasses flatCollect: #rtmethods.
methodsTrachel := TRObject withAllSubclasses flatCollect: #rtmethods.

methodsRoassal := methodsRoassal select: [ :m | m numberOfLinesOfCode < 300 ].
methodsTrachel := methodsTrachel select: [ :m | m numberOfLinesOfCode < 300 ].

greatestAge := (methodsTrachel , methodsRoassal collect: [ :m | m date asUnixTime ]) min.

b := RTGrapherBuilder new.
b extent: 300 @ 300.

ds := RTDataSet new
				points: methodsRoassal;
				x: [ :m | (m date asUnixTime - greatestAge) / 3600 ];
				y: #numberOfLinesOfCode.
ds dotShape circle color: (Color blue alpha: 0.3); size: 5.
ds interaction popup.
b add: ds.

ds := RTDataSet new
				points: methodsTrachel;
				x: [ :m | (m date asUnixTime - greatestAge) / 3600 ];
				y: #numberOfLinesOfCode.
ds dotShape circle color: (Color red alpha: 0.3); size: 5.
ds interaction popup.
b add: ds.


"b allX: [ :m | (m date asUnixTime - greatestAge) / 3600 ] .
b allY: #numberOfLinesOfCode.
"
b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.
"b axisX; axisY."
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> examplescatterPlotsIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> examplesinAndCos [
| b ds |
b := RTGrapherBuilder new.
b extent: 400 @ 400.

ds := RTDataSet new.
ds dotShape rectangle size: 0.
ds points: (-3 to: 3.1415 * 5 by: 0.01).
ds y: [ :v | v sin ].
ds x: #yourself.
ds connectColor: (Color red alpha: 0.4).
b add: ds.

ds := RTDataSet new.
ds dotShape rectangle size: 0.
ds points: (0 to: 3.1415 * 5 by: 0.01).
ds y: [ :v | v cos ].
ds x: #yourself.
ds connectColor: (Color blue alpha: 0.4).
b add: ds.

b axisX.
b axisY.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> examplesinAndCosIcon [
	^ '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'
]

{ #category : #accessing }
RTGrapherExample >> label [
	^ 'Grapher'
]

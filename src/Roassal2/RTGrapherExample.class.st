"
RTGrapherExample new installTitle: 'sinAndCos' 
		code:
		'| b ds |
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

b open.
b view canvas'
	
"
Class {
	#name : #RTGrapherExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Charter'
}

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
b open.
b  view canvas.
		
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

b open.
b view canvas
]

{ #category : #icons }
RTGrapherExample >> examplesinAndCosIcon [
	^ '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'
]

{ #category : #accessing }
RTGrapherExample >> label [
	^ 'Grapher'
]

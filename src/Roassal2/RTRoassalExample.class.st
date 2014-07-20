"
RTRoassalExample new installTitle: 'GroupOfGroups' 
		code:
		'
v canvas'
	
"
Class {
	#name : #RTRoassalExample,
	#superclass : #RTAbstractExample,
	#instVars : [
		'methods',
		'methodElements'
	],
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #sources }
RTRoassalExample >> exampleAddingNodeDynamically [
| v stepping |
v := RTView new.
v @ RTDraggableView.
stepping := RTSpringLayoutStepping new view: v.
stepping after: [ v canvas camera focusOnCenter ].
v addAnimation: stepping.

v canvas addMenu: 'Add circle' callback: [ 
	| el |
	el := (RTEllipse new size: 20; color: (Color blue alpha: 0.4)) element.
	el @ RTDraggable.
	el translateTo: 5 atRandom @ 5 atRandom.
	v add: el.
	stepping addNode: el.
	v signalUpdate.
].

v canvas addMenu: 'Add connected circle' callback: [ 
	| el edge |
	el := (RTEllipse new size: 20; color: (Color blue alpha: 0.4)) element.
	el @ RTDraggable.
	el translateTo: 5 atRandom @ 5 atRandom.
	v add: el.

	edge := RTLine edgeFrom: el to: v elements atRandom.
	v add: edge.

	stepping addNode: el; addEdge: edge.
	v signalUpdate.
].
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleAddingNodeDynamicallyIcon [
	^ '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
t8bt/+2frM7BYLwVAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleAnimatedCircle [
	| nbOfCircles  v shape mousePos |
	nbOfCircles := 25.
	
	mousePos := 50 @ 50.
	v := RTView new.
	shape := RTEllipse new sizeElement: [ :el | ((el position - mousePos) r abs / 3) min: 50 ]; color: (Color blue alpha: 0.4).
	v addAll: (shape elementsOn: (1 to: nbOfCircles)).
	RTGridLayout on: v elements.
	
	v on: TRMouseMove do: [ :evt |  Transcript show: evt positionFromCamera printString; cr . mousePos := evt positionFromCamera. v elements do: #updateShape. v canvas signalUpdate ].
	
	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleAnimatedCircleIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAD8UlEQVR4XuWZCUuVQRSGp5Jc
U3HJNENBczfXLCuXXHFX3BUVS/3/PyHepsM3M3cSkYLieWDg+vrduTBnzvo5Pnz48OHDhw8f
Pnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8f
Pnz48OFzD2/eOHdx4dzdnXOTk4U+MeG1y0vnOjq89uSJcwsLXt/YcK6hweutrc4dHnr98+di
j6Eh575/92tkpNA/ffLPHh3574r6eufW172+uOjcs2dQg+gAwvX6tT+kVBdzc7G2u+v1q6tY
lyEqK0v3qKlxrq8v1r5983tsb8e6jMI3yJ33DPOOcMk7jo/zhkq16Wnveane1eXc+/cP20Ne
i+TkJD6IxkYfPkLt/Nw/qwMN9bU1r29txbqFodvbQtNnGTX1Pn1XLC/Hen8/1CBVVYVX6FYb
Cl2mv3hR6OPjPtdIN3TQ+lv6wECht7QUe7x6Vei9vcUeT5/GeUtLv4Gmudm57u5SXR7x8mWs
6QB1eysqYl1GU35IaW+PDW3o2draWCsv93tjE7pQVWRhYmen0MMkOztb3Pibm9LQ9PZtHN7k
dUIhzXRVUHboYZg0I4ahTL8RehQ6qQ8OllZClnhXVvIVUvrs1JRzdXWluvJTrmDIVWqbm3yD
/Fyjo84ND+errDR5K1Hn9vj40fcoqS4v+F2VFXqe1v4+1CDWjFkTaElWocd0NYFpWNHq7PS6
DBAaSZ4gFALTnkUVXFh9WThMy2QLh0jkEQolYTKVYaS9exc/a2EnTdQ9PV5X8xeiiimtmqyy
U7UVYpVdUxO8ylIYUXJXtRUevEYcygcKV4YS+Py8D20hOkh18qqqDHXr8h6t6ur44OUZYeks
ZHztLeNiUZgKQ4UOTiVtqF1fF6VqqGuulYYmG7/kcksu7O3t5ccyKi74Sf2e0YnC2enpw8Ye
8jYNJFNd3iWPe8geqrr4Bvk1b8odppiZibWzs9IRiZZyhvqNdA/ljrGx/N7pnEyhC0lbW37C
+vVraQgSKkftBlsCV8NoRgn7B4Ud2yMcv6tqs4rMGkDlG3sNoFE+Hz7/BkqydrtVbRkWWvS/
sCew261bXFZW9BZ2u5eW+Gf6R3OI+guFkVyctzd9tiy06I1gqIfhic9fqrLUKD60yvryhX+u
jyadISn8aJSem1np5of66qrXDw7yIxU+j+D5c19RadakiivMLWr41PyF7z7UTStUffgQ7yOv
kJ57r8KHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+
fPjw4cOHDx8+fPjw4cOHD5//mx9m6Vpqr6HZGwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleAnotherTreeLayout [
	| view elements |
	view := RTView new.	
	elements := RTBox elementsOn: (1 to: 100).
	elements @ RTDraggable.
	view addAll: elements.
	RTEdge 
		buildEdgesFromObjects: (1 to: 100)
		from: [ :v | v // 2 ] to: #yourself 
		using: (RTLine new color: Color purple) inView: view.
	RTTreeLayout on: view elements edges: view edges.
	
	view edges do: [ :e | e trachelShape pushBack ].
	
	view @ RTDraggableView.
	view openWithMenu.
	view canvas
]

{ #category : #icons }
RTRoassalExample >> exampleAnotherTreeLayoutIcon [
	^ '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
gg=='
]

{ #category : #sources }
RTRoassalExample >> exampleArrow [
| v es c arrow |
v := RTView new.
c := RTMultiLinearColor new.
es := (RTEllipse new size: 30; color: [ :e | c level: e / 10 ]) elementsOn: (1 to: 10).
v addAll: es.
es @ RTDraggable.

arrow := RTArrow new 
			color: Color red; 
			attachPoint: RTVerticalAttachPoint instance.

RTEdge 
	buildEdgesFromObjects: (1 to: 10) 
	from: [ :n | n // 2 ] 
	to: #yourself 
	using: arrow
	inView: v.

RTTreeLayout new on: es.

v  open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleArrowIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAFKklEQVR4XuXa20+bZRwH8DeZ
Xmy72Y033vgXmE3RcTEvvJjRmI0sMTHgjQkaJGbrJDswI6Q6Ix64YAnLSEtwcQQZ4TBoDDAP
VBAYh25jcoaV4UopR0XAAqX9vr5PyVv6tm9HW4pgvt8nv0D6vjTwfHif533ep5Is82cvReLv
An4Q/vCD8IPwhx+EH4Q//CD8IPzhB+EH4Q8/CH/4QfhB+MMPwg/CH34QfhD+8IPwg/CHH4Q/
/CD8IPzhB+EH4Q8/CD8If/hB+EH4ww/CH34QfhD+kIE8Sv8MNilJFvX7cyfgXVgCP8guZfpq
RQBDrZ5njvOD7FbuK50fCiKKH2SX0n84jR9kL2Xhx44wkMFX3uMfsnYVpb4Njw35GH/xFJxG
E/9d1m4HbW3AnTvA+jrQ2gpYLPxXyH8KoHS8/+vYGDA8DJGwc+rqgOVl4MED8IPsNEhlJdDZ
CXR1bdnZWFwE+vqA6mqgvx+YmQE/SAKzVFoDX1YWMD4eU8fC6wUuXoQ3+xImeufBD7LNjNf1
wLzvA5ikDFlUd25dbCBKrqY0IkMyyaIuH6nC5MCf4AeJI+srngBEcDmtQ1F3aHHqzwEMtb54
qYYfJJ70FjbpgtiMlqjfIxRDLX6QODLZMqIP8mn0t7cXni0FP0gCU/NyngbF/FQmPEsrUYMM
WZ1hGOVnWvmHrLjnEfcaxBD1y/MGdOXUYrrrUcyd2f7dMMoyW2B++ydYjDbw32Vtd/0hVuMd
HUB7u7/ieo+SEuDWLf7b3m1BtLQACwv+BV7gNZcLmJiAWF9E9R5iUWi1bv682Qz4fPxDVlwg
djvQ3Q31kYnmmMMBP9jNm0/sXLGqF+cGP35BbS0wNwd+kFhW5gteTKekAwMDETtOXDme9AwM
/KbfuYMtw5i9diPs2GpVNcbPf8IPEvXa4dUhJEk2WS2bdVH3vORkQFL+CrWamzceNjbfXYSU
ZJPVSn53MND5JwobIGWYZLUquh+CH+QJKSuY0mCoFZrsbC2GWv4/LAhDrUuFDtTcG9NgqLXi
8YIfJELOvDGiC9LXqf1Eyf79sYEcOHYXRotN1gP5urGHHyRSCs45dEHcS9r/4pMnYwNJyRoV
ILpXyL0/ZvlBIuUfpeNDMcScEnqe2OoIxUhL25hDUj+2IxSk3+72H9uXadagHM2r4Z9Dtop7
2YsrFxzIPdqIymuRN5acTsBgAFJfn0d5uXb3sKxhHqfOjcKQ/xiuOU/gmE95HJ9T24XXCn7A
lw33wX+XFe0apKhoY598bW3r3cGmpv/1XvqeBsHkJGDbfN6k7o1HgvGfr4CIfXR+kJ0AOXsW
mN/caoXbDZSWAsXF+iCNjcoYlMN/hexE7H/PwJV1OmyYQn09Rr45jzWfJ6zjZzELe8VX/CCJ
TJvrIQ6UnIZkypBFie/bp+z+Ts6dKIJkS5LVenPE4H99FatIVpokb7bbuM3/uaxE5HDl5QCG
WkeqPodjbVqDoVbtX7/ifaUFY6iNHyQRv0gIhlr5rhu6IEanST6Ig/wgO5VD18+GXSGHrn+E
XveoLsiVqe/xltL4QXYoVudQ2NUhXhM5PvyhBuWF/nf880Qf+vC00oIx8pDHP4ckKq0u5VmT
zSKLEpN88LG8yW8hhilRPmzu9jnhhFHeaOUo51+H8IcfhB+EP/wg/CD84QfhDz8IPwh/+EH4
QfjDD8IPwh9+EH4Q/vCD8IcfhB+EP/wg/CD84QfhB+EPPwg/CH/4QfjDD8IPwh9+EH4Q/vCD
8IPwhx+ELf8CoRrNZjC/o6EAAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleArrowedAndLabelledLine [
| v e1 e2 l |
v := RTView new.

e1 := (RTEllipse new size: 20) elementOn: 'hello'.
e2 := (RTEllipse new size: 20) elementOn: 'world'.

e1 @ RTDraggable.
e2 @ RTDraggable.

l := RTEdge from: e1 to: e2.
l + (RTLine new color: Color red).
l + (RTSimpleArrowHead new color: Color red).

e2 translateBy: 60 @ 80.
v addAll: { e1 . e2 . l }.

e1 @ RTLabelled.
e2 @ RTLabelled.

"Note that the RTLabelled interaction has to be set after having added the element in the view"
l @ (RTLabelled new text: 'lining up!').

v open.
v canvas.
]

{ #category : #icons }
RTRoassalExample >> exampleArrowedAndLabelledLineIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAACf0lEQVR4XuXZ3YtSQRyH8QPi
S0q+oK6ix1fwbdd1u3BR0VUQsRA2iLroogOxhHSVFBEERRcSLCh0ZRd7sYW3etOl1GVdebm3
C3YRsftXnM4IQl120c6J58MMczyeq+8wDL8ZhY+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+P
j4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4/vf5NIJJq//47FYnV+KhI1m81XvV5v
0u12x5qmfa7X6y/y+fydWq32jJ+OpBXi9/uzPp8vHQ6H98QKSSaTrUgkss9PRyKHw3FtMBi8
Ed1utzv4iUg2n8+/rVYrXfTZbPaVn4hkm8n4OZutR34ikk2n04WYiB+LhT49PV3wEzGBfr//
XHRNUTR+GiazvW58phE2mlEh8otEs60Si6JY+EmYCH8/kUgcm3i93lSpVHrgcrm2RBVfrVYH
R9nssVHF3xDfuN1u1ajiy8b7p0Yx6eWn9o8nJB6PN1RVrVYqlSfinCuTyfSM8fX+zs5D8Y34
v1wuPxbPTqczwE9NgmKxeP9od/ed2E+sVqtTdJvNdp2fjGStdeMzlXvr9qdQKFQSY6FQuMtP
6IqJe5JbBwdvG43GS3FM3+l0jsXmHwwGt8W+w0/oihnht1KpVDupqo1cLnf7Ziz2yOPxJNLp
dCcajVb4CUnStljaw+Hw/afDwy/8+xMTWC6Xl5eTif797Ew3ni/4iUi2Oj/XL05O9M09Cj8R
ycbj8cfNZIxGow/8REwgEAhsic5Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+P
j4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+P76/8Al/ZjWaoPOt3AAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleArrowedBezier [
	| v shape  edge els |
	v := RTView new.
	shape := RTEllipse new size: 10; color: (Color purple alpha: 0.3).
	els := (shape elementsOn: (1 to: 6)) @ RTDraggable.
	v addAll: els .
	RTHorizontalLineLayout on: v elements.
	edge := (RTEdge from: els first to: els last) + ((RTBezierLine new controllingElements: v elements)  + (RTEmptyArrowHead new) ).
	v add: edge.

	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleArrowedBezierIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAABCUlEQVR4XuXRIQoCURQF0A8i
DGgSwWCTCTpBTAb34Tp+NAjKiLgBbWYXNGifJVjsyjSxOQyInAMvXG67L/h8Pp/P5/P5fD6f
z+fz+Xw+n8/n8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/lI
aZpO/BUa0ArtpIlcFMU9y7LZZ+/7wiCMFpt4uMQYt9Wt4vpUN5dl+bwWt8e4M1/6y9aUhG6/
F4bTJnL1kP3ucH7vfT+U5/nRX8Hn8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6f
z+fz+Xw+n8/n8/l8Pp/P5/P5fD6fz+fz+Xw+n+/vvADh2zp6vpL8RAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleArrowedEdges [

| view els |
view := RTView new.
els := (RTBox new size: 10; color: Color blue; borderColor: Color veryLightGray) elementsOn: Collection withAllSubclasses.
els @ RTDraggable.
view addAll: els.
RTEdge
        buildEdgesFromObjects: Collection withAllSubclasses
        from: #yourself
        toAll: #subclasses
        using: ((RTLine new attachPoint: RTShorterDistanceAttachPoint new; color: Color veryDarkGray) + (RTSimpleArrowHead new attachPoint: RTShorterDistanceAttachPoint new; color: Color veryDarkGray))
        inView: view.

RTTreeLayout on: els.
view open.

view  canvas
]

{ #category : #icons }
RTRoassalExample >> exampleArrowedEdgesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAK5klEQVR4XuVaC1BU1xnmoYCA
8oYFFcUHD+WxsCBPeRpBjI0BdUFAiFJfiBSpkNLWTetUatNOO6YzhnTyaia1Y6bROJOEWBtH
m1c7wSZt+piaibbp1EwS42T6SCbt5Pb72HuaG2AXFlB2+b+ZO7t77z3n/uf/zvn/7/x3veRD
PuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRDPuRD
PuRDPuRDPuRDPuRDPuRDPgSiufmK5uWlac3NzTb53nARs2bNCps3b15eTExMc3x8/N2LFi2y
4bM3Njb2i6GhoWV+fn4xQUFBaVFRUVsWLFhwYOnSpfdmZ2f/JjMz80W02YZ7SufPn78PfeSj
O28jIR0dHb/Iy8u7ajabLyQmJt6/ZMmSvpycnDeysrJeTktLe3r16tX/Ki0t/bSkpOQ/ubm5
b+Ke44sXL7YNP2DT12hPcHBwunqGW2D27NkRMCoTztm8cOHCgzD0q3QevndHR0dvhVNy586d
mxMeHr4uLi6uDdcPcTB0NJzXhGurSICTR/jCweVwcNucOXMS/f39F8IRO9FftY+PT8BEbAah
Jtqampp6isTQFthqVdfDwsLW0DZfX99gjgvfG3B9ixobjq+kp6c/Q/KKi4s/yc/P/xtI/it+
/wO//w0ySeh/8f2jgoKC9/D5Ma79s7Cw8D0Q/9Ly5cvvG41k+ozP4zi9vb1nORwAb6QhMKqB
M5cDmipCSSZnM0lTDuBzQFLEzZ5MILqCRICASpPJtG3ZsmXHSBLO1TlyCNqUkCxOosjIyI0R
ERG347SPuo4JM58TET7rItHotwUE/BDEvIOV+PtVq1b9CWQ+m5GR8XxRUdGHFotlcOXKlSex
wl8naSQW917D59tY8S/h+qsg8n0c72LFXmY/Ex5wQEDAYqyK3RjwWszmQM48faYvc5cVjpD3
JU4GTjTYupdHQkLCt7gq4bTzsDUJ4XGlHv5ISJlqGxgYmGTsC/cUgoC7SBaJImFc4Y6ejX5T
6R+uePhlP1cent2HEPw9TIwzXFEkEwTXI3T2g7TfgsQbo8cRX98QzGYrDxgQipluYaccnKfl
LNiczTzAfIIQHJWcnPwoxmPmCoJTa0hWUlLSgzyH1dGoiMAEu228zyBZzDnw2zySxUiAVejr
aBUaf6vJjMnTAXvuYMyNBfPb0dEGXpyBIiIEM/NwQsKjH3l7f6IVFrb/nAIgPPxlrbS0azA8
/BUtI+PJX1osl7TAwCva5s2bT0ZHn9XM5g+0pKQTV3mv2dxhm8SEyCFZKpdSsISGfv88+/Xx
6b1nRAMks69jae1icgsJCSlGAjqkn9uDsLTE08n4TBofHeju7tcqK3fZmpre1A4efFDLyqqx
NTZe1nbt2n+2vv45bdu2C1pNTc3dRUXntK6uk9rWrf0DVHBsMxX2QKys5erJyOiwsd+Cgt4n
uDI/d5OKhYxlWNLRjHlcKWDWgiT155SUlMeQxL7MZMYkxmTGA/e1MkZzCTpanh4GH0rqmyQw
SuD4rBHOtwsfC3ydO2pDxlTGW7I4jNlqrJ7V/M6kDWJ24Fwl5SUP5Jd2ELSDmp/6n7+ZcxBb
C0g0lRXIjnFXJpQQUYRggvlNUb+JVK3MLWPkoDwlLBxCaffh5OgKZAVjIlcTBQDHwJBHZaGL
gmDKR8ZOrKJOqi8SB7IeoBSkNCRp7JvtgUJdNOQ6MljfY8QaVF7CKHYlT8RxsDvdHttDS0cb
rwv7tig9UQfB1jj6yQVhkD8mKQpUW3wOPmt1supYpuABhRAzbHmWUwrrun1oo2eccVw1IOe2
3t7e97u6ul4jEXQCdtJnsFf4AcUFCBuANDzNvQOTIp2P8xk4b4N+fwC77Zb29vZnsFJLlB26
I+bQCY5sc4a2trafNTY2DrrShoB8HrKhrKysT0/iq+iDiRDKjbbLjdSsTku7qtkViHnMuMv7
SYy+IfSGBn+CbdPTr2mOZCRFBQenE1aLNm9FRZ3XLJbnteTkE1dCQl7Xysq2fBgW9qpG9aRm
JhTVkbS0v4zbNgWz+YbLbeyw2djOZOp9gfJ1oquLE5VjdTnxMSxw99vT80etuvrX2ooVK/Jc
6YD6HuWIg2VlFzT2QWHAhDdGSEnF7raTymT37oEh9VNRcVFbt67hGM/Za1l2TU8y2a/V+geX
bGMb9uPqeKiYOJbi4kNnufEco1Q0VmUjy2VCjDUjFvvG3RDhRO2EmROwSz2OMHQHyxHYtB11
lD/0mpaPKsUYyzKjEWcInaW3QhBQ8DA3MlQyRE9iv8K6oGUixbtYJkEmIA4aRsQzRzCvONsc
8eA9fCilNtuyD1VMJDkg6dhEi4o3WzEN80EcPzkhQUQKnjGbk4Hjo4hxZTJwomJyZVAAOS06
OlFffOh+pUoodylpqazUPXDuevWdD2IoYQGTpGDj+Q22YVv2wZIBFRpjKJc878GK+bYicroU
kzNwNSDe72W4ZZUYYw/CJPsC7ec1fW/Hse90Us4ZGp/aTpBcqlEvVxXFmjVrjiIHWPft2/dU
a2vrdRTL0pFwH9GVhpWf5eXlR9euXWuDEnoWpepD+G1bv3794Y0bNx7hvWzDtuyDfbFPlK6r
Kioqnq6srOxDvamturr6sOrvVikmZ1B20AdVVVXnkGv6ofjuxbhOYIwPwe6HMNm+ifM/ra2t
vYTJULJjx47HjC/NjIoQSrNq+/bt36mrq/sutgJW+OgFtO9xySh7TYdK5NR5pUpaWlrusZ+7
MXSe3/Pz9z5F9cPvFsuG015en2qJiY//PTPztObnd31Em8jIi1pmZvuRuLhTWnz8T9C+7iKv
FxX1/C419a1bqJicQRvqMzOz8Gx09DktO/vYJUc+8PH5GEl+769UG2Mf/v7vanwlYbdN01JS
BuGjnuv0QVpa02EvhJJxs8KaDpUIVY5SJZs2beqkouFvY+1HqR/1vb6+/zljG346btM64jmu
KqaJKEDnK+Tz4xnuA2fjUX3ceedr//9N21paLo9oMxTHuJHhbnkStZpSdyqFUCwgJPS4W4mG
uW1MWcySBmUolE4VSCnii6fxPkApGEXIdL+covphUud7edrEPQ9tZCF0Ou3ivk1P3A0qodPf
o95MxUPm+EZLfx/irUokjmpGw3buNUoxTbSWNFXgGz0onZ0GlbVFL2pO6x8VWEWnvKU05p7L
6Y6eL+CpDOrr6x+GhNtALUwlAIU0QCnKl1dGdTAK+zENDQ2v7Nmz58R0DlpXP/fjNehdrJNB
4VxD7asJKq5/uv8eRNuamprexruW/gMHDgxardbHHSpApZhiY89oKE8cx0v5J43qgC/0R6oF
Y3u7WrArjunDWArQ3WxzqABHUzL83t39I03tHIerBSPYRimM6Rz0WArQ3WxzSQHyXcjN2uXe
aribAnTV+HK9NJCitv+IdRWeOBZ3U4CT0fB5rC9RCehv6Lw9dYK5kwKcqF6OQdx9pLOz80V8
/hjK6w0qBE8lxF0U4CTUwGeKSdWlJvOfJHcaj0cOAHuOxXwlaTL14LA2BwT0PWwy5XrsCjGO
x0u+QpGPKQPrQUZCPDIhzjTof0gunSn7EY+HyVTXEhFx36An55AZhZmgsmbYCrE22xWK/BUi
H/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/IhH/Ih
H/IhH/IhH/IhH/IhH/IhH0b8DxOIBxLqM3+GAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleArrowedLineWithOffset [
| v e1 e2 e3 e4 line |
v := RTView new.
e1 := (RTEllipse new color: (Color blue alpha: 0.4); size: 20) element.
e2 := (RTEllipse new color: (Color red alpha: 0.4); size: 20) element.
e3 := (RTEllipse new color: (Color yellow alpha: 0.4); size: 20) element.
e4 := (RTEllipse new color: (Color green alpha: 0.4); size: 20) element.
e1 @ RTDraggable.
e2 @ RTDraggable.
e3 @ RTDraggable.
e4 @ RTDraggable.

v add: e1; add: e2; add: e3; add: e4.

line := RTArrow new color: Color red.
line withOffsetIfMultiple.
v add: (line  edgeFrom: e1 to: e2).
v add: (line  edgeFrom: e2 to: e1).
v add: (line  edgeFrom: e1 to: e2).

v add: (line  edgeFrom: e2 to: e2).

v add: (line  edgeFrom: e3 to: e4).

RTCircleLayout on: { e1 . e2 . e3 . e4 }.
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleArrowedLineWithOffsetIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAACLklEQVR4XuXXzUpbQQCGYS/K
S/FSxGuJWBFcWEGswUXBlSCCYrEmhILgLm6kiy6sujDw2Tnxpw0UIQZOTvK8w0BWWczDzJlZ
eHrya1IL/hL4IH4+iA/i54P4IH4+iA/i54P4IH4+iJ8P4oP4+SA+iJ8P4oP4+SA+iJ8P4ueD
+CB+PogP4ueD+CB+PogP4ueD+PkgPoifD+KD+PkgPoifD+KD+PkgfvMGcpObfC6jVcb3MnyQ
KbeXvSHG6/BBplw7bR+kaUfWdhn+kdWQ8viYLC7G/6g3BWRrKzk89EEagbGzM4TIw4MPMnWM
/f3475BpLX5+jix+Dg7Gxri/T6rpg0wE8SvJpzJbZX55Pp6Oj8de1E6n/EPreXa7zUZpOMi3
F4yX+bsz9mLm7OwN43X6IB8G+TEKktuxFjOnp0m/n83NvxjVbx9kIpRy3uRrmf0PYVS/B91e
jo4ynIOBD1I/4j8Y6fVS5d+yGoaRdjvZ2EhWV/0dUgvE7m7e2xm5vExOTvxrb20gKyvJ+Xm5
KZer8v8wLi6SuzsfpBaMq6tkefldDP8bUhdGeWe83WmXlsrTpbxdrq8zixjzAbK+PvLqm9Wd
MZ87ZG0ts4wxX9+Q6qiaofcG9TD0Qfx8EB/EzwfxQfx8ED8fxAfx80F8ED8fxAfx80F8ED8f
xM8H8UH8fBAfxM8H8UH8fBAfxM8H8fNBfBA/H8QH8fNBfBA/H8QH8fNB/HwQH8TPB/FB/Cbq
Dwek5Kyq+eWvAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleBezier [
| v shape  edge els |
v := RTView new.
shape := RTEllipse new size: 10; color: (Color purple alpha: 0.3).
els := (shape elementsOn: (1 to: 6)) @ RTDraggable.
v addAll: els .
RTHorizontalLineLayout on: v elements.

v elements first translateBy: -50 @ 50.
v elements third translateBy: -10 @ 20.
v elements fifth translateBy: 0 @ -60.
v elements last translateBy: 150 @ 100.

edge := (RTBezierLine new controllingElements: v elements) edgeFrom: els first to: els last.
v add: edge.

v open.
v canvas
]

{ #category : #sources }
RTRoassalExample >> exampleBezierAndCenterOfObjects [

| v es startingElement shape |
v := RTView new.

es := (RTEllipse new color: (Color blue alpha: 0.4); size: 15) elementsOn: (1 to: 20).
v addAll: es.
es @ RTDraggable.

"we are properly locating the nodes"
startingElement :=  (RTEllipse new color: (Color red alpha: 0.4); size: 20) element.
v add:  startingElement.
startingElement @ RTDraggable.

RTCircleLayout new initialRadius: 80; on: es.
es translateTo: 0 @ 0.

startingElement translateBy: -150 @ 0.

"Building the bezier lines"
shape := RTBezierLine new
				centerOfObjects: (1 to: 20) inView: v.
v addAll: (shape edgesFrom: startingElement toAll: es).		
v open.
v  canvas
]

{ #category : #icons }
RTRoassalExample >> exampleBezierAndCenterOfObjectsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAHNklEQVR4XuWaW0wUVxjHZ8Fd
FkFYuSwL7HK/LSCy7MIuBARBuewKrIhIQRABIZbAVrSUXikJiTXyYFGjSUs0prEPTfqg1b7Y
xMQHExISGjE8WO1LkyZ9aGKb9KXp5XwOkz0zDCug9sL/l53MnJkz58D3zfluMwI++OCDDz74
4IMPPvjggw8++OCDDz744IMPPvjggw8++OCDDz744IMPPvjggw8++OCDDz744IMPPvjggw8+
+Py30esFwW4X9/j8w8THC4LHIwiJif5zx44JwsCAuJcwm8V+1B+fVwgJXtr8CnG5pqblClHr
h89LICFBEHJy/O39+ysqTp8ThK4u3mS5XN0DcpPV3S0qyev1n6NxaDx8NkhsrP8pLyz0n4+M
jIuLkwnW5XJV8e2kpKQ06uc/Q/dLY9G4+GyAuDgSYGvr+SuCkJsbSAHKdllZWbV8rNxcr/fj
WVEhRiO+bDeM1SoIRUXR0dHGQAJXKqSgoKCYb5tMJjONIzd/+KwBh0N8iqtkAs7IyLBmZWXl
8ecsFkuamkIKCwudfL+dO3eWJCYmJsvnofFpHgqX8QkYRRmNo2+qRUfKVcIrgT9Wrh6j0Ri/
nnnwkWGzkZDy89sO2+32MuXVtra2Pum4oqKiVk0hvLnq7e19QzlGUVFRWV5e2+GVwQI+AUlN
Tc0i4fHnghjZ2dk7pLZOpwtZVlQv7XklshUVq6aMhIQEC750n0t6umjPdTrlFfIBkZGRUZyP
KOH9CCklNjbWRG2DwfCsX35+flFeXp6N76e24sT5aN60NHwdqGbg9fVqV0kJvIDr6+tbyNHT
8e7du91sp2G+o0ZaJbm5uYWcCXOoK4NoaMDP6FdRiMl0ciwzs7MnMzMzj4WpiSufZZ3O6XRW
0rHb7T5IvoIETf6DVhFbHdG0UqTVkpKSkrEyuhIxm80pZBKzsw/30rz4ClEtkfhD0G3btkWW
lpZWk2KYgmRJ4ZEjR4arqqoaTp06NVVcXFzR1NT0mlar1Umrgtp0PwldscpcpLTq6mpPaGjo
Vv8VmneTllRinv1eLlsYs7OzX7GI6cTly5e/pEhrcHBwLCQkRN/c3NzR3t7eT6uCwmJSlHQf
ux566NChPo1GE0T9oJ5vA/uxMKeXjDGr5nnXdzeVyOkpjY8n503C9vl8E319faMXL178YmZm
5vPr169/c+fOnaWjR4/66I6oqKhYOq6rq2uh0Lampmaf9NQnJydndHV1vR4REWFY7/ybRiHs
v7GTMqaczulrPt+N93y+aRLq87bJyckLc3OLT588efIX2/58/PjxH48ePfp9cXHxl4WFhZ/n
5+d/unv37ndXr179mvHtgwcPnt6/f/8Hao+NjZ1eyxzP367dcDqV5fv/e8WJ/bgXEAPhghC+
JhMXExPX2XnmEgnF57vw2dTU1KWHDx/+urS09Nu9e/e+n5ub+3F4ePj9s2fPXrl9+/bC+Pj4
mdraWi85a1ole/bsaerv7x9lYe4LlEDa28U/m/abCJat7agThDpWxTOv/271kjiLqnaNjIx8
cPPmzflbt24tDA0NvUNOmUJdZpaGyHd0dHQMMnMV5q9SVbmZKdvPal/51PdF5sdnJRrmkDtp
o8bx48fHJyYmZii68ng8beTEKaqia1R8zMnJKWhsbGxXhsvUt6WlpQtfnGv3QnZ6G0juejnP
aFUTIGXglI1TxMWEfJDqWZSH0EqhomJwcPAW6kdJI1/r4iEFer3eTrFF89G8VJrHR1oEGrLh
yclvvet2f3R+tV6UR0gJIxP2XkYzJYd6vX4rJYwsvNWwyGo7X3632Wwuh8NRvtqYTU3Tl2he
0YfQ34HPMtKXI2WqJY7u7u4hvl1SUrJrOdfQM6GXSiUS6Tpz9Cf5/pSPqM9L8ym/WMFnGa1W
eYZyCuULp4aGhlauaJhK+8rKymc1MIrAuKKk7K0hrSb1dyMr58VHhuhHqD4VFhYmC5/JBEnH
fPlDUojkQwhmykKZQtPlI0fFsCJlET8PPgFpaSET0tx87hN11++v2rLsvFE65l9Q8VGW8t26
BBv/U9FUkUPHJwCrf+DW2trao4yW1BTCmy2C8pT1zIOPDBMrndfVyT8VXf1JV1MIq/yu8Alk
/uRnaHyax2TCl/m6qKzU6z2NFktSmmJ1dKymEKXZItLTM6xardtD4+HLdOMVMiuZFIPBd0L5
uU55efneQAqR3h7y3mf7dt+oaKKsVnzZbojwcH9+IpXGTSaNxu4IDrYkBVJISEja8jt6ySTR
/VK+ERaGL9sXIijIf9zTY7dPnpE746wsl2uEvYbNzOSdts324Wnqrz4OPi+JAwdEZfCCHhgw
m998W64kuk5t6o/PK0T6bCciwn9u3z5R+LSXoOvUDz8L/5fAf5+BDz744IMPPvjggw8++OCD
Dz744IMPPvjggw8++OCDDz744IMPPvjggw8++OCDDz744IMPPvjggw8++Gxa/gaxvt0BZhXI
eQAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleBezierCurve [

"Moving each extremity will reposition the control points"		
| v e1 e2 l s p1 p2 | 
v := RTView new.

e1 := (RTEllipse new size: 15; color: (Color blue alpha: 0.4)) element.
e2 := (RTEllipse new size: 15; color: (Color blue alpha: 0.4)) element.

e1 @ RTDraggable.
e2 @ RTDraggable.

e2 translateBy: -150 @ 150.

p1 := RTBox element.
p2 := RTBox element.
p1 translateTo: (e2 position x + e1 position x / 2) @ e1 position y.
p2 translateTo: (e2 position x + e1 position x / 2) @ e2 position y.

"It is not necessary to add the control points to the view"
"v add: p1.
v add: p2."

s := RTBezierLine new.
s controllingElements: { p1 . p2 }.
l := s edgeFrom: e1 to: e2.

e1 trachelShape addCallback: 
	(TRTranslationCallback block: [ :shape :step | 
		p1 translateTo: (e2 position x + e1 position x / 2) @ e1 position y.
		p2 translateTo: (e2 position x + e1 position x / 2) @ e2 position y ]).
e2 trachelShape addCallback: 
	(TRTranslationCallback block: [ :shape :step | 
		p1 translateTo: (e2 position x + e1 position x / 2) @ e1 position y.
		p2 translateTo: (e2 position x + e1 position x / 2) @ e2 position y ]).


v add: e1.
v add: e2.

v add: l.
v open.
v canvas 
]

{ #category : #icons }
RTRoassalExample >> exampleBezierCurveIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAABu0lEQVR4XuXawYsSURzA8ddh
OwwxYwkxSx2dAQ1UHLPN2GQVD2rQJXLxJsF27P+/pezBU9ghl198PvAuwzt9H4/hvZnk8/l8
Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8/1BVpdQ0focQsiyl
h4fHcXvr93hCZVm+HQwGk+12+6Oqqt7j06ur04Lc3PiVnsB0Ol0sl8uvf56R5ynVtV/qwnq9
3nA8Hn/ySwQwGo2mh/HRLxFAnuetfr//3i8RxHq9/uZXCKJpmqlfIZDZbLbyKwRSFMVLv0IQ
i8Xii18hkLqu3/kVYr3Q/UNgJPv9/pdfIZDVauWfPyI5XCLO/QqBDIfDD36FQE7fOHwhZFn2
wq/g8/n+A51Op+tXCGS32/30KwRSluUbv0Igm83mu18hiFar9cqvEMhkMvnsVwji+YF/IAzi
2UG73X7tl7iYu7uU7u9Tur4+N/N4kdjtdgd+s4spitNPz/P5uUNgnuf+zwyXd9wdxwU5v0N8
Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/vr/wGmY0mlw5w
+SYAAAAASUVORK5CYII='
]

{ #category : #icons }
RTRoassalExample >> exampleBezierIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAACcUlEQVR4XuXb3W/SUBjH8YPI
qFHREayhikDBUkbLW+2kkAUUEl9ivDMh3K2JmYk323/hpX+yPUYTQzagCOzA93NJS6C/59Cn
57QIPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
OF2Uey+E+4mfhCKOheE8Fyfv+Unw8fHx8cXhOE7Xdd1XYRhedjqdwDTNWjqd1vjJ3GJB5l/z
ff+sVqu5/HR2LJvN5hZtb7fbr6NfTY+f1I5MJpPPy/aRpy/btpv8tHZA9oxV9221Wn6lUrH5
qW1J1COcuO/pdrtB1HM8fnprSIrUjVdKiUTizqnXG6/Zd55EV2X8osTxVJj9RWtT388vf/zv
2tVgMBjzk17RfXFcyIpn1zZiz/P6i7bHEQTBG37aS2QymceWZf3uD8VisTrfmDf9ec1m00+l
Ukf85Ofoum7IYvx7iZrP5wvheXhVrVbr2xzNsvCyt/Cr8IcsghypcXvJJpVKpZeRE3Qh5Ey6
Xq/f2As08SC3iV6xKsMwCsiZvaZp96JT0FtVe5gcKJhiRJOzftQv8krPgZLJu+tMPPdrohcd
5HA4/LBP37lcLlsHOeOWSxb7OuIOamHSELXxty9XP/f9OEaj0cfDaN47vkrapul0+pU/QVGM
vE3MT0Exs9nsgp8Cv6fwLdNoNDr8FBTDvyWsoOhWQeO6R5H4bhH/cSNFi+K5p+OHImfy01DE
mf0u5P9PRSFyZeKR0C1+Enx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8
fHx8fHx8fHx8fHx//QL7WkIkODawDAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleCellLayout [

	| view substrings |
	view := RTView new.
	substrings := (RTCellLayout >> #doExecute:) getSource substrings.
	view addAll: (RTLabel elementsOn: substrings).
	
	RTCellLayout on: view elements.
	view @ RTDraggableView.
	view open.
	view canvas
]

{ #category : #icons }
RTRoassalExample >> exampleCellLayoutIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAGcklEQVR4XuWbe28UZRTGX2KB
tuCNxRabBtKyLZsWWqQtFAo7XEqtVErFFipKQancjNQiWRNdWVQMmhglxhhJCImE/zQxUUNM
jH4Mv4Hfw3Pkee3byc5259JM6/NLTqe7M+/tvDvvucw7hh9++OGHH3744Ycffvjhhx9++OGH
H3744Ycffvjhhx9++OGHH3744Ycffvjhhx9++OGHH3744YcffpYduwO+f1PkYsC5rb7PJ0We
9n3XJ9Jdpuw+kdMi2Qh9/TTk9a+mpNOuMuObKqM3pV3/nBK5JzIrclmkIHJfZELkjMh+kR0i
dSIjON+PSutFJn2V6vnfUO9HIj+IDON6206TyGaRvSLjIkWR7SKDIldF1pTp7AcieZGf0Mav
IRXzTkoTksf46h3dlqA3OxbV9Ysi27RAm8iQyBaRHpFekSMizZCNIq+IjOLcLpHDzi++w9eB
AZHXUG8f7oIs7j7bTg2Unsc1ehzDndURMLCd6PQw6joVUjH9KU3IJozPQL+qWw/9sWNRPW8Q
2cO/SPPDz0JchZyAQXaXnri3aiU2LlK9SktC9SS9ZFm8gPGv8ntCBvbiJoyNiej9qJH6XOQ6
bMMt2BV7rgSj/DaMeq6KekdQnw7uPXxWQ/+Jc+4Y+j4j8rWv/DjKfQb78wd+hG7/1Bk5j7JP
JGzUrzn91PHfcfRxA3074BZUg3tIpBUGO+odoo1m4FVt9jkH9px+PgfDP1ZlvR7q24RyrnPg
OW3tgvFUI9noK38IzkkW7vYBX//yqNtfNqk7xPbTg+fq6kPbPM6/YPPDTxi2BHzvN/hJGOew
rECgahbZ2ajWKYhCC5Ynu3wFBlw7ccEs1tV9CO09BC4jCGRyMH7tiOA7oaQVTn318Np2JzyY
D0UOxijvYVx5Z7zbYCs9Z8wnYdjPJtTvbgTSPTDcHtooQa8juBFsH/6NHNXir4cnotHwF5iA
fqQ33kVlk0iHfAejbaCklU4HcpiUlQlPyCA8FC9i+ecxrrwz3lqRBuecjvcKxvs9zsfltKOr
K04bJfz/FTxa2wd++OEnFHUxy7tG/qllrIcGLG9+J2CD73Mrjmozn63gGDVX23AnKrNB4Qv4
XAODtyrCWq/lLmHt1LR6L44NMRQ0CQXtQPCnbTwHm+LB0WjDdTlkHtZFLN+N6zSifwxOi4cx
TKO+flxzEfaoExH5UTP/eZAdfwE6zTtt2nNDTqbkP0NjDfhRVHwTBjzsHVNEXX9jQjQt8SM6
1BVjQk5gMGr8/nSM4104JhqBP4QRVUW/HqP8A5ELmJBWRNNfwlu6BEX+As9vGnfGQaRARn13
gx3/bej0Fgx6yTlXRB9WG/vHweZw1idw29u6ahNeTlwPLuO0UYc7OhOzvP+JZyNyTk863631
JQXXVWivtoJOa4OSi/zww0+QES4kWN9hOAVqWGewbmsb78OQzUSsNw8bF4c0HuOedbIBapfW
wL4F2uZ7CU/IQ3gqP+N4DW1YwzUVsd7HY0ymTWE8SGFCJmDoNdX0MSZl1FRhcJJi7QJt1JCt
QH0YfzlngR9++EmdAgxYN5YnDZqGYU/acU0OwdU4ArEOGOx63NYtSLtMJpjW0ZTO5RT0oc7I
cUTyBtmAEvrShExABwLQ3sWaEN0soHn+Y/Ao7M5FTVmMmbm0t32GfA5Ha/SLKO86ADqQOzH7
ltaEFPF/CR6o3bl4Gz9Mu2Hw/mJ0wN252IOUQhau7yx+EXZzgk7Mdaeze5GusJsNBhN2W/tM
9OcpUXE3OazGj8JDKkfTOFvN3CaHDP8Cyw8/YdDU+3kT7fUANwB72eD5cML4n0Vk/69e0QSO
uhNwCEZoP74bD1mfelXfiryRcD/PwM54Zu61CO2n3ZRQcLy2oJROGu+IdCNbUTWDMKT2IdWQ
mXuIsseE3z3ShmNzwgNTt/AGnAZ1FrrQT7tbcQB9rbTNZyilH33orVK1y+RujrNfqonfIvGz
JBhArOE3vuXeMbQxQabC+psU2ZSWrPxScBI0Uv/GPNr49TsidU2d/2Xmv0Zgd75rWuEtBEpT
KD9t5qfb474eUFqs1MQCFJfCHWIjdftqQxaGuNxrBM+YR1s6G3HddidS7/HV/RIUGwUvhSh9
SUwIP/O5wK8Cfvjhhx9++OGHH3744Ycffvjhhx9++OGHH3744Ycffvjhhx9++OGHH3744Ycf
fvjhhx9++OGHn5j8A9TB373eT7gUAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleCellLayoutWithCircle [
	| view els |
	view := RTView new.
	els := RTEllipse new size: #yourself; elementsOn: ((1 to: 20) collect: [ :v | 50 atRandom ]).
	view addAll: els.
	
	RTCellLayout new lineItemsCount: 5; on: view elements.
	view @ RTDraggableView.
	view open.
	view canvas
]

{ #category : #icons }
RTRoassalExample >> exampleCellLayoutWithCircleIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAE50lEQVR4XuXbbUgcRxgHcFOM
xoq2Ul/S6BnPpipoowbfuaRJQ0BBBV9Qg1grWvAtSgWN2qKiGLGo1BNLiAVrlIpB0PZDUQ98
g6JWEak5fEnUL8mHUigUGpJ8SJt5IAvLsLO3K1e19//BwLH73I47z93NzM7ohA8fPnz48OHD
hw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OGTq66ubh4YGPip
ra3t25SUlGxRnMFgCG5paTH39PTcj4+Pv6p2zd7e3h+UjsfFxV3p7u6+r/Vva29vvwuTiNjY
WNPBwcG/fJmYmFjmY728vN7j40wm0w29Camqqmqi9+J/DRQoJUMqZrN5lP8W8TEWi8WK34p2
UlpaelstIfynWCkhU1NTv+G3pB37DT0J8fDweIc/n5SUdB2/JY8pIcTf3z9Q6tSpc8ZvRTti
jXteLRnLy8tP8FvpiFVWVn6plIzd3d2XoaGhH+G30DHIz88vHR4etlAi9vf3X9XX13cGBweH
4rcMPnz4Tlb/8RX1IXre4+Pjc5ZGWVJf09zcbKZjSrHp6ek37VFvf3//g83Nzb8cPiGnGWdn
59N63jM/P/+YHwDQsf+yXpiE6JWXl/e5aIicm5tbgt9CJ2giSefwW+iIVVRUNIoSUl5e3oDf
QkfM1dX1DJun/MMng465uLi44rfQMWCLUh/PzMxYpWTQazqG3zLHLCgo6ENWLuC3BD4MNTU1
rVtbW8/oZ2hlZeVpYWHhLVEsWxfx7OjouCf9bLG1+B8jIiIu8XExMTEmmj9QH5OcnJypdK2G
hoav6fkZXWdxcXE/LS0tT1Svr6/v+11dXd9L9bLnbzPR0dEJDpUIPz+/c3t7e6+URk7T09Ob
fDxbA7ksGmllZ2d/Jo/lz1Nd0rmQkJBw0XVGR0fn+HoTExOvieIbGxu7HCYhGxsbf6qtiQwN
DU2pNTJfDAaDURRbUlJSI53b2dl5oXYd+sZKsW5ubm/bqpcl7JP/fTLYz0iWrRulcoqh+OLi
4i9sxba2tvaLGp09MXGh45mZmZ9qqVe6Tl1dXYet2IWFhT2HnnnLS05OTrHWeKvV+rf8k93U
1PQN628G5H2M1nql+LW1td/1xDt8QoqKiqq1xs/Ozu7Yq14pfnV1FSMhBQUFFVpulHabUHxk
ZGScrVgtj9UzMjIK9DRwbW3tHVux7InzI4fo1G3dKBtpPZTHj4+P/yKKpT5Da734nboAbeUR
3STNHzw9Pd/l3zM2NrbAxy4tLT1xd3f30Fqv0WgM0TPsTUhIuCqKp07foeYigYGBH0xOTv4q
v8m+vr6xtxiV+Ys/9QVUwsPDow9bNzWmNA+am5vbTU1NzRXF0spkZ2fnd9LfODg4+LPDTQzx
4cOnRs+mhaioqPj19fU/qNBrW9fOysoq3N7efk6FJoPyc9IzqZGREQttT1W7Dv3LBExC9Gxa
kM8ftCzZioax9AhFfpweTuJ/NZz0b1qghSjpvJZFKVFC+IkhPeXFz4bT4TYteHt7+1HRcn0a
vioNZcPCwi7K68JfcXzjKDYtlJWV1VPhjwcEBBgp6bRmgp+JN/A3LZxA+JsWTij8TQv48OHD
hw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDh+9QXgOox3JY
RZSQNAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleCircleCould [

| v |
"The GlobalBuilder allow you to normalize the size or the colors across a number of elements. Consider the example:"
v := RTView new.
v addAll: ((RTEllipse new color: (Color red alpha: 0.3)) elementsOn: Collection withAllSubclasses) @ RTPopup.
RTGlobalBuilder new
elementsToConsider: v elements;
normalizeSize: #numberOfLinesOfCode min: 10 max: 60;
normalizeColor: #numberOfMethods using: { Color gray . Color red };
execute.
RTRectanglePackLayout on: v elements.

"elements provided to #elementsToConsider: are resized and have a colors chosen between these elements."
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleCircleCouldIcon [
	^ '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
AABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleCircleLayoutAndEdges [

	| v els |
	v := RTView new.
	els := RTBox new size: 10; elementsOn: (1 to: 100).
	v addAll: els.
	els @ RTDraggable.
	RTEdge buildEdgesFromObjects: (1 to: 100) from: [ :value | value // 2 ] to: #yourself using: (RTLine new color: (Color blue alpha: 0.4); withVerticallAttachPoint; yourself) inView: v.
	RTCircleLayout new initialRadius: 260; on: v elements.
	v @ RTDraggableView.
	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleCircleLayoutAndEdgesIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleClusterLayout [

| v |
	v := RTView new.
	v addAll: ((RTEllipse new color: Color purple; size: 10) elementsOn: Collection withAllSubclasses) @ RTDraggable.
	RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself inView: v.
	RTClusterLayout on: v elements edges: v edges.
	v edges do: [ :e | e trachelShape pushBack ].
	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleClusterLayoutIcon [
	^ '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
UUkAAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleCoolAnimation [
| v shape elements |
v := RTView new.
shape := RTEllipse new color: (Color purple alpha: 0.1); size: #yourself.
elements := shape elementsOn: (1 to: 100 by: 10).
v addAll: elements.

v canvas addMenu: 'Right!' callback: [  elements do: [ :e | RTLinearMove new to: e model @ 0 during: 1 on: e in: v ] ].

v canvas addMenu: 'Left!' callback: [  elements do: [ :e | RTLinearMove new to: e model negated @ 0 during: 1 on: e in: v ] ].

v canvas addMenu: 'Up!' callback: [  elements do: [ :e | RTLinearMove new to: 0 @ e model negated during: 1 on: e in: v ] ].

v canvas addMenu: 'Down!' callback: [  elements do: [ :e | RTLinearMove new to: 0 @ e model during: 1 on: e in: v ] ].

v open.
v  canvas
]

{ #category : #icons }
RTRoassalExample >> exampleCoolAnimationIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAEgklEQVR4XuXZ/U+bZRQG4Ht8
0xbKN6UUOqAtpR9QCi1tocJa2CYbQzLYYEFUMDObY3O4GZeoqOhi4rKZaOIW/1nPHV6SSch+
alFzX8kJtG8LyTk9z/Oep9CnT5++/5c1izsWaefxpvNzxuLuO9735xmvKbz1fpy6xv+z8Y6/
N6xfimP3LI6cRD52fvK5hxY7Z7y+ZJG0eHDGa5YtDpy/kTt1bdd5b9Ziz/kQ7FusW8xbdOuX
4tikRdEiYfGtxX2nW6YtFk+99tAi5Lyeif3CSSbe6ipee2EROXVt3rnO52edx4yo0x1J/VLo
06dPnz59+vTp06dPnz59+vTp06dPnz59+vTp06dPnz59+vTp06dPnz59+vTp06dPnz59+vTp
06dPn77/tAs1dWhwWbhrUNugn49/ST0aPc1o6XGhzd+CrqFWdI940D7ggrevHk2tNahr1M/S
Oai1RDej1deKnlA7/IlODEz2YCjXg+F8F4JT9jjFa260BawwLfoZq24xmtgRbeiLdeNi1odw
sR9jiwNIXBtE8noAsct+REu9GCmwMC3ovNgId4d+5qqA+wOXI3YFE87kBzFxYxjTt0KY2Q4j
tzOCzOYQ0jetOMt9iMyzezzoCDbC1a6fwQprgqeLnWHL00wA8atDmNoII78zhvc+i2PhQRyX
9vn7KAq7VpitQYyvOEVJsausoPX6Waxgd7jRHuAnnkuUFWN9FLO7MSx8Po7LT1J4/9kklr+Z
wJWvEig9iqJ4l93CwnFv8cIX1V+6KqgBzV4vesNcqmw5uhZC9k4M8/dZgDSuH2bwwc9ZrP0y
hRtHLE4S5cdWsD1bvtatgOXjLvH26WeyQuyuqrcDgXE/RkvcI0Yxt5fE4oEV47sM1p7ncfu3
AjZ/z2H9xTRWj1goLl/cX9hRTkH8HFr0s1kB/HQzqUwuk8xkM+lMfh63XhWx/aaID/8qWGGs
W35K4erX1kH3rJO2BhC/0o3gNGcU/X2kigWxveOpLVE/sCtmsfXHHLZfszj/7JDM7X7Elrow
mOZccgE1tfrZrMgdlrvT7rDGfAgV7VZ3NYL8R3GUHnK/YAFmcPPXHDZeWnc8T2PlkMU6Y8nS
30Mqpc6OSex4ZNiGwQznj5MuSWLpwJanZ1NY+d665ceTOy1u+GGbTYJIrfLWtwP9SU73+pms
wrJlG/sCu2TE7rSOZ5BL++NY+pJdkUD5EZ+LoPAJ5xR2B5crj03sPHzUz2IF8VyKU7ezl5RP
pnQOh1HMfcrZwwrx8cm0zmLYEJnlMKnfHVWc1nmyy6JwKeKGzYmc8wY7gp1j51rLLAaXNztm
ibOz9O+uqlwU65RBm0smeLprw+Is5xM7VCzzsNEm8xwLZoNkxCmG/nck57DJu5ls2xuCTDw3
bRaoDb4x+14kxGt2VNKpPwiee2EaXPV2rMIvqrhP8LyKX1xZHfQLoU+fPn369OnTp0+fPn36
9OnTp0+fPn369OnTp0+fPn369OnTp0+fPn369OnTp0+fPn369OnTp0+fPn369OnTp0+fPn36
JPwNXt+qEqTBc4UAAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleDependenciesWithCurve [
| v classesRoassal classesTrachel shape1 shape2 helpBar1 helpBar2 |
v := RTView new.
v @ RTDraggableView.

shape1 := RTEllipse new size: #numberOfMethods; color: (Color gray alpha: 0.3).
shape2 := RTEllipse new size: #numberOfMethods; color: (Color pink alpha: 0.3).
classesRoassal := shape1 elementsOn: (RTObject withAllSubclasses).
classesTrachel := shape2 elementsOn: (TRObject withAllSubclasses).

classesRoassal@ RTPopup.

classesTrachel @ RTPopup.

v addAll: classesRoassal.
v addAll: classesTrachel.

RTEdge 
	buildEdgesFromObjects: RTObject withAllSubclasses 
	from: #yourself 
	toAll: [ :c | c dependentClasses copyWithoutAll: RTObject withAllSubclasses ] 
	using: (RTDirectedLine new color: (Color blue alpha: 0.5)) inView: v.

RTHorizontalLineLayout new gapSize: 1;on: classesRoassal, classesTrachel.

helpBar1 := TRLabelShape new text: 'Dependencies between Roassal and Trachel'.
helpBar2 := TRLabelShape new text: 'down links = Roassal depends on Trachel'.
v canvas addFixedShape: helpBar1.
v canvas addFixedShape: helpBar2.
TRConstraint stick: helpBar1 above: helpBar2.
TRConstraint stickAtTheBottomOfTheWindow: helpBar2.

v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleDependenciesWithCurveIcon [
	^ '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
/wLZleMnuj1bsAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleDotIndex [

| v values resolutionVertical groups maxValue g c el |

values := #(15 8 2 5 11).

resolutionVertical := 10.
v := RTView new.

maxValue := values max.
groups := RTGroup new.

values do: [ :aValue |
	g := RTGroup new.
	resolutionVertical to: 1 by: -1 do: [ :y | 
		c := (aValue / maxValue >= (y / resolutionVertical)) ifTrue: [ Color orange ] ifFalse: [ Color gray ].
		el := (RTEllipse new size: 20; color: c) element.
		g add: el.
		v add: el
	].
	RTVerticalLineLayout on: g.
	g last  @ (RTLabelled new 
					below; 
					text: aValue;
					color: Color orange).
	groups add: g. 
].

RTHorizontalLineLayout on: groups.
groups do: [ :aGroup | v addAll: aGroup ].

v canvas color: Color black.
v open.
]

{ #category : #icons }
RTRoassalExample >> exampleDotIndexIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABfCAYAAAAeX2I6AAAFhklEQVR4XuWc72tbVRzGT+PA
V75ouw37M03bORlO2k4YNMlSakU0QbQV6WrapqkDrSBtHFLaLi0TZvtO9sM5fKGI/gH6xjfT
wf4S3eZ7QcQ382T3ST33nHtybpNmob+ewcNyn5tlcJ6c7/dzzz25wvtT4teBEv8g8AfCL/5A
+APhF38g/IHwiz8Q/kD4xR8IfyD84g+EX/yB8AfCL/5A+APhF0Egl5JCfpAQ0vZjsZgcGhqq
8Lu7u2UikZCRSCRwrrW1VaZSqVC/paVF8gdSRb8VhCzdESXo5491KBjwjY2NEjQ7O+v7fX19
vj83N+cPfjQa9f2VlZWAj2N1Dsf8gewgFYaS8tfW1vxBhML8eDxeHuCRkZFSLT6O+QPZQX98
oWfI79f0DMlms/7ALy4uOn2os7OzfG5wcLAmf2BggH+G7KTUC6L0aFPIB14wr0R1IO3t7RIl
qVAoyJ6eHv/9TU1Ncnp6Wq6urkqUL/OzxsfH5fr6erm/mH4mk5HFYlHiPH8P4Rd/IPyBPIV+
nNc95Pb7umQNDw/7td8sNUBhk7JMtDUpy/RNyjqA6MtPWfyB7KD/vtYzBK+Vj8atBhGN2uVD
XV1d5XO48KvFxzF/IPyUxd/U+Zs6v45GIFvjuofMx3XJQplC+UHdHxsbc/rmGhdoamlpyenn
crly/0D546esOikLg+eiLNvH0oiLpsJ8fsqqk7K8b7WTskwf8maMk6bCfH7K2gVl4bVZmlyU
1dbW5lMWLh5dlDU6Olrh81MWv/gD4Q+kAQJZqR5ilyxFU+Zt3I6ODqn8qampQAlyURZ0r7D9
+Q82BX/Jqpey1ODalGX71ShrPRP8fBzzB8IfyNEtWaAs5U9OTvKXLH7xB8IfyF5fGP65JeTD
zdouDEFZMzMzEjeqkslkoARNTEw4LwxxV/KxtwqAv/kDqSJpLJ1IY+kkn887l05MH8ItXdcS
ifKLGf35EI75A9nHxUV+ytqlrr2tv8G5Yffyu1mCwpbfm5ubncvvvceFNCkrdpx/hvCLPxD+
QBpOWXh9/7KQj7aCPj9l7RNl3V10+wjDbN74rYiLspTPT1kNoqx/bwYHst6NcvyUtUt9P6cH
/uZF/e399DXtf5cTVbeSgrJcW0lBWX9f15/FT1n84g+EP5AGUZa5lRSvXZSFraSKsuytpIqy
7K2kd7L8lMVPWfyUxU9ZDdGvS3rgf1rQ397PXtc+3uNTU29vgLJQwlw/i1b+hVNBysIxfyBV
hIcG5OOVAzV62v1AAfz2AzPAfkAA9u26HhzQf0LItTeF7D/J30P4dRgpC3UdsilL+TZloV9A
6iaUkno/LipNH8fqHH8gVQSsVfX9obEr5JdP3H7YgwMuJYIQcD4mnP58nL+H1EVZ5q5401c3
p+zd7DZNXUkLfsp6WsoyaerqW27f/Ln08vJygKbMgY80CafPT1l7SFmgKcyMZyKCn7L4dUQC
6TsRTkDF9PY5vCdAZl7fAGXZz75Cw8b77bKkSO4ANvTDQ1k/5N0+fgVlNnXcB3HRlAqRn7L4
KetwB6L2TEF47Zohpp9OpwOUpWYIypJrhti+eZHJHwh/D+GnLH7K2oMZonx7JvDPkH3oId9M
a/+fG0KG9Qr+HtJgynp8201Zto8rcBdNhfn8lNXgGfLVlPb/+pJ/hjRcp58P7yGfewuMkKuH
bL4jZK095NUXt/2PUvw9pKquT24P0rezQh6zFgVf7ghuDVKKtgi58kalnz0v5IcXKn38H93e
v7l1kT+QqlrwvrXPHhPyrDf4NgW95Hknn6scRAz6mbZKP9kv5LtDlf7C/zPjvXP8gfCLPxD+
QPjFHwh/IPziD4Q/EH7xB8Iv/kD4A+EXfyD8gfCLPxD+QPjFHwh/IPziD4RcTwAORhKa195Q
OgAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleDynamicBezierEdges [

	| v es |
	v := RTView new.
	es := ((RTEllipse new size: 30) + RTLabel) elementsOn: (1 to: 20).
	v addAll: es.
	RTCircleLayout new initialRadius: 150; on: es.

	es @ (RTShowEdge new 
				connectTo: [ :value | value - 5 to: value + 5]; 
				shape: [ :el | RTBezierLine new 
									centerOfObjects: (el model - 5 to: el model + 5) inView: v; 
									color: (Color blue alpha: 0.4) ] ).

	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleDynamicBezierEdgesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABfCAYAAAAeX2I6AAAMuElEQVR4XuVcCVBVyRX9CXwd
F3BFUT+LoI6igqIoIIgs7liKuKKgggsiqCDgihgJ7vsa44qKiHtpHNeIu5bEuIyIG2qcqkxN
ZZmqLJNMotO552HD4/se8I3w37dP1av3ea//p7tvd997z73dOvEhPsSH+BAf4kN8iA/xIT7E
h/gQH+JDfIgP8SE+xIf4EB/iw/zQ6/UBM2bMSI+MjEy3t7dfIH6PVDH8/Px629nZ2Su9q1ev
Xs+uXbuyV69esZiYGLZ+/XqWnJx8Xu23unfv3rNFixaO4vfqR6BVq1YB1Lnv0Nlr165lixcv
/p21tbVeXmbHjh2naHZIAunZsyfbuHEju3DhAuvQoYOnvJytrW3/nJyc/54/f55t3ryZhYaG
vhG/h02AwWBwTk9P/wmdff/+fYx6Rh3KsDTJyz148OB7LhDcHz9+LN0nTJgwQ14Oz/B9lCsq
KmIbNmxg06dPXyh+T1cS6HjeyefO3WC3bt1iU6dORafmyculpKQs4QKJj4+HIFhubu4PdevW
teVlvL29e+E9F8jcuXPZnTt32JIlS7aJ39OVxKBBg0Zxgezb95XUgejI5cuX7zQum5WVdRZl
cT19+vTfpCcC5O+bN2/uKBfI/v37uWBWiN/TMtSsWbMfdfS36BwXF5e1PyPI3588eTIfnVhQ
8JrxJScsLGys0m/5+PgEYpmysbGpp/T+ypUrRdeuXZMEAT2Ce1BQ0EB5Gfr3gadOnbp7+PBh
5urqmkPWm70wwvDy8orv1KmT1DHXr19H59BM2PeBdZSZmfmroqJXjDr0hfHINxUrVqzY+fLl
y58uXrxYaPxbHh4ek3h9Vq1axY2Em8IIhITwWr72x8bGSp+pY7opzaWqrs+ePXvO8PosWLCA
kd5htBSyYcOGjRdCIFjreQdERyexbt26SUvSgAEDhil5G1VdH1rGCnh9zpw5U2K1kSExRwiB
xMXFzeVK9t69P7Ds7Gx248YNFd/AvsrX8hEjRsTw+uDet29f3P/5c4IwyxY5aIfRAZcufcNI
4b7y9PT0VS7ZsmV11Gfp0qW/5tba3bt3//T/6ixNo3bt2nXLL1HWwioLNzcttMGKQJbhFxYt
CBplX2HEjR07lo0bN46RYKKUS7Zurf4rnTubuRnWZHF9h3aMHj0a1tdbomb8LU4Y8JB79+4t
LQFkxUjKkiiQt8RRtfuwdIsW6r/Uvr0520GDKZe3A4r+xIkTLCQkJM/iBJKRkbFl5cqVUkPy
89+wOXPmwNP+gI8qRl1a0urUUf4lFxdztgP1Dw8Pl9qxcOFCyUxPSkpijRo1amJRAklLS1vL
BRIcHMaOH7/OZs6cySZNmpSs/A21WdK8uTnbUVBQ8A8ukO3bt7Nly5bBUWVqrIBm0bZtW/fT
p09LDTl69CgRf0ns4MGDN0g3WqupfuXnDRqYsx2BgYEDt23bViKQ3bt3s61btx61SKUOjolG
1A6YtZgxBkNAsHppg0H5+Rdmt2wmT56cTL7Sb2mA/R5LrjHvZsEADWJtrf7ewcE0k1h8fALY
2amPeoE842ryOwZTqHXTxIkTN5OuGKteslEj5eeurhbS1JDg4OBFmzZtyq1fv366Jmtob2+f
yAm6MWPGMMQV/Pz8RpnmX+j1Zdndpk012FRfovJZamoqS0xMZO8d3+80V8t79+79hZu5uChm
zV68eMHK/5bSTJFTJU5OWmsnDy+jfREREVJbhw4dCiYiQVMVRcUgEASUfHxGsJs3b0uVLf9b
NWrodDY2HzqJ2hVIQkJCelRUlNQ2HschK0zF4TUjdu3a9RsI5NGjR8xgMLDu3f2IMsn7a8Xf
bNKkfKtMWyBGPr1Lly406HzYsWPHGOlLcnqPs44dO3bVVEVRIdDWfMmicOk7BwcHl2LHrjyu
ythL52Zu9dDuH4PVq1dn8XbiIp2yS5MVRYYHpi6uhg0bNi771tZWna+C8rayKjWLi80ELZtZ
iG6inaQ/oizYMMboR+cr8VPOzsV3kIn16onvRFS7YDBj5AodHjxfutT8FPFRaTg5ObmSgpvl
6OhognOH2SJX6vDgLWt2hIWFRarli5kNFEVbkJKSIim427dvM/Je75smFABRww4ddLrGjS2E
lQigoNsjsL/IwM/Kynrk7Ozc2vxuq69vMDx07qVv2bIFwRuG55X/lS5ddLovvyxexiwDhw4d
usrbTX8ia4bhmWY8V1Ts669fs6tXv2HOzv3Ii121DcZw8cgHtY6lCR0OZ9AYw4frdD16WNJS
JTd7uUAqdoSrWSC8gm3atKnAc4VSh64An4WZERhoaTpTswJBsAapoTzRDBcxvqzyQZwJEyzR
iKFw9C94ezEYHz58yIYPH66NtpATaLdmzZp9RJv8je578Xflvjl+vEYZ3co6h8MvX778Apdy
GqzFALoEMwNeuaOjJQvlM0CnTjrdwIHFwSiYuNAjuMQP1VYzoMQTE4stKlhfPj7YYwtCW6eL
jKQgXEgxfaI9htdiQXGBrVByyGYnonFT6Zv4eJ1u716dbupU+LbKyQzgtzBTPD11umbNis3l
hg3Lxke0AaLgA0hnPIIyJ+a3yM3NrbPmhBEeHr5w/vz5jGf6IZfJ339nDsSk002aVMriKsHd
vfQz+Cx47LiD8a1VqzhnC8IxP5AKS176jwUFBQgxIF+ZPXny5F8kJCtNCYQsrL8jQIUNmt7e
B1lu7h9ZTs7dStjlxpQ8p+G5kDgND8FASLib3+8iy0oyd5FIjr/B42nOUYJACgsLqaIzpc2V
GEXlfwveuzF3pdeXOo/16/NxWfY9f24egURGRkrC4M7ge19EWyFc4rCO8NRRLF3IzMjNzb2i
/g3Q7UodK+98edxE/hxmsnl4LwrfBmFjKLWt5HrPTnTQlEBat27tduDAgUt8xOzdu/d8+Rni
SjEPWFjyGIk88x0cmDz/F0ubeRR+aGjoyKdPn/74/mSId7RsTdWspQUvveJUfbU9H8b5vcaZ
jMaJ1xCgeZQ9qCFS8G6fgXFcXpZJZVJJHY1O8xHfyzcJBoOhJUg3Clo1LB7Ner16aaXNOcYe
vNK2BccqP3IJmfz9+/cPt2hhWFlZ5cMa8ff3Z8uW7WBRUSkZ5Vn4ys+NzVy1mEqVRRoDkIOF
djg4OLCzZ8+aGHzTCEJCQlJ5jATZjDY2DtJnLy8vf1O10ofPlJxMCKnJJ99mlpSUdBP1JueP
kUOII0AYjoWyOIGsW7cuOzo6WtqEP2rUZNa4ceMK7HW1GaKUZKemN2C5fVqSkluNMOkhEBy9
gb+dnJxaWZRAqOMXYaqj8tjwiY2S+BwRETHFNB2gJCjoITU/5NM6jd7e3t/u3LlTokn8/Pyk
Y6I0ERn8GDx79uwtDnGBx/7+rKqLyiXL20co57kqqzM+nT7BEosD1HDOFoSCdiQkJKRZpECI
Be2EJYpG1UrcbW1tVTq+vLRRDw/l52CE1QBD4NM5jbTshtEMX5yamrrU+PjAzwakU7yQSd6t
W590YofHqZds0+bjfBrTqBWc84hBQ5YUthtME8o3adasmR8UJNL5AwMjpJMeiJjco1xaKXZS
mXcVzbxStGzZss3z58//ExcXx5o2bSotSzg6UBiB7N69+0L79u0l297VtRc7d+6c1AmOjo4u
pumDimgTUCsVe/JI0MAuKGTOeHh4lDC4RCT6CiGQtLS0d/PmzSs5VIDvSBoyZMiYD0urbWHg
qOikh4p1CdHpL4hNYFQvRDpZZmYm35aXJoRARo4cuQcn62CGYIMoRiZOmatVq1adsu6fnf2M
GUmLkdBc3upf8X90d+d7V3DiqfHb5OTkTD4rcLod/wy9IoRA9Hp9DZoZN2W7rX7C6UHyMn36
9LkHgU2blsSIgoHw8pQ7SO1IjjIKOys6OlEaAIsWLZLO/yWLr4y/gmfybMSgoKBQnWig2RGL
UVunTh2bsrZTk2a8YzIzNzOKs6h6+R07dvTx9R17OyMj48+zZ89epvR/2rVrRzNxFn1/fom+
Uvqt4ODgQXju6uraVic+ynj5Utz65MmTbPDgiJJRi1llJIweWGJu3Xoj7YtHlBKBMXmZgICA
fvzoV1wgOvPz83Ec7B7xe7qSwL49dJ6zszOTLyM4g0tejljXqzCfp0yJY+7u7iUzCVS5XA81
aNBAyr1FYkKvXr2kMrNmzfql+D1tArKzsy/KhYGLBBAkLxMfH/+9POueZoN0N/amsW8Dsy0v
L6+krOmss/jQxcTEJB05cuQ6Trj29PT0MX4fGxs7h5S/dKpCjx49JGutsLDwB6XfwtG0iPlj
CzP5QJ7i924VoaLD+MWH+BAf4kN8iA/xIT7Eh/gQH+JDfIgP8SE+xIf4EB/iQ3yIj+rH/wDc
OQlQqimsUAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleDynamicEdges [
	| v es |
	v := RTView new.
	es := ((RTEllipse new size: 40) + RTLabel) elementsOn: (1 to: 20).
	v addAll: es.
	RTCircleLayout new initialRadius: 150; on: es.

	es @ (RTShowEdge new connectTo: [ :value | value - 5 to: value + 5]; shape: (RTLine new color: (Color blue alpha: 0.4))).

	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleDynamicEdgesIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleEdgeTransparency [

| v es |
v := RTView new.

es := RTEllipse new elementsOn: RTShape withAllSubclasses.
v addAll: es.
RTWeightedCircleLayout new initialRadius: 200; on: es.
RTMetricNormalizer new
	elements: es;
	normalizeSize: #numberOfMethods min: 10 max: 35 using: #sqrt;
	normalizeColor: #numberOfLinesOfCode.

RTEdge 
	buildEdgesFromObjects: RTShape withAllSubclasses 
	from: #yourself 
	toAll: #dependentClasses 
	using: (RTLine new color: (Color blue))
	inView: v.

es @ RTPopup @ RTSetEdgeAlpha.	
 
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleEdgeTransparencyIcon [
	^ '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
LG82MO+SAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleEdgedWorm [
| v es |
v := RTView new.

es := RTBox elementsOn: (1 to: 50).
v addAll: es.
es @ RTDraggable.

RTEdge buildEdgesFromObjects: (1 to: 50) from: #yourself toAll:  [:value | {value -1  . value + 1 . value + 2} ] inView: v.

RTForceBasedLayout on: es.
v addAnimation: (RTSpringLayoutStepping new view: v).

v @ RTDraggableView.

v open.
v canvas

]

{ #category : #icons }
RTRoassalExample >> exampleEdgedWormIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAGQElEQVR4XuWbWUxdVRSGC4IM
Zaot02We53meKZd5pszzJJfKKEgFrQNlSJX2gUghWoIyBBJb0xhrYhojD9TgCw8kPEmIJL75
YuKj8UH337DNCaktXIFT/b/kZu97zmEfstbZa+/1r3PP8cMPP/zwww8//PDDDz/88MMPP/zw
ww8//PDDDz/88MMPP/zwww8//PDDDz/88MMPP/zwww8//PDDDz9nyfnz5y2mpqY+DQwMDOe3
hgrcuHFj5sGDBz9otdpCeWx2dvZeREREPPpDQ0MT+/v7fwYFBUXwW+sU6Orqeis3N7c8OTk5
y9jY+OX29vYBzIrMzMwi5XU2Njav1NXVdaLf09PzDlpxTXFWVlYx/+w5IVJTU7NHR0dnhFFL
5LHo6OgkhbPebmlp6RPX5ZiYmJgaCjBT8F1eU1NT07G+vv5jWlpaLr9Fj4mlpaU1nuqEhIQM
9OUMQdvU1NSNtq2trV86xsnJyQ3h6fBMETPkellZWaMMWzqd7hpaMe5lfsccg+bm5t7l5eVH
mBnymLOzs7vs371798uVlZVvMRueNc7MzMzn8fHx6RYWFlaHz0knviTgt/g/gDAjQ5G7u7sv
2itXrjRmZ2eXIfxERkYmYN3QZ+yUlJRsLy8v/4qKilbMGsy8zs7ON2NjY1P4nXII4YTkra2t
X552LikpSSvC0+twxknca3x8fC44ODgK/by8vHI4eGRk5MP+/v73+T1xMCvw6e3tfbe8vLzF
0dHRpaCgoEr0m8XTm3qa93Zzc/NCW1hYWHXz5s15fmcIR2g0Ghf0+/r63pPHBwcHx+GQ076/
gQAhEhsAmb/QggUVsRxbVLl1DQ0NjQkPD489q/9B7Nh67ty5c09+x3pCP0syMjIKscAuLi5+
c9ZZNe6LsIidGPIULPz8i8gBai2qWK9kH8knnMPvDRXx9PT0OwhXqbdu3fosLi4ujd8qKiJE
yEmpAmD7zW8RlSktLa2HMoC+SEBL+S2iBzExMSmJiYkZJxWupDrg6+sbxG/dIyz2kNNtbW0d
8D0/P78SYUYswB8JgTAP8geecn9//9C9vb0/kFg+b0xzc3MLyPdYxOX14h5X+SWUZ4BFFuLh
6urqd8qFFk8xZBSR0xnCCcrQgxYy/OEkD6EIeY8414utLRLCgYGBMQ8Pjyd6WWVlZdv9+/e/
F7pZE7/lFQhB0RuFpICAgDBRhDIW331QjMI5GBJ5A5JJZaaP+K+se8BZQhLxRk4jdLBM5DlC
u4p0cXHxRHErKirqSXiSfyMS0biT0sn+d+zu7v5eXV39qpWVlY3yqccTXVxcXDs9Pb2KzFpo
T9XYEQkje+CYyPCjGxoaXhNPequYQcGYDSK0VWCsg3Ea5D2g+GLGIURJkZGfp4eov2ULzA6I
jQg/RUVFNfqO6erq6vXw4cMtFLUQnuAIOHNhYeFrfnX3OVRVVbWjHR4e/gAxH8bjT9JUQtQj
phDLEeexjvBbRGVQi6itrdU1NjZ2iUW4gN8iLwYGMu/gj+8vAKLW3YIWuYByG8uPSuAlNiF9
X1bmE/xWURFsR6XIB1CnQM7AbxmVwFuJkDOUDqqvr7+KrPuoY1y8eNHWyMjIGJsDOHdnZ+c3
jGFnZ6fht7Ce4JWfw8dycnLKwsLCYk1NTc3kMSR60LXgOI1G44o85vHjx/tIJiGP4BzKsspx
BgcHxzY3N3/mt/IxaW1tffKa6KVLl+xl+FpaWnqkVHKFynttbGxsVvl3cBgyfmtr6wsH22cD
uY2WL2vzF6H0RKvVFk1OTn5SUlJSJ4/pdLohtJgtISEh0ehDdExPT8/DzBIzI1E5htDELkxM
THy8tra2LsKWozwPWYbfwsfE3t5eg1qHg4ODk5+fXwje30KLopIsKGEGYZuM14c2NjZ+eto4
WFPw8fb2DoDMbmZmZg4FuLu7+zq/lf8FqI2gOLW9vf2rj49PEJRcQ0PDIxeU5ubmvkDb0dHx
BhRhfoecEPpU9fDmPLJ/6UD+nyKoDHZpaOXrqvwqsopgAyD7KHTJn7nxoxLz8/NfocXPDrBj
u3379iK/VVRElnH54Ycffvjhhx9++OGHH3744Ycffvjhhx9++OGHH3744Ycffvjhhx9++OGH
H3744Ycffvjhhx9++PmP8heS8r9YwwsVmwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleEdgesInTooltip [
| v shapeBuilder elementClasses edges background label |
v := RTView new.

"We use the bounded shape builder to:
  - have no element smaller than 5 x 5 "

shapeBuilder := RTBoundedShapeBuilder new.
shapeBuilder 
	rectangle;
	width: [ :c | c numberOfVariables * 7 ]; height: #numberOfMethods.
elementClasses := shapeBuilder elementsOn: RTObject withAllSubclasses.

"For each class, we add a popup that will show the method invocations and the class name"
"The popup uses #group: to specify what is the group of elements to use
#group: takes as argument a two-arg block. The first argument is a RTGroup, to which elements have to be added.
the second argument, aClassElement, is the class element on which the popup is being triggered."
elementClasses @ (RTPopup new group: 
[ :group :aClassElement |
	methods := aClassElement model methods.

	methodElements := (RTBox new color: Color red) elementsOn: methods.

	"We do not want to directly add the edges to the view. We instead need to add the edges to the group"
	edges := RTEdge 
		buildEdgesFromObjects: methods 
		from: #yourself 
		toAll: #dependentMethods
		using: (RTLine new color: Color white)
		scope: methodElements.

	RTTreeLayout on: methodElements edges: edges.
	
	
	background := (RTBox new color: (Color blue alpha: 0.4)) element. 
	RTNest new centerOn: background elements: methodElements.

	label := (RTLabel new text: aClassElement model name asString) element.
	TRConstraint move: label above: background.
	
	group add: label.
	group add: background.	
	group addAll: edges.
	group addAll: methodElements.

]).
v addAll: elementClasses.
RTFlowLayout on: elementClasses.
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleEdgesInTooltipIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAADnklEQVR4XuWdTYvDIBBA+///
ZG+9FnpooYfdJQtCGBydGTXRvAEhJEbTvETny/T2+xuT5/P5X9L2/X6vlkj7qXw+H/O53+/3
ZyvyOvf7LXXOkFv0xO0GpZv0er1+Ho9HtZzxA/c3u6XO9EBWET4QPhA+ED4QPhA+ED4QPhA+
ED4QPhA+kFWh8YHwgfCB8IHwgfCB8IHwhQ8ECcQSoEpS2u8Jclna07b3/XgDa72Db0OAbEGp
rViAlKCmIFcPIJpswbF0rbL/ywCRcFojhCOBtPS5JJBemg4fCB8IHwgfyCJAttSb9/tdLFLD
azXoLH1aC98O4dshNs0qp2W17i+VpM6WrkerI/dH+tf6OsUwtI6r3qHHM3ZbjDytTtq/2ULR
/rW+pgbilVFA5JyhpYwuCSQ9VaVyJBDLkDWi/2mAjJQjbwAfyAJAlpzUrwxkSbV3pHgMsjPX
cmCA8A3DoGG4N6xyxldtTN4ft4zfuTrR83oYpSMWJ3WJGMrlYTVnoDy+/wEWuyb3wyNOSW+d
I5yNXd4QzWC0ArFO6FFFAAHEYjBGgJylLFwWiOfpXV3l5gPhA+EDuSSQ3s5Hvh3Cl/mByKCO
/ASGdly+HblzrMXSdqkfrV5ue3ogyd6QY68MGGljc+5GebNAam1r/ViBnPE5kG5viDcsWoLs
BVIKBWPnkJo7fCQQ/hxS0KS0zyhZNCw+kMm0LD6QyYBEtSw+EL7MB8ST7ZdTIy3ZhbW25fFc
G5bMRm825FJ2SC2DUaufS3iz+sJKbUSWr1mX6i0PZC9askJrgAsLJKVlRoHMrMEtCWQ1iQBZ
ag4hAOGrvQPFs1pqyQ8p82VSO8SyGilnT3iOW84r2Q5eW8na3lRApJsjORWl9iW3ZdqNpqlp
2pvWbk5tbsnLKmla/CGrcfJuUc1z/jU+kEYH5R7W7I5K/qR+lUldm0O8T2g0waF3koPnuqb2
ZXkmwegq2miSg4yvWxMwlpzUI29I6Ye3vCGtN+wSQCIyyiputRM8a9t7fteEP6kf/KDwgfBd
J+WwpzUU6nV11NwuPcPIo9cUHqpl9fhqaTQkbDlHA9Ki8V0CiNeytk7MLf+huORnYnNP1159
rSVR9xQ8kFb/Um+Llw9kMuED4QPhA+ED4QPhA+ED4QPhA5kdSOSL13wgA4Es6VzkA+ED4QPh
A+ED4QPhA+ED4QPhA+ED4QPhA+ED4QPhA+ED4QPhA+ED4QPhA+ED4QNZRP4AizmlcvoLni4A
AAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleFontSize [

	| v label els |
	v := RTView new.
	label := RTLabel new height: #yourself.
	els := label elementsOn: (1 to: 30).
	v addAll: els.
	RTFlowLayout on: els.
	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleFontSizeIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAEV0lEQVR4XuWaW4hWVRTHj7dQ
EVMfBm26SOiTUVEGEenkaF4yKhqbsuxm9WBFqTmllPNpOalY0AWMoAgKUYusl8gsK0vFy4NC
EVQPJRHUUw899CLo2sx/42q5z0BoM339fvBnr2/vffZ8317n7L3WPlPx4cOHDx8+fPjw4cOH
Dx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHD59/SKuzJzn7
whp7frj+cme/5exO0xz3+TxTi6knXH+L6TLTeFd3t8qNYYzUd5xprWmRq59s6pK9I4x/g2mE
qcN03//RgcP6aLvK2VeYrg3tF5vuqnHo+MJ4C02jQ11yyBjngEzDdKvp0cI4I01PmNbzn78z
I01yW6gbIafOKvSt+nBIt+lF/pTy4cOHz1nhWZUpilkW2p42DTFdYrpREUrlNt/3ZS82PR6u
Te1bZN+vawe59hWKltLesNw02zTRtV+pSG652/Rvd+0P6do8RtpL1oTvsNo0z3Sd69P4rzvk
GpVvmq4PbaNMQ2U/FtpS/fOyXzJtC+0XmPa4jTZFRXe69jRBw03PuIlshPYc8ua2FSHySvxm
WuC+h2eeyoOme2S/2ywOeU45Q51DnqyJfnI5Rf09H6pcpidxasgllhbG8Twc8gzvkBaNmx23
Sk+N51xFVW3OiU0V8raEz+eYBsueUOiff+hK0wOF9jtULig4e78LZ1/Q8nJpWC7XBSd5h3xk
ulpKT2e7bM92Z+cnmJ+D/Iu5SVa3s0t9HpHjV7mnkg8fPnz4nDmd1elnRXEtHhnW6LaaNbtd
dYtcblM6h2oN1/v9IPbtUv00fe7Q5/bCb0nBxVz3uUM5UlORI5GfVabk6YfQ5xWFtHOUS9Qd
zn2pcqfKT1V2FyKssUo273XRUk9wSDol3qB85SfVfaYE82gYc48clfKpGaablN80NEZTkb78
q1XvsfjNCilL7DZdZDqmH3qo0CdN1hFl3p8rF1ldM16XnFLJQesKT2bO7v9Q+bX+9lehb04U
J6p9n2s70UzO2Oni/xTn7zL9Xp16OVQpoftExygxrPTvRdJRxzuy57pkclchYTsQlp1tfdws
6YkarZsh3yxfFPreZjrslqvXlHf81UwOSZP/jZT5IPTZG9b4vTV36T7F+UvdpLVq8j3fF77H
x4W6mWEPSMvpU7J7wg2yu/r7W8Upzv6RHyr0Mrhm842b+KDCZh6Dh4ZzxHemJaFvuqFel9Iy
mA4iX9aSOZ3vCj58+PDhQyBFJn9Wp95dJN4z/VKd/u87fPqBnPFOd9FMfq9wnD89A0Onsur0
n4MHXf0O/tQMDOnN4IOmTaZvXf1W/tT0P3nvON/0ho4a8pL1K396+p90Evu2aXPVezA3VI7Z
WpM98+HDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8f
Pnz48OHDhw8fPnwGhpNYGq32Nn6+JQAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleFonts [

| v fontNames |
v := RTView new.
fontNames := FontChooser new fontListStrings  allButFirst.

shape := RTLabel new fontName: #yourself; text: #yourself.

es := shape elementsOn: fontNames.
es @ RTPopup.

v addAll: es.
RTVerticalLineLayout on: v elements.
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleFontsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFsklEQVR4XuWd10tcWxTG8+cp
iK8++aJ5EMQHiYqgYu8FC9bYe8PeYuwVjb037L2GYC/Lm29xz2DuvZiY6IzX74PhzOxzjg/n
58xae5W9393f8+s16R3/I+AHwi9+IPxA+MUPhB8IvxiAdHd3C453d3d6XFlZkePjYzHOT05O
Cj8QM2p5eVlCQ0MlPz9fBgcHJTo6Wo++vr56vq2tTQAtLi5OXFxcxN7eXviBvKCioqLk6OhI
Ojo6ZHh4WBYWFqS9vf2+rKxMH3xeXp5pvKurSxISEviB8IsfCD8QfvEDURUUFMj4+LjaiYmJ
CUlKSpLc3Fy1I1BYWJie7+3tlZKSEjX+GJ+ZmVG70traKjk5OQLnYGhoSPiB/KG8vb2lsbFR
H3hiYqIa7pqaGnF2djYZdVyD8ZCQENP4wMCA9Pf3C4BhvLS0VCoqKviBPJf+j//d/DaEHwi/
6IDU19f/8FOFUAmMuPEZE0YjrGIYc34gLxw68fHxka9fv6ph//Lli8zOzppCJ83NzWrUcZ4f
iBmF+BVkfL6+vtb35+fnPwQf+X+y+MUPhB8Iv/iBGPLy8pLIyEgNwWNyeHl5qUZ9aWlJFhcX
1W58N/D6vqGhQXZ3d/UIG4OZOj+QZxYe7snJiWRlZcmnT58EIZGmpiYNg3z+/FkfeGdnp7S0
tMi3b99M4ZG+vj5B8oofyDML2UDMRRCLQqBxa2tLPn78KHBv8S35+xuiXlZGRoYYbi/AIQbG
D4Rf/ED4gfCLFwiKGWCgn3IPPC04AQ/H1tfX//U30tLStIKFH8gTVFxcrJ4VHl5KSoo+vNPT
Uy0NwjiyiDD8KA8y7jGMeWFhoSanwsPDpaqqSjw9PSU+Pt50nY2NjSa2Pnz4IAcHB+omz83N
CT+QR/Q9VaslQPC08MAw37i6upLp6Wmdk+zt7cnZ2Zm6xsY9mK/ghfvgDuM97kWk+OLiwnQd
3GUcp6am9Aiv7fb2lh8Iv/iB8APh1xsB8qvFDY9dBzvED+SZhGwhDG1qaqp6RPCqYmNj1atC
FTy8L+M6GHl/f3+NcRUVFal3hXPwyFDz6+HhIREREeoQ8AP5TeEB4j88MDBQsrOzpbq6WuDO
Im2L1oSAgAAxrnNychJra2sNMCK16+bmpufS09P1iPGgoCAZHR3lB8IvfiD8QPhFDOTw8FA2
NzeFH4iZhaSTo6OjFk2jbc3V1VWDjX5+fvJfAUN+IC+smJgYdXfxjUA8CmlZBBWTk5O1NYEf
CL/4gfAD4Rc/kMeMOmboCJEgn1FZWSlIUL1//15zHU/NJvIDeQajjqwf+gURu0KoBEcrKytN
Wo2MjPAD4Rc/EH4g/OIH8ktCG/T8/Lx2U/EDsYBQYQKjjhwG8h8ImaDGF61u/EAsoLfaqsZv
Q/iB8IsfCD+QlxdKR1FxYtTxomHHaGV7uIAAPxAzaX9/35QPQf0uynuMcwyuL/9PFj8QfvED
4Qfy+9rY2JC1tTVtqEGVCcLtWN+kp6dH+9X5gZhZSE6Vl5drDgSvsbExTVAhYfXWk1P8P1n8
QPjFD4QfyPPpnyF3/lJSCwity1jLBN22tbW1WkpqnOMvJbWA0Fdu7IQAdxetzigpRdiEv5SU
X/xA+IHwix/IY8LOBrAb2PWgrq5O1zXB7B3hFBQ8BAcH81cumlPwpBAmwa4HDg4OWoGCpfww
Zmdnp23Q/ED4xQ+EHwi/+IH8TJipP/yMFR6wZCw/EDMKy75mZmbqvlMw6La2trKzs6NjRlkp
PxAL6ObmRowdER7q4Qpx/ED4xQ+EH8grEYoc+IG8AmHZ1tXVVfWmsB4vDDk6c/mBWEjIgWBX
BJQDYTlYuLrYvZMfCL/4gfCLHwg/kJ8JWx1BRkkpVh7FOJpB0abAD8TMwpKv2CXa3d1dS0qN
XQ+2t7d1gX1+IBYWOqj4f7L4xQ+EX/xA+IHwix8IPxB+/Zn+AgL8eSPvs1F6AAAAAElFTkSu
QmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleForceBasedLayout [

	| v classes edges | 
	v := RTView new.
	classes := (RTEllipse new color: (Color purple alpha: 0.3); size: 10) elementsOn: Collection withAllSubclasses.
	(classes elementFromModel: Collection) trachelShape color: Color red.
	classes @ RTDraggable.
	v addAll: classes.

	edges := RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself using: (RTLine new color: (Color purple alpha: 0.2)) inView: v.

	edges do: [ :e | e trachelShape pushBack ].

	RTForceBasedLayout on: v elements edges: v edges.
	"v addAnimation: (RTSpringLayoutStepping new view: v)."
	v @ RTDraggableView.
	v open.

	v canvas
]

{ #category : #sources }
RTRoassalExample >> exampleForceBasedLayoutAnimated [

	| v classes edges | 
	v := RTView new.
	classes := (RTEllipse new color: (Color purple alpha: 0.3); size: 10) elementsOn: Collection withAllSubclasses.
	(classes elementFromModel: Collection) trachelShape color: Color red.
	classes @ RTDraggable.
	v addAll: classes.

	edges := RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself using: (RTLine new color: (Color purple alpha: 0.2)) inView: v.

	edges do: [ :e | e trachelShape pushBack ].

	"RTForceBasedLayout on: v elements edges: v edges."
	v addAnimation: (RTSpringLayoutStepping new view: v).
	v @ RTDraggableView.
	v open.

	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleForceBasedLayoutAnimatedIcon [
	^ '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
/s2/+bch7X+UezlxUQktfwAAAABJRU5ErkJggg=='
]

{ #category : #icons }
RTRoassalExample >> exampleForceBasedLayoutIcon [
	^ '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
/s2/+bch7X+UezlxUQktfwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleGrayScaling [
| v es n |
	v := RTView new.
	n := RTGrayLinearColor new 
				command: #asInteger; 
				scope: ($a to: $z).
				
	es := RTBox new
				size: 40;
				color: n;
				elementsOn: ($a to: $z).
				
	v addAll: es.
	es @ RTPopup.
	RTGridLayout on: es.

	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleGrayScalingIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABfCAYAAAAeX2I6AAACt0lEQVR4XuWYP0ibQRiHu2Rx
yRIIggQkEBKFEBDxD8YDIWQRUQhkCYEsLi7SkAZcbnJ2dnbP0KE4Z3Z2d+hQ7NDF+e39oLrd
a1uQKM8DzxDeIwf3fN9w3yc+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+
fPjw4cOHz38SXyEk2u12uLi4iDk1393dDZPJJHpqv/Pz8+ipNWdnZ9Fzc3MzbGxshNPT05hT
8w8ZxF5BUXToT09PllNzHfjj46N5ar+Hhwfz1Jr7+3vzVBQd+t3dneXUnB+EH4QfhB+EH4Qf
hB+EH4QfhB+Efw95n4xGo+jZarVCs9kMg8Eg5tR8fX099Pv96Kn9Tk5OoqfWHB4eRs9arRaq
1Wrodrsxp+YfMsh8PjdPRdGh397eWk7NdeCz2cw8td/NzY15as319bV5KooO/erqynJqzg/C
D8IPwg/CD8IPwg/CD8IPwg/Cv4e8Tw4ODqLn6upqqFQquq3HnJqvrKyE7e3t6Kn90g06empN
Chw9y+VyKJVKoV6vx5yaf8ggl5eX5qkoOvT0icRyaq4DT58+zFP7pc8a5qk16a0zT0XRoac3
ynJqzg/CD8IPwg/CD8IPwg/CD8IPwg/CD8KHz1+QPjOYZ/oEoZu43hLLqfny8rJu2uap/RqN
hnlqTfo/8ywWi3FpaUm3ccupOT8IPwg/CD8IPwg/CD/IGwfZ29uz4+PjF7e2tvhBFhlEEabT
6YudTocfZNFBjo6O+EHeCzs7O5/39/d/DYfDH+Px+Hv6/ZV/Kn9IT5J5FgoFPWnSHOO/BlGI
Z/lBFhxkbW3tS6/X+/ls+v2NX2KBQfjwg/CD8OEH4QfhB+EH4cOHDx8+fPjw4cOHDx8+fPjw
4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPi8Nb8Bjy8MaRHyChQAAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleGroupOfGroups [

| objects groups edgesBlock1 edgesBlock2 colorNormalizer groupsOfElements v predicate layoutClass filteredObjects shape elements edges |
objects := Collection withAllSubclasses.
groups := { 
[ :c | c name endsWith: 'List' ] -> RTGridLayout new .
[ :c | '*Set*' match: c name ] ->  RTForceBasedLayout new .
[ :c | '*Dictionary*' match: c name ] ->  RTTreeLayout new .
[ :c | c name endsWith: 'Array' ] ->  (RTWeightedCircleLayout new initialRadius: 60)
}.
edgesBlock1 := [ :c | c dependentClasses ].
edgesBlock2 := [ :c | Array with: c superclass ].


colorNormalizer := RTMultiLinearColorForIdentity new numberOfColors: groups size.
groupsOfElements := RTGroup new.
v := RTView new.
groups doWithIndex: [ :assoc :index |
	predicate := assoc key.
	layoutClass := assoc value.
	filteredObjects := objects select: predicate.
	shape := RTEllipse new size: 20; color: (colorNormalizer rtValue: index).
	elements := shape elementsOn: filteredObjects.
	elements @ RTPopup.
	elements when: TRMouseClick do: [ :evt | evt element model inspect ].
	v add: elements.
	groupsOfElements add: elements.
	edges := RTEdge 
		buildEdgesFromObjects: filteredObjects from: #yourself toAll: edgesBlock1 using: (RTLine new color: Color red) scope: elements.
	v addAll: edges.	

	layoutClass  on: elements edges: edges.

	v addAll: (RTEdge 
		buildEdgesFromObjects: filteredObjects from: #yourself toAll: edgesBlock2 using: (RTLine new color: Color green) scope: elements).		
].

RTFlowLayout on: groupsOfElements.
v  open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleGroupOfGroupsIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleGroupedLayout [

	| view group1 group2 host1 host2 edgesGroup1 edgesGroup2 |
	view := RTView new.
	group1 := (RTBox new color: (Color blue alpha: 0.3); size: 30) elementsOn: (1 to: 10).
	group2 := (RTBox new color: (Color blue alpha: 0.3); size: 30) elementsOn: (1 to: 10).
	
	host1 := (RTBox new color: (Color green alpha: 0.3)) element.
	host2 := (RTBox new color: (Color green alpha: 0.3)) element.
	
	view addAll: group1; addAll: group2; add: host1; add: host2.
	
	edgesGroup1 := RTEdge 
		buildEdgesFromObjects: (1 to: 10) 
		from: [ :v | v //2 ] to: #yourself inView: view scope: group1.
	edgesGroup2 := RTEdge 
		buildEdgesFromObjects: (1 to: 10) 
		from: [ :v | v //2 ] to: #yourself inView: view scope: group2.

	
	RTTreeLayout on: group1 edges: edgesGroup1.
	RTTreeLayout on: group2 edges: edgesGroup2.
	
	RTNest new on: host1 nest: group1.
	RTNest new on: host2 nest: group2.
	
	RTHorizontalLineLayout on: (Array with: host1 with: host2).
	
	host1 @ RTDraggable.
	host2 @ RTDraggable.
	
	view canvas addMenu: 'In' callback: [ RTZoomInMove on: view ].
	view canvas addMenu: 'Out' callback: [ RTZoomOutMove on: view ].

	view @ RTDraggableView.
	
	view open.
	view canvas
]

{ #category : #icons }
RTRoassalExample >> exampleGroupedLayoutIcon [
	^ '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
DO2Li2xss+0AAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleHappyNewYear [
| view txt x y el shape size offset |
	txt := 
	'
	xxxxx  xxxxx     xxx      x
	x   x  x   x    x  x     x
	   x   x   x   x   x    x x 
	  x    x   x       x    xxxxx
	 x     x   x       x      x
	xxxxx  xxxxx       x      x
	'.
	view := RTView new.
	x := 0.
	y := 0.
	size := 20.
	offset := 100 @ 100.
	txt linesDo: [ :line |
		y := y + 1.
		line do: [ :c |
			x := x + 1.
			c = $x ifTrue: [ 
				shape := (RTEllipse new size: size; color: (Color purple alpha: 0.2)).
				el := shape element.
				el translateTo: (800 atRandom @ 450 atRandom).
				view add: el.
				view addAnimation: (RTLinearMove new to: ((x * size) @ (y * size) + offset) during: 0.5 on: el).
			]
		].
	   x := 0.
	].
	view openInWindowSized: 800 @ 450
]

{ #category : #icons }
RTRoassalExample >> exampleHappyNewYearIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAACGElEQVR4XuXZW08CQQyG4aII
iMhBMCYeY/TCCy9M/P//TTDZRMZDt9uuXfZ9Ei4G2H5dDNMhCh8fHx8fHx8fHx8fHx8fHx8f
Hx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fX2cMjo5lOK6/jq7nzcu+
38B+TmQ828j9++4xl8tnba2Vttbz5lll52v9yEquX6sndg9trQVY63nzrLLztX5kLpunr09o
ay3AWs+bZ5Wdr/Ujg+3+NZXlzbmsH0cyWfy0PpPV3UKuXnZrdTcs3l+nvifPukfn5Nfvx77H
Bb8/+vrs/luv750hbed1rf/W63tnSNt5Xeu/pfrN9zjvHhyzh+f136yfP373ZM+AQ7/eWk/N
y54Bh369tZ6alz0DDv16a71fXnecizs2Q7L7r1dv//Pee30kp4vqr7PcPultwFsvup/s/LKe
tpa13L5FfkW99aL7yc4v62lrmcnFQ2QD3nrR/WTnl/W09edF1Z47lNE04qaqPbFpPe/12f2X
ys+3XLd6v/wZ0rE8/gzpWB5/hoTkxf6P+fueaKvftxliyjOfk4PP3d683s0Q8zk5+Nztzevd
DGl0Tg48d3vzejlDtHOy9XeKtZ43L9p/52ffLx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8f
Hx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fX+EDGUbckNrlS/AAAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleHighlightingNeighbourg [

		
	| v es |
	v := RTView new.
	es := ((RTBox new size: 30)" + RTLabel") elementsOn: (1 to: 16).

	es @ (RTHighlightable highlight: [ :vv | { vv - 1 . vv . vv + 1 . vv - 4 . vv + 4 } ]).

	RTGridLayout on: es.
	v addAll: es.
	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleHighlightingNeighbourgIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAABGklEQVR4XuXXwQnEIBBA0SnL
YzpKCZZjGZZiKdkGJgqGLLu8B3MSPOSDTMLn8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P
5/P5fD6fz+fz+Xw+n8/n8/l8Pp/vV5znWbN5chZRaz6+pTHGlc2Ts4jrysfnB/GD+EH8IH4Q
P4i/ZflBnnx0P8jXn6z5s+Q/WX4QP4gfxA/iB/GD+FuWr/d8IlprPZvV2exO39L98+L/qftB
fH4QP4jPD/JXjiOfiFLKkc3qbHanb2F3td1fiX2v/KnvP2c+P4gfxA/iB/GD+EFesbva7q/E
Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/NxPvWi+6f+
K4KdAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleLabelledEncapsulating [
| classes allClassElements v es enclosing label g1 back |
classes := RTShape withAllSubclasses.
allClassElements := OrderedCollection new.

v := RTView new.

classes do: [ :cls | 
	es := RTBox elementsOn: cls methods.
	es @ RTPopup.
	
	back := (RTBox new color: Color blue) element.
	RTNest new 
		layout: RTGridLayout new;
		on: back nest: es.

	enclosing := (RTBox new color: Color transparent) element.
	label := (RTLabel new text: #name) elementOn: cls.
	g1 := RTGroup withAll: { label . back }.
	RTNest new 
		layout: RTVerticalLineLayout new alignCenter;
		on: enclosing nest: g1.

	enclosing @ RTDraggable.

	v add: enclosing.
	v add: back.
	v addAll: es.
	v add: label.
	
	allClassElements add: enclosing.
].
RTFlowLayout on: allClassElements.
v open .
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleLabelledEncapsulatingIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleLabels [

| v es |
v := RTView new.
v @ RTDraggableView.
es := (RTEllipse new size: #numberOfMethods) elementsOn: RTObject withAllSubclasses.
v addAll: es.

es @ RTPopup @ RTLabelled @ RTDraggable.
RTFlowLayout new maxWidth: 900; gapSize: 50; on: es.

v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleLabelsIcon [
	^ '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
RK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleLinkingObjects [
| associations v labels |

associations := { 
	'bonjour' -> 'hello'.
	'homme' -> 'man' .
	'femme' -> 'women' .
	'hello' -> 'goodbye' .
	'people' -> 'homme' .
	'people' -> 'women'
 }.

"We create the nodes"
v := RTView new.
v @ RTDraggableView.
labels := Set new.
associations do: [ :assoc |
	labels add: assoc key; add: assoc value ].
labels do: [ :aLabel |
	| n |
	n := v elementFromModel: aLabel.
	n ifNil: [ n := (RTBox new + RTLabel) elementOn: aLabel. n @ RTDraggable ].
	v add: n.
].

"We add the links"
RTEdge buildEdgesFromObjects: associations from: #key to: #value using: (RTLine new color: (Color blue alpha: 0.4)) inView: v.
	

"We do a layout"
RTForceBasedLayout new 
	charge: -500;
	on: v elements.
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleLinkingObjectsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEl0lEQVR4XuWb2y9jURSH/XFe
PXrAQ0UmPHjoqJgIIxWRIC4JIploXBqXMm0xTFJSSpEIEYJoRlQMKlqXMGlaNdhrztqmTVXH
PPWcw+9LVtJzeOn52HuttdfJIsJHT2ThPwJ8IfjgC8EXgg++EHwh+OALwReCD74QfCH44AvB
B18IvhB88IXgC8EHXwi+EHzwheALwQdfCD74QvCF4IMvBF8IPvhC8IXggy/kf9ze3tL19XXa
wBeiAaFQiJaWlmhlZYUODw+fBb4QDfB4PAkBbreXcnI+UFNTE3V3d+ML0QKfz5cQsr6+TmNj
Y/T164oSy/hCtCASiYiLi4u0cXwsZOAL0RE2m03ZX45lpO4xyXF1dSXwhaiAwWAgq9VKnZ2d
tLZ2RA0NA2SxWGhkZISam5uprq6OBgYGyOVyibu7O4EvJMMYjUYpYHFxkerr62lnZ4eqq7/I
+xy1tbXU399PhYWFQsnW8IVkmviSlLz5c8zOBp5dK+kz/pKlBvf39+JfEQr9Tnx+eHjAF6I1
igNFij6zMDghsVhMcJycxEQk8vQ5XeALUXlv4djcPHqRBsf3HHwhKtHa2koFBQXkdDqVDX5W
ybZsNDg4SOXl5bIvxtmYw+HAF6IWNTU1VFJSQo2NjTQ/P0/Dw8NUXPyZ6xGZInOPjO/hC1GJ
oaGhF8uU0/ldWap+6qJjjH9A9Zfzc31kXfhCktjb014KvpAUzs60lYIvRCEYDIp4bG+HRPJ1
coTDYYEvROXahMPl8tPy8rLMupLvq3Fejy9EgWuSlpYWys3NlW157gYXFZllCsyd4o6ODpku
syB8ISrAx7+jo6NSQG9vrzzcslq/0dbWFo2Pj9P+/r4sIvkaX4gKpBsl8vl+idR7PHqEL0RD
lB6jwM+ydMTBAb4Q+EIRX0gSj4+PIhqNJiIcjj67jkcmz0uy1N4s9TyPyw96ZmbmWe3h9Z68
qFMCgcDbFMLpZOqXSddt1cs8LgupqKiQ5yF8PpKdnU15eSXye5hMJlmTcOo7MTHxNoVUVVXJ
cRvO8bm44oKrtPQjVVZWykKM56Kmpqb4C+pGCIvg85D4qBAPdCf/YXFdYrfb36YQHkrjU7i5
uTmanp6WD99o7KTJyUn5M47V1VVd/Ye8NuX45pesy8tLkRoWi02ku4+fUmiYZfEYDv6j15EQ
nw9fiK6EKMcK+EK0FnJzcyPiM09ud0C+7cShx1cCYIS0tbXJiXO73ZGYQueU2Ov14gvRQggP
ofFM1FOe30D5+Sb5TmB7ezu+EC2EpMvpPZ4T/CVL6009FZ70UHp2+FJIR93eSESIYBBfiuZC
uNObuoTFP/O7gKlL3Huv6jUXwu+Yc8ubm3accfX19dHCwg8yGD5RWVmZ7LzyfW5AcqcYX0iG
4UYjT56bzWb5qgBnYD09PVIQC+Hm5O7uLnV1dcnfOT09xReSSVgG1yavdVc3NjbI7/fjL1n4
4AvBF4L/CPCF4IMvBF8IPvhC8IXggy8EXwg++ELwheCDLwQffCH4QvDBF4IvBB98IfhC8MEX
gi8EH3wh+OALwReCD74QfCH44At5z/wBWVep7TxiFq0AAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleMakingVisualizationFit [

	| view |
	view := RTView new.	
	view addAll: (RTBox elementsOn: Collection withAllSubclasses) @ RTDraggable.
	RTEdge 
		buildEdgesFromObjects: Collection 
		withAllSubclasses from: #superclass to: #yourself inView: view.
	RTTreeLayout on: view elements edges: view edges.
	view @ RTDraggableView.
	view edges do: [ :e | e trachelShape pushBack ].
	
	(RTGroup withAll: view elements) translateTo: 0 @ 0.
	view open.

	"Removing this line will make the visualization larger than the window"
	view canvas camera focusOnCenterScaled: 500.

]

{ #category : #icons }
RTRoassalExample >> exampleMakingVisualizationFitIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleMetricNormalizer [
| v es |
v := RTView new.

es := RTEllipse elementsOn: RTObject withAllSubclasses.
es @ RTPopup.
v addAll: es.

RTMetricNormalizer new
	elements: es;
	normalizeColor: #numberOfLinesOfCode;
	alphaColor: 0.4;
	normalizeSize: #numberOfMethods min: 5 max: 15;
	normalizeX: #numberOfMethods min: 0 max: 300;
	normalizeY: #numberOfVariables min: 0 max: 300.
v open.
v canvas
]

{ #category : #sources }
RTRoassalExample >> exampleMetricNormalizer2 [

| v es |
v := RTView new.

es := RTEllipse new color: Color blue; elementsOn: (Collection withAllSubclasses).
es @ RTPopup.
v addAll: es.
RTMetricNormalizer new
	elements: es;
	alphaColor: 0.3;
	normalizeSize: #numberOfVariables min: 5 max: 20;
	normalizePosition: [ :aClass | aClass numberOfLinesOfCode @ aClass numberOfMethods ] min: 0 @ 0  max: 300 @ -300.
v  open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleMetricNormalizer2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABeCAYAAADVA7GfAAACnUlEQVR4XuXcSyt1URyA8eMy
lJm5r2BqwMhMJjLyAZSBKRNjU0ouKQaUAQYMRCkTYiIjUSi55BYmpFweb//W4JR6Ry97n/0+
T606J7P1a6299znLKX19+aukSv4p8IP484P4Qfz5Qfwg/vwgfhB/fhA/iD8/iD8/iB/Enx/E
D+Iv+vgAP0gFdXDgB/FvWf78IH4Qf34Qf34QP4g/P4gfxJ8fxA/izw/iB/HnB/HnB/GD+POD
fOvkBF5ff+6LJD/IP1YEDP+W5Qf5/S4vi7E1aUDu7uDz0w/izw/iB/HnB/GD+PODZNPLC+zv
+5/U/flB/CD+/CB+EH9+ED+IPz+IPz+IH8SfH8QP4s8P4gfx5wfxg/jzg/jLDyS+tbu4KO6Z
qf8OZGUFFhfh6sqPUjEgIyOwtgbX136UXEDiWOfxcZr8OHcbBw0CJoZ/+nMAiYPP3097xPut
LdjchLk5ODz042S6ZZ2eQox4HRf1hYW0Qvr70xa2upr+Fhd9P8gvFpO/t1feomJMTsLgYHo9
OwvT03B7myCKcG6qsCDLyzA1BcPDZYy4w1paKoPEODryI2QKMjQEo6MwPg5nZ3B+DnFxDwj/
7W/GW9bGBszPQ18fdHcnnJsbP0LmIG9vaUV0dEBbG7S2QktL2qr8W1TGIA8PsL2dMJqaEkRP
D/T2wswMvL9D/M7tT/74sB/kLz09pZXR3Az19dDQkFDiTsr/MJgDSPzDZayIqiqorU0onZ2w
u5u2Kv/HJRmDTExATQ2USlBXl1ZHfG7ln+acQNrbE0aMxkYYG4PHRz9IbiADA1BdDV1d6Sn8
/t6PkStIAKyvw84OPD/7MSruwdCfH8QP4s8P4gfx5wfxg/jzg/jzg/hB/PlB/CD+/CB+EH9+
EGd/ACi98fSb7A31AAAAAElFTkSuQmCC'
]

{ #category : #icons }
RTRoassalExample >> exampleMetricNormalizerIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADQ0lEQVR4XuXcbUuaYRjG8b5y
HyAc9aoFgdiLoBas9SC55osg2ohYjKLSIJNasZ6gNEer1O5yVh7tOm9SGuyBJPO2/wEXdyJC
XL/u83q4L2u7u+MnSGnjdwEfhB8+CB+EHz4IH4QfPggfhB8+CB+EHz4IP3wQPgg/fBA+CD98
ED4IP3wQPgg/fBB+WgtEt7fyZmZUz2e92VkVRkdV8TyhQaamphQKhfSqo0NvBwY06zr03eBg
fZ3qPvu9vV3lo6NHf74wMiJrP1Mp8e+QJ0z58LCuDi1vb+tqcVH8ksVPsEAKhYLGx8bU09Oj
97GY7HV0eFjp9fVa43f5M4LIJZPJKJFI6Pj42F7q29aWisVirfG7nF+y+CD/S6VS0c3NjezK
J2gwSDweV1dnp153dysSDivixpNxG0fcFPTHyYkPsLezoy/z89rd3eWD8EsWH4SfZoO8cav0
2MSEJqJR9ff1aXhoyC9Z5XJZq0tLfpk62NvTwf6+ttNpv/EpGgiy48aIXC6nI7ftYRBbm5u1
8SN7vxVSdGsUmwYXzs78xqfglyw+SDWlUknVlT2f4BlBbBsl3Nurj9PT6o9E9MldDSO5suJf
426cqeLwwy9ZfBB+mgjiXVwo4UrTqttoTK2tyWZXV5eXslU6v9v5IHyQlx7PPa/PuD+y6+tr
tTyIrdhbHcPu/mprCZBsNitrn+fmFJ+c/O2Xtmlv1j3IalUQuzMegnhPeLqFX7LqiJWpKsZq
Min+GBKg0vUiBvWz01NZs5/z5+f66jYf+bxBAtnY4IPwSxYfhJ8ggDw83GCxLfcPsZi/Yl9a
WPB3fvkMTb5D7GmhfxTITR/z+TwfhF+ygCAXbnPRNhj/9J4dbvjXsdKUHUWt42sIfJBGgbjV
Lx+EHz4IP00CeTi1rR5y4Hd9gO4Q/kkTfsnig/wtWejsKZAg9ug2ubzMB+GXLD4IP3wQPgg/
fBA+SMOmvvzpb0BA/O8ZuqmvtVY/wcgvWXwQfvggfBB++CD88EH4IPzwQfgg/LyQlfr9fwTi
JyB3CH8fi1+y+CD88EH4IPzwQfgg/PBB+CD88EH44YPwQfjhg/BB+OGD8EH44YPwQfjhg/DD
B+GD8PPY/AJeDlpBtqIlvwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleMidPointCenterUsingBezier [

| v es startingElement shape |
v := RTView new.

es := (RTEllipse new color: (Color blue alpha: 0.4); size: 15) elementsOn: (1 to: 20).
v addAll: es.
es @ RTDraggable.

"we are properly locating the nodes"
startingElement :=  (RTEllipse new color: (Color red alpha: 0.4); size: 20) element.
v add:  startingElement.
startingElement @ RTDraggable.

RTCircleLayout new initialRadius: 80; on: es.
es translateTo: 0 @ 0.

startingElement translateBy: -150 @ 0.

"Building the bezier lines"
shape := RTBezierLine new
				midPointInCenterOfObjects: (1 to: 20) inView: v.
v addAll: (shape edgesFrom: startingElement toAll: es).		

v open.
v  canvas
]

{ #category : #icons }
RTRoassalExample >> exampleMidPointCenterUsingBezierIcon [
	^ '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
Dz/8rFr+AnBX68ww1MTcAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleMovingCamera [
	
	| v menu |
	v := RTView new.
	v add: (RTEllipse new size: 50) element.

	menu := RTMenuBuilder new view: v.
	menu menu: '<-' callback: [ v canvas camera translateBy: -10 @ 0. v signalUpdate ].
	menu menu: '->' callback: [ v canvas camera translateBy: 10 @ 0. v signalUpdate ].
	menu menu: 'V' callback: [ v canvas camera translateBy: 0 @ 10. v signalUpdate ].
	menu menu: '^' callback: [ v canvas camera translateBy: 0 @ -10. v signalUpdate ].
	 
	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleMovingCameraIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAABj0lEQVR4XuXVIU+CURgFYJOF
TzY3JsFNNzc3i2wEA6MatJMcweAcFIk6ihuFgNViwPEfDCT+AM0RIJGtGrTpNbB9YwiFfeCe
ZzvhvvGccDd8Pt8S7YdEU7c9v5blu55xOww5mrqVQyqx907IuV/fcl2EXIUcxG7bIYWQs5B0
7H4ccuNX5vP5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6f
z+fz+Xy+/yybze7mcrkTv4kVq1Qqt/1+/208Hn9PUq/XH6IoSvvtJKzRaDzGh4in1+uNNgO/
pYTk8/nCX2NM0ul0un5TCWm1Ws+LBvmN31RCBoPBuz/IGul2u6/+IGukWq3eLRpjOBx++k0l
aDQafc0bpFgsnvotJSiTyWTDX/Ixa4xSqXTpN7Qi5XK52mw2n9rt9kutVrtPpVJbfis+n8/n
8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6fz+fz+Xw+n8/n8/l8Pp/P5/P5fD6f
zzffDyz/G9+Gw2cAAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleMovingGrid [

| v es size initialLayout layout step |
v := RTView new.
v @ RTDraggableView.

size := 10.
es := (RTEllipse new size: 20; color: (Color red alpha: 0.4)) elementsOn: (1 to: (size * size)).
v addAll: es.
es @ RTDraggable @ RTPopup.
"es when: TRMouseEnter do: [ :evt | evt element translateBy: (20 atRandom @ 20 atRandom) - (10 @ 10) ]."

RTEdge buildEdgesFromElements: es
	from: #yourself
	toAll: [ :value |
		(value \\ size) = 0
			ifTrue: [ { value + size } ]
			ifFalse: [ { value + 1 . value + size } ] ]
	inView: v.

initialLayout := RTGridLayout new
	lineItemsCount: size;
	on: es.
layout := RTForceBasedLayout new initialLayout: initialLayout.
step :=  RTSpringLayoutStepping new 
				view: v;
				layout: layout.
v addAnimation: step.
	
v  open.
v canvas 
]

{ #category : #icons }
RTRoassalExample >> exampleMovingGridIcon [
	^ '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
foMMNP4E5gU0YnvlseEAAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleNamedPopup [

| v es |
v := RTView new.

es := RTLabel elementsOn: (1 to: 10).

v addAll: es.

es @ (RTPopup new 
	named: #yourself
	background: Color blue
	group: [ :group :el |  
 
		group addAll: (RTEllipse elementsOn: (1 to: el model)).
		RTWeightedCircleLayout new
			initialRadius: 50;
			on: group.
		]).

RTHorizontalLineLayout on: es.
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleNamedPopupIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABeCAYAAADVA7GfAAAB4UlEQVR4XuXVu4oiQRSA4Xlk
IwMTcx/AVF/B1MBLoHiJVAwEUQRBDARFBDU47tTCFt0PsMPA94Pgae0W6+uivz4fv9/Ul78E
PoifD+KD+PkgPoifD+KD+PkgPoifD+Lng/ggfj6ID+Lng/ggfj6ID+Lng/j5ID6Inw/ig/j5
ID6Inw/ig/j5IH4+iA/i54P4IH4+iA/i54P4IH4+iJ8P4oP4+SA+iJ8P4oP4+SA+yI81n8+j
OO92uxiNRvnY5XKJ6XRa+s54PM7zer2O8/mc5+PxGJvNJs+32y0Gg0Hp/MlkkufX6xWdTqf0
eavVisViEf1+PziQ2WxW+tNpIXq9Xj52Op1KIM1mM9rtdp5Xq1XUarU81+v1T6VSKV1zOBzm
+fF4RLVazfP7/Y4EcL/f87FGoxHf10kvb4dst9t4Pp95Ma7Xa2lxDofD37u1eE5a1H/vl8tl
FHfZfr+PIkDq+07P79NvpV1U/Lzb7ZbmdEOkXVbcaf4zxH+G+Pkgfj6ID+Lng/ggfj6ID+Ln
g/ggfj6Inw/ig/j5ID6Inw/ig/j5ID6Inw/i54P4IH4+iA/i54P4IH4+iA/i54P4+SA+iJ8P
4oP4+SA+iJ8P4oP4+SB+PogP4ueD+CB+PogP4vff+wMItDGYvnMiCAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> examplePlacingGroups [

| v |
v := RTView new.
g1 := RTGroup new.
g1 addAll: (RTBox new size: 10; elementsOn:( 1 to: 200)).

g2 := RTGroup new.
g2 addAll: ((RTEllipse new size: 15; color: Color red )elementsOn: (RTShape withAllSubclasses)).

v addAll: g1; addAll: g2.

v addAll: (RTEdge buildEdgesFromObjects: RTShape withAllSubclasses from: #superclass to: #yourself scope: g2).

RTGridLayout on: g1.
RTTreeLayout on: g2.

TRConstraint move: g1 onTheRightOf: g2.

v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> examplePlacingGroupsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABgCAYAAADrc9dCAAAFSUlEQVR4XuWZzWsTURTFsxB0
KVgU/NiJoNiqRUTBnehGQRSsbl2IC3HlqrjoQndCF36gC8GNIAoqCLq0gv4B6j/QjVShrW0n
H5N0kvt85yZv8jKZSSOkaZNzYMibmZP30vvLve9OkzOGX5tJOf4Q8APhFz8QfiD84gfCD4Rf
/ED4gfCLHwg/EH7xA+EXPxB+IPziB8IPhF/8QPiB8IsfCD8QfvED4Rc/EH4g/OIHwg+EX/xA
+IHwix8IPxB+8QPhFyGQpaUlPXo1DsNQj16O/TWGHsjs7KwevRq7APZy7K/BnyH8GcIPhL9k
8Zcs/gzZlBkiHz+KyeWMnDghED+QDQYS3LwphQsXzNKtW6b07Zvwl6w+l6zV1VWx1KVarcrC
woKEMzNSPHvWBNPTEvz6JfPz81IoFGRlZUXy+bzwZ8g6ZEgQBBJFkRSLRX2tVCoCMK5EAQ4g
4ToOeHBuF1cwpVJJIQHQepS1oQeCgLrgAUYyQxB0d14ul+Oxu4731mo1HQMGBJiAgvPFxUWd
A3M7H3/JSgiBcuUIr8n7uO6Cm7yeBOJA+fec12UXoAMIsmtubk7nBbC0tWkyBEFBkBGYTqUE
gUwG1y9n/jkywZ/fzyA/y+Dz72GMz4LswoHzfu1Bff/nouzcKXL1qriA4VuaFWBtZT9/Ftm1
S6qTkxqkVI+dR44ckdq1a61Avn8X2b1btB1uKA/g1ivnzqF2tQHEobKfUQ4fFvn6VbMFnxOv
gF6xzUNw44bUXr7U96vXfkZ4B65klU6fNsUzZ0z1+fOuvnGyY4eEp06Z6vbt2aapKROOjxt9
Bnn8uDmvPS8fPaqvvje4cqV+zY5T13z0SMpjYyY8frzNg30mmJgw1ZERnaP04YOUjx2rrz0y
MnhA/t65Y0I8uP350xWQaGpKVq5fN9GePdLpgbBy4EA9KN68eEB0D4pJb+H8eSOfPqVn3O/f
Uh4dlfzFi0bu32/z+PPCK1u21M9v3x64spbDxon2M62epwl+lKpioryk7R/JPaSTF/NmArZy
7XFWmRyqLgt/cFYHldxwcbigdPJjTr+z6lgGrTrN5eC7bm/ogbgAr5Ul7lvs/FlZ4u53821e
y4s9wnV5rrX+3ywZuJ9wAcL90cvLy6l/rN99uYBkZYHfpa319O17UZKS91FOk/C6La+D+2A4
M2MKL16I21SjJ08E3QzaRm1F7bjy4EF9bL2lp0/Fba6F9+/1Pq47r86FdhUtKsYpG7HrsHxv
dPdu7MVmX52eNpHtmvT83j3RdeH78kXK795ldmUDDUTevBE5eFBq27bF7ejqvn31DunQoXqw
0a6OjmoA4I327m22rvYVLafvrW3dGnsr+/fX57LrtOwbr1+L73Xvjb1uTZw3vLpuw+va3OS8
g/9g+POnyOXLLe1o3DbiAavxm4ae2wyKvfD4Xnu9zTsxIeHJk+rBOi1Afvxo9doMcPPqZ/Jb
WeuN17EZ5Lx6nph3aLosefZMe3jX98vDh819wP6WIY3fM9Rr77V48d7GXqHet2+bdR8Z2PC2
dVcItOeVV69icDohyqSbF5Ds/dhr36dQ+X8P+T8Nc0e0bl3WMAPhzxB+IJsXCNpZbVUz/kfF
rz6XLBkb0y5LuyE8r/BnyAZnyKVLzfa0i46IH0gf9hC/RebXJuiyNlr8GcIPhB8If8niz5Ce
jPmB8APhF3/J4gfCL34g/ED4xQ+EHwi/+IHwix8IPxB+8QPhB8IvfiD8QPjFD4QfCL/4gfCL
Hwg/EH7xA+EHwi9+IPxA+MUPhB8Iv/iB8IsfCD8QfvED4QfCrx7oH6mCLh8Lryj6AAAAAElF
TkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleRectangleLayout [

| v |
v := RTView new.
v @ RTDraggableView.
v addAll: ((RTBox new size: [ :value | value / 2 ]; borderColor: Color black) elementsOn: (1 to: 100)).
RTRectanglePackLayout new on: v elements.
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleRectangleLayoutIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAEZElEQVR4XuWdzys9URTA3//h
31CytJC1rJAsFEtLUX6UIhQ2FhaKFEVRJEWRlJVslFJiZ2tpd+f7zvQdjfvuzFx3fryZ+Zw6
Pc2dH+/dz5x7zz333KvheXwpkzT4VcAHwhc+ED4QvvCB8IHwhQ+ED4QvfCB8IHzhA+ELHwgf
CF/4QPhA+MIHwgfCl8oDeX9/V19fX16SPj8/ezbnZXUv1+ddXl62HLu9va0OkJubG/Xx8eEl
6eHhoWdzXlb3cn3e5ORky7H5+Xk+ED4QPhA+ED4QPhAnIPIb+UD4QFhAokSaJz4QvoWUF4gM
zDY2NmJ1bGzMu76+jtWdnR3lCmR/f/+XyuC3MkCaFajkRyRpV1eXZ3OeDTjTW5ynhVQqdGJr
ITaVmKbS+ED4QPhAigKi9yF8IAUAierDuru7fddXVz6QlPeSStS9s/CxqOvW1taMcPlAcrAQ
m+v4QPhAyg3k7u6upVPVtb+/P3E809vbG1vOB2IJRKZMk8QUb7KpWBudnZ1tgTcwMFAdIFdX
Vyop1CHaaDQya45cmx4bNV0nz6udhZQNiOmlub+/V1tbW4oPpCQW8j82x7cQPhA+EKNKf7i7
u6tMXh0fSJs69bm5OeXi+eGBBB3x4uKiMTwik1hxXt/x8bFRFxYWPD6QFBaiW0JQ5hrtNV3H
B+IAJBjhB6N4PpAYbfr3iRUdVIRt/xCMol9eXn4le5+envrnbG9vOwPRk62/v7/rBeQv8+RZ
TT65dup5xa0qCUQ6ZD6QEgERKQpIVCR5ZmbGH4+E9e3tTfGBpLzf+Ph4bAhfr/RAR0ZG6j8O
KZuFxJWZns8HwgfCB8IHUjCQcKXGfedwWGZvb0+dn5+r19fXenXqZ2dnKmmefGVlxTs6OlLy
aSqfnp7++Xt1dTUVsLjy8AuRl2W0HYhteMX2jU9yaflAKggkLnOxs7PT18HBwXpmLmYBRCon
aNslMyQPC5HvaerDapcGlLWF2AYq+UD4QJhA+E0WxMvCAHl6ekoN5OLi4scVfXh4UOHJr79G
euOavL6+vpb596mpqfqtws1LXbLc48pNZScnJ3wgfCB8IHwgfCA1BaIHIkdHR52BNDvwlqwT
yWzBABEvyeQppbEQ2TXCFUhecavCgCRtrRGVyhlendTR0RG7/My0olZ0c3NTLS0tKT1xISkn
KwpI1PFaBBeDCaesd/nR23YXC+UD4QPhA+ED4QPhAykCSOV2to5aFj00NOTv7KZ7RZLFIWqq
EPGOwuOJ5eVlfyo1aqMAWe0kgUZbDy94tkzThs8bHh72raCnp6ewrZlKMQ4Jj3htUnd0i/nr
3odRlatbgiz0FDFtSIAFIhYxMTGh+EBKZCHr6+ttBSKDTL3ZqxyQz89PFd7oS7L9ZEeEQKOu
a7blv1REdv8MHzs4OEj13UzPEJG+Knz88fHRa4fw/6FLyYQPhA+EL3wgfCB84QPhA+ELHwgf
CF/4QPhA+MIHwhc+ED4QvvCB8IHwhQ+k7vIP3qBBe9TjobAAAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleResizingElements [
| v es resizeAnimation shape normalizer |
v := RTView new.
v @ RTDraggableView.
normalizer := RTMultiLinearColor new.
shape := RTBox new size: #yourself; color: [ :value | (normalizer level: (value / 100)) alpha: 0.4 ].
es := shape elementsOn: (1 to: 100 by: 10).
v addAll: es.

v canvas addMenu: 'Press me!' callback: [ 
	es do: [ :e | 
		resizeAnimation := 
			RTResizeMove new 
				toExtent: (100 - e model) @ (100 - e model) on: e.
		e model: (100 - e model).
		v addAnimation: resizeAnimation ] ].
v addAnimation: (RTLayoutAnimation new elements: es; yourself).

v  open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleResizingElementsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAACBElEQVR4XuXYT0sqURjA4T6u
Oz+DfgmPdyeIi8ABcW0KbYS5biyajVxoIVFKhCWXC/UaUxAE0X8v0vODl8HhOAznEQZnb7Px
26X2/C3wQfxeA+l2u9HpdOK9X1gul+Fv2xZBUkrR6/Wi3W5HpVKJVqsV/X4/Go3Gw8aXWLVa
LarVaozH4yiKwgfZJshkMnnY4Ol0GoPBIMrPWZZFs9l8Oj8ajWI4HG7q9XrMZjMfxH+G+CB+
PoifD+KD+PkgPoifD+KD+PkgPoifD+Lng/ggfj6ID+Lng/ggfj6ID+Lng/ggfj6Inw/ig/j5
ID6Inw/ig/j5ID6Inw/i54P4IH4+iA/i54P4IH4+iA/i54P4+SA+iB8LEqtV3K5u4t/84vG4
+hs386tnU667nK/jpfFBttB1fhJnKYvyeJ6fxlE6fDblmoNUxEvjg/gg1jPEB/FBfJDP5IP4
ID6I/z9kB9pPi3htjvN15L/vIv26fXPKdfnJdaTs7ENT3kc6PIrPjA/ig/ggPogP4oP4ID6I
D+KD+CA/Mx/EB/FBvg3PB/FBfJAt5IP4IH7+6/f3/DKLg/jK5Is/ka+PIy32vzzldXwQH8QH
8UF8EB/EB/FBfBAfxAfxQXwQH8QH8UF8EB/EB/FBfBAfxAfxQXYxH8QH8UF2PR/EB/HzQXwQ
Px/EB/HzQXwQv//dPcyFUJ9iOehYAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleRotatingAnimatedLabels [


	| v shape timer |
	v := RTView new.
	timer := VITimer new cycleLength: 2.
	
	
	shape := RTRotatedLabel new.
	"shape angleInDegree: [ :cls | cls numberOfMethods negated / 1.5 ]."
	shape angleInDegree: [ :cls | 
		| valueEnd |
		valueEnd := cls numberOfMethods negated / 1.5.
		VIAnimatedValue new
					evaluator: [ :t | 0 interpolateTo: valueEnd at: t ];
					timer: timer;
					yourself. ].

	shape text: [ :cls | '                                                                                ', cls name ].
	shape color: (Color black alpha: 0.2).
	v addAll: (shape elementsOn: Collection withAllSubclasses).

	v canvas color: Color white.
	v addAnimation: TRResetAllShapes new.
	timer start.
	v open
]

{ #category : #icons }
RTRoassalExample >> exampleRotatingAnimatedLabelsIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleRotatingElements [
| v es |
v := RTView new.
es := (RTBox new color: (Color blue alpha: 0.4); size: 30) elementsOn: (1 to: 60).
v addAll: es.

es when: TRMouseEnter do: [ :evt |  evt element trachelShape rotateByDegrees: 5. evt signalUpdate ].
es @ RTDraggable.
RTGridLayout on: es.

v open.

]

{ #category : #icons }
RTRoassalExample >> exampleRotatingElementsIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleRotatingLabels [


	| v shape |
	v := RTView new.
	shape := RTRotatedLabel new.
	shape angleInDegree: [ :cls | cls numberOfMethods negated / 1.5 ].
	shape text: [ :cls | '                                                                                ', cls name ].
	shape color: (Color black alpha: 0.2).
	v addAll: (shape elementsOn: Collection withAllSubclasses).

	v canvas color: Color white.
	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleRotatingLabelsIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleScaledNesting [

	| view inner host edges outter trachelCanvas resizable |
	outter := OrderedCollection new.
	view := RTView new.
	view @ RTDraggableView.
	
	1 to: 200 by: 10 do: [ :i |
		inner := (RTBox new color: (Color purple alpha: 0.2)) elementsOn: (1 to: i).
		host := (RTBox new color: (Color yellow alpha: 0.1)) element.
		outter add: host.

		view add: host.
		view addAll: inner.
		edges := 
			RTEdge 
				buildEdgesFromObjects: (1 to: 100) 
				from: [ :v | v // 2 ] 
				to: #yourself 
				inView: view
				scope: inner.

		RTGridLayout new on: inner.
		RTNest new		
			on: host nest: inner.
	].
	RTGridLayout on: outter.
	
	trachelCanvas := view setUpCanvas.
	TRFocusCenter on: trachelCanvas.
	
	"Zoom a specific element"
	resizable := outter at: (Random new nextInt: outter size).
	view addMenu: 'Smaller'
		callback: [ view addAnimation: (RTResizeMove new 
													toExtent: resizable extent * 0.6 
													during: 0.3 on: resizable) ].
	view addMenu: 'Bigger'
		callback: [ view addAnimation: (RTResizeMove new 
													toExtent: resizable extent * (1 / 0.6) 
													during: 0.3 on: resizable) ].
	
	view openWithMenu.
	view canvas
]

{ #category : #icons }
RTRoassalExample >> exampleScaledNestingIcon [
	^ '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
VwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTRoassalExample >> exampleScrollZoom [

	| v |
	v := RTView new.
	v @ RTZoomableView.
	v add: (RTLabel new elementOn:
'Scroll your mouse wheel
while hovering cursor
over the view to zoom it').
	v open.
	v canvas 
]

{ #category : #icons }
RTRoassalExample >> exampleScrollZoomIcon [

	^'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'
]

{ #category : #sources }
RTRoassalExample >> exampleSelfCalls [

" The RTNest class offer simple methods to encapsulate some elements into a composing elements. Consider for example the following visualization that shows the shape hierarchy in Roassal. Each purple square is a class. Classes are linked with to represent class inheritance. Gray boxes are methods. Relation between methods indicates a possible invocation path between methods within the same class."		
| v classes classElement classElements shapeBuilder methods methodElements |
v := RTView new.
v @ RTDraggableView.

shapeBuilder := RTShapeBuilder new.
shapeBuilder rectangle
	size: [ :m | m linesOfCode min: 60 max: 5 ].

classElements := RTGroup new. 
classes := RTShape withAllSubclasses.
classes do: [ :class |
	classElement := (RTBox new color: (Color blue alpha: 0.4)) elementOn: class.
	classElement @ RTPopup.
	v add: classElement.


	methods := class methods.

	methodElements := shapeBuilder elementsOn: methods.
	v addAll: methodElements.

	RTEdge 
		buildEdgesFromObjects: methods 
		from: #yourself 
		toAll: #dependentMethods 
		inView: v.
	RTTreeLayout on: methodElements.
	methodElements @ RTDraggable @ RTPopup.
	
	RTNest new on: classElement nest: methodElements.
	classElement @ RTDraggable.
	classElements add: classElement.
].

RTEdge buildEdgesFromObjects: classes from: #superclass to: #yourself using: (RTLine new attachPoint: RTVerticalAttachPoint instance) inView: v.
RTTreeLayout on: classElements.
v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleSelfCallsIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleSmoothLayout [

	| v translator |
	translator := RTSmoothLayoutTranslator new.
	v := RTView new.
	v canvas addMenu: 'grid' callback: [ RTGridLayout new translator: translator; on: v elements. v canvas signalUpdate ].

	v canvas addMenu: 'hori' callback: [ RTHorizontalLineLayout new translator: translator; on: v elements. v canvas signalUpdate ].

	v canvas addMenu: 'treeV' callback: [ RTTreeLayout new translator: translator; on: v elements edges: v edges. v canvas signalUpdate ].

	v canvas addMenu: 'treeH' callback: [ RTHorizontalTreeLayout new translator: translator; on: v elements edges: v edges. v canvas signalUpdate ].

	v canvas addMenu: 'cluster' callback: [ RTClusterLayout new translator: translator; on: v elements edges: v edges. v canvas signalUpdate ].
	
	v canvas addMenu: 'circle' callback: [ RTCircleLayout new translator: translator; scaleBy: 0.8; on: v elements. v canvas signalUpdate ].
	
	v canvas addMenu: 'radial' callback: [ RTRadialTreeLayout new translator: translator; on: v elements. v canvas signalUpdate ].
	
	v canvas addMenu: 'sugiyama' callback: [ RTSugiyamaLayout new translator: translator; on: v elements. v canvas signalUpdate ].
	
	v addAll: (RTBox new elementsOn: (1 to: 100)).
	RTEdge buildEdgesFromObjects: (1 to: 100) from: [ :value | value // 2  ] to: #yourself inView: v.

	RTTreeLayout new  on: v elements edges: v edges.
	v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleSmoothLayoutIcon [
	^ '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'
]

{ #category : #sources }
RTRoassalExample >> exampleTimeLineOfRoassal [

| d popup v |
"Time line of code in Roassal"
"We compute the number of methods created for each day. We keep the information in a dictionary"
d := Dictionary new.
RTObject withAllSubclasses do: [ :c |
	c methods do: [ :m |
		d at: m ageInDaysAsInteger ifAbsentPut: [ 0 ].
		d at: m ageInDaysAsInteger put: (d at: m ageInDaysAsInteger) + 1 ].
].


popup := RTPopup text: [:assoc | assoc value asString, ' methods added on day ', assoc key asString ].
v := RTView new.
v addAll: (RTEllipse elementsOn: d associations) @ popup.
RTGlobalBuilder new
	view: v;
	normalizeX: #key min: 0 max: 500;
	normalizeSize: #value min: 5  max: 30;
	normalizeColor: #value;
	alphaColor: 0.3;
	execute.

"We add a line from the left most element to the right most element"
v add: ((RTLine new color: Color lightGray) edgeFrom: v elements leftMostElement to: v elements rightMostElement).

"It make sense to only drag horizontally"
v @ RTHorizontalDraggableView.

"We add a small legend"
v canvas addFixedShape: (TRLabelShape new text: 'Each circle is a day. Size of the circle indicates the number of methods produced that day').
TRConstraint stickAtTheBottomOfTheWindow: v canvas fixedShapes last.

v open.
v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleTimeLineOfRoassalIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD9UlEQVR4XuXXW09TWRjGcT6X
V34BEw/xwmg0xpioMTExXnjhIWq88hCjUaPRBCeKBaMIRAQFbNpKdRCRCREoCKVyKi3CwLSU
lj7Os5sZ4iTjDBfGjPN/khW62+61V9/fendL1efP/PyXUsUvAR+EHz4IH4QfPggfhB8+CB+E
Hz4IH4QfPgg/fBA+CD98ED4IP3wQPgg/fBA+CD98EH74IHwQfvggfBB++CB8EH74IHwQfvgg
/PBB+CD88EH4IPzwQfgg/PBB+CD88EH44YPwQfjhg/BB+OGD8EH44YPwQfj5v4BoZETlxkYV
Tp5Ubtcu5U+c0Mr4uL7lYkvT0yoOD6u8uCgciJyF9+81++qVinNzqwUoLS0pPzPzl4LIhQow
8vv2Kbdz5+rI7t+v8bo6TTQ3a/mLOdaM7Cx9+qTyyormnz/Xby0tyoZCmvWcxdFR5aemlInH
tWikYP55rzc3OflDY1UNxmLq6ehQPpfT1MePmkmngzoo9fKl+mtrFbt+XeErV5T2bl/IZtXt
grT4+Bef0xMOq8sQifPnlTp1SqPr1imxfr3imzerbft2tW7cqIj/drhrolevVt4bq6lR5OFD
Tbij5l3EWc856esWi0WVSqXKtdMuatbr6PQ5jT634ehRxQ8fVnsw18GDCp8+rfi5c+q+eVOD
wfWfPtWHBw/0wfAzXnchk/muKMHa/21jBflq5/tzr4J0+UM8qq5Wd1eX2vy4/dkzJZNJhe/c
0ZOLF1Vz9qxCLni0rU3d0ageX7qkGh/fvXxZ9zxCPn5x7Jg69u7Vmw0bFN20SU/27FH9gQN6
tHu3mtwld48f109nzqj+xg3V+v3VFy4o5vl+9u6OGLbdO7+vr09DQ0Ma9c5/0dqqeCSiel/7
nqGrjdFw6JAeB/MeOaKQ56ozVJPX1+Q5m73+2K1blTUPuJOSvb1u2unvNgYGBv7x9bGxMaVS
qa++PuwOn/QmDB5X/eoHhb+5Jwe3qawBgjHh8efzcy5a+u1bFd1RwXFw7oKLV25o0NyWLZrf
ulXzO3Yo6TGybZt6XcjEtWvKvn6t5Xxec+60om97a9l52URCg94kmf5+pdyVk7dva8SYKXdt
vrNTaXd35o8x29NT6Y6Mr8P/UnfK3pkl79Ivv0OW7t//ZsVRoVBByLmDC+/eif8ra42/tNy/
Knu3anlZ/B+x/P9D+CD88EH4IPzwQfgg/PBB+OGD8EH44YPwQfjhg/BB+OGD8EH44YPwwwfh
g/DDB+GD8MMH4YPwwwfhg/DDB+GHD8IH4YcPwgfhhw/CB+GHD8IH4YcPwg8fhA/CDx+ED8IP
H4QPwg8fhA/CDx+EHz4IH4QfPsiPl98ByUwFby0fOIYAAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleTreeLayout [

	| view |
	view := RTView new.	
	view addAll: (RTBox elementsOn: Collection withAllSubclasses) @ RTDraggable.
	RTEdge 
		buildEdgesFromObjects: Collection 
		withAllSubclasses from: #superclass to: #yourself inView: view.
	RTTreeLayout on: view elements edges: view edges.
	view @ RTDraggableView.
	view edges do: [ :e | e trachelShape pushBack ].
	view open.
	
]

{ #category : #icons }
RTRoassalExample >> exampleTreeLayoutIcon [
	^ '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
u5nePWZ+kW8AAAAASUVORK5CYII='
]

{ #category : #sources }
RTRoassalExample >> exampleVectorEditing [
	| view selected statusBar |
	view := RTView new.
	selected := nil.
	statusBar := nil.
	
	view when: TRMouseClick do: [ :evt |
		selected == #line ifTrue: [ 
			| ex1 ex2 line |
			ex1 := (RTBox new size: 10; color: (Color purple alpha: 0.2)) element. 
			ex2 := (RTBox new size: 10; color: (Color purple alpha: 0.2)) element.
			ex1 translateTo: evt position.
			ex2 translateTo: evt position + (100 @ 60).
			ex1 @ RTHighlightable.
			ex2 @ RTHighlightable.
			ex1 @ RTDraggable. 
			ex2 @ RTDraggable.
			line := (RTLine new "width: 3;" color: (Color blue alpha: 0.2)) edgeFrom: ex1 to: ex2.
			view addAll: { ex1 . ex2 . line }.
			line trachelShape pushBack.
		].

		selected == #circle ifTrue: [ 
			| ellipse |
			ellipse := (RTEllipse new size: 40; color: (Color yellow alpha: 0.2)) element. 
			ellipse translateTo: evt position.		
			ellipse @ RTDraggable. 
			view add: ellipse.		
		].

		
		selected == #rectangle ifTrue: [ 
			| box |
			box := (RTBox new width: 40; height: 30; color: (Color blue alpha: 0.2)) element. 
			box translateTo: evt position.		
			box @ RTDraggable. 
			view add: box.		
		].
		view canvas signalUpdate.
	].



	view @ RTDraggableView.

	view addMenu: '+ line' callback: [ selected := #line. statusBar text: 'line' ].
	view addMenu: '+ circle' callback: [ selected := #circle. statusBar text: 'circle' ].
	view addMenu: '+ rectangle' callback: [ selected := #rectangle. statusBar text: 'rectangle' ].
	view addMenu: 'Info' callback: [ UIManager default inform: 'Vectorial editing is hyper cool' ].

	statusBar := TRLabelShape new.
	statusBar text: 'Please, select an option'.
	view canvas addShape: statusBar.
	statusBar setAsFixed.
	TRConstraint stickAtTheBottomOfTheWindow: statusBar.

	view canvas color: Color white.
	view open.
	view canvas
]

{ #category : #icons }
RTRoassalExample >> exampleVectorEditingIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAADFUlEQVR4XuXVS0tqURyH4b5w
gd+gUeUgCCIowYGTDBRxEIGoYYSRN8QLEhlWWpQpmVkNtH51/ou2FOcyOJwD0fuCqPuy9nY9
e+HM6yu/r9QMfwq+MMhgMNDfDtRut/UvbuhX4wyHw+m2RqOhbw/SbDbdj8xkMkokEopGo4pE
Isrlcp9+vHdcKBTS7u6udnZ2lE6ntbGxocXFRWWz2d9O1tramra2tnR4eKhkMqmFhQXFYjHZ
NQOBgAqFgvL5vJaWltx14/H4dCw7x7uv1dVVhcPhn+7t24CUy2X5/f4pyMHBgVZWVuTz+T5N
ysfj5ufn3UTay7YZytzcnAOZTCbTc7a3t91EemMb5Obmpur1ukOYnZ3V8vKyu6adb9cwkPX1
dXfcRxDvvuyeSqWSgsGg+P8h/7Gnp6c/rjD+nzo/Pgg/PggfhB8fhA/Cjw/CB+HHB+GD8OOD
8EH4U8AH4ccH4YPw44PwQfjxQfgg/PggfBB+fBB+fBA+CD8+CB+EHx+ED8KPD8IH4ccH4ccH
4YPw44PwQfjxQfgg/PggfBB+fBB+fBA+CD8+CB+EHx+ED8KPD8IH4ccH4ccH4YPw44PwQfjx
Qfgg/PggfBB+fBB+fBA+CD8+CB+EHx+ED8KPD8IH4ccH4ccH4YPw44PwQfjxQfgg/PggfBB+
fBB+fBA+CD8+CB+EHx+ED8KPD8IH4ccH4ccH4YPw44PwQfjxQb4RSKVS0cXFharVqobDoV5e
XnR9fS3badufn591f38v74ROp+M+93o9XV1dyd7t+/n5uY6Pj93nwWCgyWSim5ub6Xndblfj
8Vi27+joSJeXlzo7O9NoNHLj8CneQfb3992E2HsikVCz2VQ+n1e9XlexWFSpVFKtVptOWLvd
VjqddvtPT08dZKFQcJNdLpfdcalUyo3h7dvb29PJyYkbx65j22OxmMNPJpOyh4JP8Q5iT7b3
hNsTaxN+e3srWwkPDw9u9djLWxm2WlqtljvOnnbbZyvBVoB9tmN+QNlLd3d37jw71sa2ibfr
2OqwMR4fHx1qv9/ng7z3Bl50tq2EUZhJAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleVisualizingSoftwareWithBeziers [

| v inheritanceEdges shape helpBar1 helpBar2 elements |
v := RTView new.
shape := RTEllipse new color: (Color red alpha: 0.4); size: [ :e | e numberOfMethods / 5 max: 5].
elements := shape elementsOn: Collection withAllSubclasses.
elements @ RTPopup @ RTDraggable.
v addAll: elements.

"Defining edges from inheritance"
inheritanceEdges := 
	RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself inView: v.

"Layout the whole thing"
RTForceBasedLayout new 
	userDefinedEdges: inheritanceEdges;
	on: v elements.

"Defining edges from dependencies"
Collection withAllSubclasses do: [ :cls |
cls methods do: [ :cm | 
			((cm literals select: [ :l | l class  == Association and: [ l value notNil ] ]) collect: #value) do: [ :depClass | (cls ~~ depClass and: [ Collection withAllSubclasses includes: depClass ]) ifTrue: [ 
			
		RTEdge buildEdgesFromAssociations: { cls -> depClass } using: (RTBezierLine new follow: #superclass; color: (Color blue alpha: 0.1)) inView: v ] ] ]
].


helpBar1 := TRLabelShape new text: 'Circle = classes, size = number of methods; gray links = inheritance;'.
helpBar2 := TRLabelShape new text: 'blue links = dependencies; layout = force based layout on the inheritance links'.
v canvas addFixedShape: helpBar1.
v canvas addFixedShape: helpBar2.
TRConstraint stick: helpBar1 above: helpBar2.
TRConstraint stickAtTheBottomOfTheWindow: helpBar2.


"Open the view"
v open.
v canvas

]

{ #category : #icons }
RTRoassalExample >> exampleVisualizingSoftwareWithBeziersIcon [
	^ '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
t5T/yz92IvXRDqRfGUPpU6OIOwPMqMf2TPpTPwVw4MCom9xXXKzWxfBMkUqVGpercxAIvrq6
+vJHb779Cw+/oN6E0tbFV3k5toYUWhGn2orsu8CsArbdVJMHmQGqvB//PsAYe5U89yD5IvwC
U4QoTUx/DmxgEyIrq0pOebiiorMvkZien5rae3RiYvnCq5c//O2ZvpPfjjA7roN3nNIx+BpF
vN0jfO3KZuViWacZyKt9sVj05/+1oaX3+lHhQcKUdlR1HE+x0rWUYHC8b3QcVev30J4pQBHs
AdKCRRfLqXgsFutsamrqkclUWp+oIoEJuOJlRk+mpU1Mcjizc2AwbEG5o/VSz5RCURfdaNUl
QRnKTO6NWxrG0p1OpD22plMqj/oQ8hUgjgxmWUor0r3ehtY1oZjJrxOKY9gpz6P1Jg98IQYm
0+B21zYm+y7ue+jY7DSk1BTwhmfT0p6/AM4mTLvsqiqw7ioUoNGxvb13FGXMJNLrL+Vy/vhn
G+Jgn0pr6/2aIhHYDK4tFvLuLavBKIn1FLO8XGustVS30V92JemUbYs71tIygxGPp6V1dNQY
eg/0ZvsvgGhqR6aTcu4//bYk7Uf/AswJoZKB+7mAEUYjNhV7a1FhP0IiUUGBtMzp9EfOnbv0
GqSIytXtkI4YIbe0pcXjg3qE9LRhEOgXE/a0poq4ZD94drbXa2Mc/2Ch79ZPJrRz7ygzvvu7
ZvHuL5ejj37ejLznJxBjMh+xij2e5i6NZmq2oODM+fHIu5/M9n/nDyH5c7dfPPOtX1ssjW1s
dlGRxdLau7Bw4429e1++6y8LjW/UJlgJworQ5/NRq7RnVrTB0revr28SDsGVlpaWC4VC0fGx
sYun2mffstt7h8XiSh04WjmIJ3RmljY2NOw5nEisPG+375h4sX//V25N7Xv/pYPf+M+L+7/2
7xfm7vzsrRdu/axdf/37EeH8OwrufmyOTyTWlshicR4y1spQmkKKmGVxS+041CmRSMqg3srK
SkM5YihguS2XW109PSN7o9HukbBIFF06snLFZvOH3e7qmk8toad37VoA1yico8JOuXsOnwiH
EwUlDiNuSiSaAaIAEyBOrw9FbDY4p5uXtx3hNYJXXaC4fZkrXx1H+Yve9GPvjSH2FBZfJyD8
4ZMlspRTiDk5KpXRDgodFhdxg2EDPSIQwLIcjhHBvkitNjvr6yOtUH+byTnM5/M/HWeGVdS1
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
QmCC'
]

{ #category : #sources }
RTRoassalExample >> exampleWorm [

| v s e last lineLength callback nbOfElements head |
v := RTView new.
s := RTEllipse new 
				size: [ :m | m * 10 ]; 
				color: (Color blue alpha: 0.4).
nbOfElements := 10.
last := nil.
1 to: nbOfElements do: [ :i | 
	e := (s elementOn: i).
	v add: e.		
	last ifNotNil: [ v add: (RTLine new edgeFrom: e to: last) ].
	last := e.		
].

lineLength := 40.

callback := TRTranslationCallback 
	block: [ :shape :step | 
			| diff alpha dist |
			(shape element outgoingEdges collect: #to) do: [ :el | 
				diff := shape position - el position.
				alpha := diff theta.
				dist := ((diff x * diff x) + (diff y * diff y)) sqrt. 
				el translateBy: (alpha cos * (dist - lineLength)) @ (alpha sin * (dist - lineLength)) ] ].
 
v elements do: [ :el | el trachelShape addCallback: callback ].

head := v elements last.
v when: TRMouseMove do: [ :evt | 
	head translateBy: (evt positionFromCamera - head position) / 10.
	v canvas signalUpdate ].

head translateBy: -150 @ -150.
v open.
	v canvas
]

{ #category : #icons }
RTRoassalExample >> exampleWormIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAE30lEQVR4XuWb7UsUURTGj1pg
EL2gtBYo0rC4gS6xrtpWhNALSAYRqR+CNMQ3FHxBwxeULBPLD64vVFaIbUUJuuJLiiSSRmQv
CPUX1eEyzMzOzDq7zqwfnh9cdJmZ/fA8e+8595w7hA8++OCDDz744IMPPvjggw8++OCDDz74
4IMPPvjggw8++OCDDz744IMPPvjggw8++OCDRFISkc9HdPMmUW2tMq5eJcrNxdcnoVy5ojXB
bPj9+Fo5yvHjRDU11syQR1kZvm6OcPhwbEaox927+PrZTlVV/IbwKC3F19A2zp7dmxnycLnw
tbSFeA2orydqaFA+37qFr+WeOXIkNhMePyZ6+9Z4DA2JdBmfPZCfb82I+/fNjVCP5mYiScLX
1VFDenqsmcHjwQPxzPnz+No6Ykh7Owt95kx4OSnJiiH9/cqzmZn4+tpuyPS0LLbHE17KyZlb
im5Ia6v2efyYEiPp6eZmdHVFCr67KZHfwSk1PjalvcGgkejmpoTDRAMD2sFpMT4xEggYG2K+
NGlN+fSJ6Pt3otlZ4/u5WJmWhq9zTFRWxmKIbIrL9fW/EdvbRBsb0ZcxLlqePImvs2VYrNgM
YRMyMnb+uFy/dojev7cWV44dw9faMqdOacvvk5PmIvPyxDNja8vjWV4zD/ShkNaQGzfwdY6J
o0eVBtXDh+aGbG4SrazsHuiHh/Uzj8s1+MQxWwoKiJ490wo8MiKyp48frWVfLS16Q3jvg0+c
nDunF7Sx0Vr2NT4uzItMn/l5txtf27jh5pPaEN6N75Z9hRf0s0sebBR/z+XL+NrGTUmJtg8S
LfuanPR45hbNA/2TJ/idRlvgMsidO+YpMde9eIniGRAt0Pf1aWcc/vK1Rw4eFD14dYmE4wKL
29SkFl+SZhf0phhVBfBxqAbG5mhnhNYUdXlePVJT8fV0ZHc/OGi0nAlTpt7pkwN5hhUW4uvp
iClmPfdgUJK6+nJyevpFO5h38Orr3d3i+awsfE1tgX/hLOijR1qhJyaI2tpkwyRpOGgc6Ovq
FFPz8vD1tBW1uPoNpT7Qv3mjv5dLOPjYhNlhba5rGQX6zk79vdeu4etoKxUVu5XzhSmvQ+Yd
S3wcLrlExo3BQQ70p0939uIbkjC4dctntKqrhQlTUyLN5fKLHOjl7Es+kMcVZb6XZxn+IQkH
KS42W56EKVOq2TM2plxnMw8dwtfPdqK9gzI0pAT61VWimRmi0VGln3LvHr5+jpCdHe2EiyR9
++l2f/6ijTV8epLv8Xjw9XMEPmJaXq6YwbNA3o/Mz0vS/LLb/WOH/9eW6y9exNfO8dnC7Vxu
VPGBbtmYDx/c7t9/fb7NbfH56VNhCMcgfBKE/iyx17u05vMtrxN1dIhrly6J3smBA/h6JWzP
wvFCbv2GQl7vxCufb/ylqImpSzLc68fHQfhXf/u2UcDPy5tfCQReTItzwnJVmMf16/i6OUpy
sogpvO9Qm9LR4fePvwwEltbFzHn+XLmWkoKvW0LhzErsU/z+xTUlFZbjCn7/JMEUFQnhufWr
3ptw7x7/FOQ+cOKEtl/Pb/r29uLv3vcVo9OTPPBfb9hH+FVrDvgXLoi/+K814IMPPvjggw8+
+OCDDz744IMPPvjggw8++OCDDz744IMPPvjggw8++OCDDz744IOPbfwDrvFXiiOUZrIAAAAA
SUVORK5CYII='
]

{ #category : #accessing }
RTRoassalExample >> label [
	^ 'Plain Roassal'
]

"
RTGrapherExample new installTitle: 'MethodSize2' 
		code:
		'


	| b classes normalizer |
	b := RTGrapherBuilder new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| data ds |
		ds := RTStackedDataSet new.
		data := (c rtmethods reverseSortedAs: #numberOfLinesOfCode ).
		
		ds interaction popup.
		ds dotShape rectangle color: (normalizer rtValue: c).
		ds points: data.
		ds connectColor: (normalizer rtValue: c).
		ds y: #numberOfLinesOfCode.
		b add: ds.
	].

	b axisX.
	b axisY.
b build.
b open.
^ b view canvas'
	
"
Class {
	#name : #RTGrapherExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #sources }
RTGrapherExample >> exampleAgeOfRoassalAndTrachel [
 
| methodsRoassal methodsTrachel greatestAge b ds |
methodsRoassal := RTObject withAllSubclasses flatCollect: #rtmethods.
methodsTrachel := TRObject withAllSubclasses flatCollect: #rtmethods.

methodsRoassal := methodsRoassal select: [ :m | m numberOfLinesOfCode < 300 ].
methodsTrachel := methodsTrachel select: [ :m | m numberOfLinesOfCode < 300 ].

greatestAge := (methodsTrachel , methodsRoassal collect: [ :m | m date asUnixTime ]) min.

b := RTGrapherBuilder new.
b extent: 300 @ 300.

ds := RTDataSet new.
ds interaction popup.
ds dotShape circle color: (Color blue alpha: 0.3); size: 5.
ds points: methodsRoassal.
ds x: [ :m | ((m date asUnixTime - greatestAge) / 3600) asFloat ] .
ds y: #numberOfLinesOfCode.
b add: ds.

ds := RTDataSet new.
ds dotShape circle color: (Color red alpha: 0.3); size: 5.
ds points: methodsTrachel.
ds x: [ :m | ((m date asUnixTime - greatestAge) / 3600) asFloat ] .
ds y: #numberOfLinesOfCode.
b add: ds.

b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleAgeOfRoassalAndTrachelIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleBarAndCurve [


| b ds |
b := RTGrapherBuilder new.
b extent: 400 @ 400.

ds := RTStackedDataSet new.
ds barShape color: (Color red).
ds points: (-3 to: 3.1415 * 5 by: 0.1).
ds y: [ :v | v sin ].

b add: ds.

ds := RTStackedDataSet new.
ds noDot.
ds connectColor: Color blue.
ds points: (-3 to: 3.1415 * 5 by: 0.1).
ds y: [ :v | v cos ].
b add: ds.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleBarAndCurveIcon [
	^ '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
DqzquEBjAy0AAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleBarsAndDots [

| data b ds |
data := (-5 to: 5 by: 0.1).
 
b := RTGrapherBuilder new.

b extent: 300 @ 200.

ds := RTStackedDataSet new.
ds points: data.
ds y: #cos.
ds barShape color: (Color blue).
b add: ds.


ds := RTStackedDataSet new.
ds points: data.
ds y: #cos.
"ds barShape color: (Color blue)."

b add: ds.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleBarsAndDotsIcon [
	^ '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
UYtIR/UAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleColoredAndInteractionLabel [

	| b |
	b := RTDoubleBarBuilder new.
	b interaction action: #inspect.
	b shape label 
		text: [ :cls | '<', cls name, '>' ];
		if: [ :cls | cls name endsWith: 'Shape' ] fillColor: Color green;
		if: [ :cls | cls name endsWith: 'Box' ] fillColor: Color red.
	
	b points: RTShape withAllSubclasses.
	b bottomValue: #numberOfMethods.
	b topValue: #numberOfVariables.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleColoredAndInteractionLabelIcon [
	^ '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
AElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleCrosses [
 

| b ds |
b := RTGrapherBuilder new.
b extent: 300 @ 300.

ds := RTDataSet new.
ds dotShape cross color: (Color red alpha: 0.3).
ds points: (RTShape withAllSubclasses flatCollect: #rtmethods).
ds x: #numberOfLinesOfCode.
ds y: [ :m | m getSource size ].
b add: ds.

b axisX.
b axisY.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleCrossesIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleDateOnXAxis [
 


| methods oldestMethod b ds |
methods := RTObject withAllSubclasses flatCollect: #rtmethods.
methods := methods reject: [ :m | m numberOfLinesOfCode > 150 ].
oldestMethod := methods minFor: #date.

b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds := RTDataSet new.
ds dotShape circle size: 5; color: (Color blue alpha: 0.1).
ds interaction popup.
ds points: methods.
ds y: #numberOfLinesOfCode.
ds x: [ :m | m date julianDayNumber - oldestMethod date julianDayNumber ].
b add: ds. 

b axisConfiguration 
	noDecimals;
	title: 'LOC'.
b axisY.
b axisConfiguration 
	title: '';
	labelRotation: -30;
	labelConvertion: [ :v | (Date julianDayNumber: v + oldestMethod date julianDayNumber) ].
b axisX.

b build.
^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleDateOnXAxis2 [
 

| dates minDate b ds |
dates := Array with: Date today with: Date yesterday with: Date yesterday previous.
minDate := dates min.

b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds := RTDataSet new.
ds interaction popup.
ds dotShape rectangle color: Color blue.
ds points: dates.
ds x: [ :aDate | aDate julianDayNumber - minDate julianDayNumber ].
ds y: [ :d | d dayOfWeek \\ 7 ].
b add: ds.

b axisY.
b axisConfiguration 
	labelRotation: -30;
	labelConvertion: [ :v | (Date julianDayNumber: v + minDate julianDayNumber) ].  
b axisX.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleDateOnXAxis2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADKklEQVR4XuXczUtqQRzGcf+5
/pkWLjNpYS4KdRFtglAUCSNcCBYVGpEpJb6BIkobXZmGIYovkBL8jDmXe7lw48qxPCN9H4ha
9NB4Puo4M3Rs8zk/6xQb/xLwQfjhg/BB+OGD8EH44YPwQfjhg/BB+OGD8MMH4YPwwwfhg/DD
B+GD8MMH4YPwwwfhxzqQdrstf3/nRyOI1+uVi4sLA2IwGEi/3/8HZTgcSrVanfd6PQyYzaYJ
JJPJyPb2tuRyOXG5XKLy2e/VajX+q2ed5hA+CB+ED8IH4YPwQfggfBBLPn7yQfhZHcjb25tx
sZ+fn4UPohmk2WxKvV43LvbW1tanF12t1FOpFGqlrg1kNBpJPp83Vuput1tmsxl/pc6fQ/gg
prO52eWD8EH4IPy3LD4IH4QPwgfhg5jK7wXf/87U+SAWghweHi48U+ev1C0CeXp6ErVlwj9T
588hfBA+CB+ED8IH4YPwQfggfBA+iJUg4/GYf6a+TiA+n49/pr4uIOVyWTY2Nvhn6vw5hA/C
B+GD8EH4IHwQPggfhA/CB7EUpNvtLjxTL5VK8tWdgJ/Y/XaQ3d1dY0Gofl50pv7w8CCVSsX0
1+3t7XyZns5uoVDQ8wq5u7uTvb29hWfqr6+vSz/bfnKXf68T/qT+a/NxMpkIv6sZRM0dDodD
AoGAOJ1O4Xc1gZyensrBwYHc398bg4rFYsLvagJRH33f39+NwV1dXQm/qwmkWCzK+fm5tFot
Y1DX19fC72oAUWuLo6MjsdvtEo/H/wyQ39UAcnx8LOr9c39/X8w+Q2jdlYJks1k5OTkRtR1i
9rZ+tO5KQdTkpf4nfWdnRxqNhqTTaeF3NYCovZnLy0tjYMFgUPhdjSDqJpdnZ2cSCoWM908r
uureKTq6X328KwNRG2NqQJFIxBhQIpGQ6XQqVnRvbm6ML6u7Ho9HHh8fTXctAel0OpJMJsXv
94vaDjDzB76jGw6HTV+M7+hGo1F5eXmRtdxcXOaBUbtrsw7hhw/CB+GHD8IH4YcPwg8fhA/C
Dx+ED8IPH4QPwg8fhA/CDx+EHz4IH4QfPggfhB8+CB+En1XlA+KfYhAltsKuAAAAAElFTkSu
QmCC'
]

{ #category : #icons }
RTGrapherExample >> exampleDateOnXAxisIcon [
	^ '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
0U/6AdFM/wHYRxAyEaJaiwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleDoubleBar [

| b |
	b := RTDoubleBarBuilder new.
	b points: RTShape withAllSubclasses.
	b bottomValue: #numberOfMethods.
	b topValue: #numberOfVariables.
	b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleDoubleBarIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleDoubleYAXis [

	| b ds |
	b := RTDoubleGrapherBuilder new.
	b extent: 300 @ 200.
	
	ds := RTStackedDataSet new.
	ds points: #(4 3 2 2).
	ds barShape width: 40.
	b add: ds.
	
	ds := RTStackedDataSet new.
	ds points: (10 to: 13).
	ds dotShape color: Color blue.
	ds connectColor: Color red.
	b addRight: ds.
	
	b axisXNoLabel; axisY.
	b axisConfiguration color: Color red.
	b axisYRight.
	b build.

	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleDoubleYAXisIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADmUlEQVR4XuXbW0vbYADGcb+Z
CPsKskvxbrsTvNIbQRRPg3oxRRAH0ot65YUXgspQUTyjFbEyL2wd4hQHlpXqPPTJ8sYJKk0T
NW2T/h8IrfYQ8/5M3jyx1lkWP2FKHX8I+CD88EH4IPzwQfgg/PBB+CD88EH4IPzwQfjhg/BB
+OGD8EH44YPwQfjhg/BB+OGD8MMH4YPwwwfhg/DDB+GD8MMH4YPwEy2QhoYGmduuri7Nzs7q
5eOyc3V15SxRHYxUSq/62d22t7m5WQcHB4rFYpqenlZPT48CBTk7O1Nra6vzpp2dnTIoxUC2
trZ0enrqunLznHQ6bZVaqhHF49LKir5/HNFrUH5PThbd3v7+frOp6u3tldt4BXLIur291fX1
teubHx0dlVxxWECUTMpB6OuTLi/fvEdrYaHka29ubpzHS41ZWeeQsIIom30YfIOwsxPYIdUL
pOqTelhAVChI3d36/OGHcl+/lW1O44N4AGhpSRobq9hJBR+kygB8kKevteeAT/Up5WMjoTmt
RoE4E/DiojMZh7W31DTIz+Vl61c8br33VBQBcn9/r5aWFt3d3TlFx22wTTst1dRfgjQ2/rGS
XxIORjWL4Vvz175iUWx7BwYGnO9NTU2pra1NTU1NwfeQ8fFxXVxc6OTkxBUk6KYe1mbv1dSH
h4efFejHy0qBguTzeVW6qYcdxO2QZcbIjNXTr2viLCuqIDV72ssH4YPwQfggfBA+CB+ED1Lb
IKaDTNolyNyfm5vT/v6+gmjqUQdxa+omKftvweZ2bW3tVZ8z8L2HDA4OOm/a0dEhewltUy/3
8/009fPzc/uS3MNFUfOLPDExESyIWYFBWF9f1/z8vMy1rbAesioJUuqQZUDMeI2Ojj5r7bg5
JCwg/EmdD8IH4YPwQfggfBA+CB8kkiC7u7uRaOqVBHFr6oeHh3q8NWNlelzgIBsbG/ym7rOp
JxIJFQoFewda0N7entrb24MH4Td1/4cs88kccw3LjNnq6mrR/6fhzyH8SZ0Pwgfhg/BB+CB8
ED4IH4QP4p2ZmRnPpr65ualsNotv6n7G610gx8fHyuVynk09k8loe3tb5vmEJZlMFm3qfsbr
3XvI0NCQvJq6/sfix9d4lX0O4Sdkkzo/fBA+CD98ED4IP3wQfvggfBB++CB8EH74IHwQfvgg
fBB++CD88EH4IPzwQfgg/PBB+CD88EH4IPzwQfjhg/BB+OGDRCn/ACEOsXsP+FT6AAAAAElF
TkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleEbola [

	| tab data b ds |
	"Preparing the data"
	tab := RTTabTable new input: (ZnEasy get: 'http://mapstory.org/geoserver/wfs?typename=geonode%3AEbola2&outputFormat=csv&version=1.0.0&request=GetFeature&service=WFS') contents usingDelimiter: $,.
	tab removeFirstRow.
	tab replaceEmptyValuesWith: '0' inColumns: #(10 11).
	tab convertColumnsAsInteger: #(10 11).
	tab convertColumnsAsDateAndTime: #(3 4).
	data := tab values reversed.


	b := RTGrapherBuilder new.
	b extent: 350 @ 150.

	ds := RTStackedDataSet new.
	ds interaction popupText: [ :row | row at: 12 ].
	ds dotShape ellipse 
		color: (Color blue alpha: 0.3);
		size: [ :row  | (row at: 11) / 5 ].
	ds points: data.
	ds highlightIf: [ :row | (row at: 10) > 100 ] using: [ :row | row third year ].
	ds y: [ :r | r at: 10 ].
	ds interaction popup.
	ds connectColor: Color black.

	b add: ds.
	b axisX; axisY.

	b build.

	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleEbolaIcon [
	^ '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
Ifwxffgff5Jw1WkAY5wAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleFunctions [


	| b ds |
	b := RTGrapherBuilder new.
	b extent: 300 @ 300.
	
	(Array with: Color red with: Color blue with: Color green with: Color yellow) doWithIndex: [ :color :i |
		ds := RTDataSet new.
		ds dotShape ellipse size: 0.
		ds points: (0.0 to: 10.0 by: 0.1).
		ds connectColor: color.
		ds x: #yourself.
		ds y: [ :v | v raisedTo: i ].
		b add: ds.
	].
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleFunctionsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEl0lEQVR4XuXd3UobQRgG4FxB
r6S34WnxuLfgQY604oFrBAUj9a/QntjS0hapAQ+0LVbRqq2/YBUqGlsUBRUDkmBDFJW+2/km
TjDF2nWzyY55v2XIbjTr7D67M+bb7CTiuvxhU0T4dwE/CH/wg/CD8Ac/CD8If/CD8IPwBz8I
Pwh/8IPwBz8IPwh/8IPwg/AHPwg/SHGcn59DHvf393FxcaGLzMtzqVSq8DP+XVshkKWlJRwe
HkJ2/ubmpi6ZTAbRaBSxWExDyHI6ndbz8phMJl2zzBDAFioGUl9fj4mJCTQ3N2NsbEwXx3Ew
OTmJtrY2LCws6GUJ85rt7W2qMwZ4Dav7ECYQ4AzWd+pcIO38IHaBfOEHsQvkLT+IPRhHuBNv
DHlAevlB7ALp5wexC+QHP4g9GO8D2UZ+kMBAxvlBqq3/4AcJDOMgsO3zBbK3t4dcLqczvn+n
3M0yF0h/uCAjIyNIJBI609vS0oK6uroCjCybNLyEpN3n5uaqOv0OxMMFWVlZwfr6OpqamtDa
2oqpqSmdjl9cXNTLMzMz4DpDfocLwt+HlOfs4AcJBCTBD2IXSIofxB6M7sC3ix+kJJBBfhC7
QE74Qaq5ueIH4QepFoxc2baHH8SC9x78ICWDjPOD2IPxoqzb4jv9Lo+M6XdgwD6QhoYGmDQ7
U/odyJR9G3yByA4fHR3Vn3ZnSr+X++zg70NuDbLCD2IPxtOKbAM/iGeQD/wg9mA8q1j9+UE8
gTznB7EHY6SidecHsaTv4AexrKniB/EEMsMPYg/Gu1DqzA9yLUYOwAY/iD0gr0Krry+Q3d1d
nJ2dVeWn34E3odbVF8jx8fFtP/2Ou5B+B5KhNVUlgdTW1mJ+ft7Tp99lEJqtra2iwWjsBfkU
eh35+5ACRqsVdeQH0RgfrakfPQjwNfR+gx+kgLGoMOatqhstSP7MWLCuXpQgeYxZK89aOhDg
s8L4aW2fRgUC9FWkHtOY5h8E82aIWZT7QlM3utGjJv4z5EaIjIJ4GfjfVhk8JNT0TU3LauJv
sv4LkVIQnQjqDtkYYhhVk+M6GoO/D/GMkFDFf7MhO16OeDn6H6vpznXqZux3mb9pvPeNjWDf
CZ+cnKgdv6xKPqvsBUF2tBzhicubbbrQVTjiZX1B1y8UEDP2uxkL/rrfkbT72lqfe3r6SKV7
HVeKe/noZb5T7zY14T4cRFzn10NEo2nXUb9iygNnGRE1Y4osOw4ufw7XzHc6WbfohZclE41e
+/zV0nXPgRNR9fBQvj8ZDOcMMWO/Sype0u/XNyXAwcFBoOl3WV+QR7RN6ytrH+K1SfMaR0f5
cXF3dnZwddlvmDrJDpSLbuZGJL+RzWaLWop/tRqhgXhp0m4TPT35vmJgIH+fhln2Ex0dHRge
Htav7+3Nj7c7NDRUUh3j8XjRjUxXr5xaAeKlSfMa8o+B3LklX4chVyVXV1f1st/1yVXNxsZG
vb729nb9HSjJZNL3+mQMsZqamsIVU/P1HVb+28sf/CD8IPzBD8IPwh/8IPwg/MEPwh/8IPwg
/MEPwg/CH/wg/CD8wQ/CD8If/CD8YeIPX2amRIdH+ZAAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleGroupViewOnHistogram [



| b ds |
b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds := RTStackedDataSet new.
ds dotShape rectangle size: 0.
ds points: RTShape withAllSubclasses.
ds y: [ :c | c rtmethods size ].
ds barShape rectangle 
	width: 10;
	color: Color veryLightGray.
ds interaction 
	highlightColored: Color red.

ds interaction popup 
	named: [ :c | c name, ' methods' ] 
	background: Color veryVeryLightGray 
	group: [ :group :element | 
		| s ms |
		s := RTBox new size: #numberOfLinesOfCode; color: Color red.
		ms := element model rtmethods sortedAs: #numberOfLinesOfCode.
		group addAll: (s elementsOn: ms).
		RTGridLayout on: group ].
	
b add: ds.

b axisY.
b newAxisConfiguration plain.
b axisX.
b build.

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleGroupViewOnHistogramIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADJElEQVR4XuXaSWsiQRiH8Xxu
L979CMnBi4ecBD0qLigEEdxRlKBBiYIejHjw4PI6vk0qNE6NOqPd2vP8oSh7SVvWL71Udz/t
9/w8Up74XcAH4YcPwgfhhw/CB+GHD8IH4YcPwgfhhw/CDx+ED8IPH4QPwg8fhA/CDx+ED8IP
H4QfPggfhB8+CB+EHz4IH4QfPggfhJ9ggxQKBYnFYhKJRESnE4mEJJNJOV5vtVqJFn5XewzS
brfl/f1dnp+fnc7udrui847Xm0wmUqlU+CB+HrLW6/XJDv/4+JB+vy+5XG4/GAx+5uu0Fn58
PofwQfggfBA+CB+ED8IH4YPwQfggV/9Wp8ghvg8MtdaRuubl5UWKxaJ1pN7r9TAg5jftdju5
yx6it1Bms5mDop//NFI3IFq/vb05xTR+OBw606PRSPggV0b3AB2pb7dbueSQZWp3MfN0V+eD
+HwO8RtEt+knNh+EDxJcED8uIvggfBA+CAakVqs5Hff19fUzwOKD3BHElFt2HgZkPB47XxiN
Rp260WjI4T/87EidD+LxHmJectDn61ouGanzQTwA0S/NZDISDof3ettD945msyn8Qxb/HMIH
4YPwQfggjwbyr/ek+CABAlkul6JXgVrzQR4AxIs7wXyQG4CYWzbz+VwCDVIqlZw32/X5+nQ6
tTbgViN1L0Hc7Qg0SDwel9fXV2m1WhIKhawNuNVInQ9yQfRNE32e3ul0JJVKSVAPWf8NyD3O
IYPBQC65fDXrmPX/FiSbzZ7tWBs2H4QP4i/I8TwbyKmO4YP4CKIXDFr4IA8CcryMD8IH4YPw
QU4knU47o3R9nn5ohLUBi8XiqoGhFyDmZW8biFlmQMyL4KZ2F9u27wpyeHzrPMI1tS2fn59S
LpelWq06jTe1u+jjX/d0vV7/bR0z73hd9zLb35n1T23T1g4DYmu3WXZq23cB0b1C33rfbDaS
z+etDZDv7Pl5nHMIP3wQPgg/fBA+CD98ED4IP3wQfvggfBB++CB8EH74IHwQfvggfBB++CD8
8EH4IPzwQfgg/PBB+CD88EH4IPzwQfjhg/BB+DmbX54DDngf154DAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleHistogram2 [
	| b ds |
	b := RTGrapherBuilder new.
	
	"We defien the size of the charting area"
	b extent: 500 @ 100.
	
	ds := RTStackedDataSet new.
	"When the mouse is above a bar, say which class we are point at"
	ds interaction popup.
	
	"Each subclass of RTShape will be a bar"
	ds points: RTShape withAllSubclasses.
	
	"The height of a bar will be the number of methods (defined in the instance side)"
	ds y: [ :c | c rtmethods size ].
	
	"We set a color of the rectangle"
	ds dotShape rectangle color: Color blue.
	
	"All the bar have to be stacked from left to right"
	ds stackX.
	
	"Set the width of a bar"
	ds barShape color: Color blue; width: 10.
	b add: ds.
	
	b axisX.
	b axisYWithNumberOfTicks: 4.
	
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleHistogram2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADI0lEQVR4XuXaP2vqUBjHcd9J
+5bcS/sGCu1soVXRqUPfQTsoOLjpVL3+nVxKNyU4xEEEwUVxULSPzZOQS0yDt71Nau79/uCQ
HELOycnH5OjBxG7HT5yS4N8CPgg/fBA+CD98ED4IP3wQPgg/fBA+CD98EH74IHwQfvggfBB+
+CB8EH74IHwQfvgg/PBB+CD88EH4IPzwQfgg/PBB+CD88EH44YPwQfjhg/BB+OGD8EH44YPw
QfiJGYhpmjvDMPh3JU5PyGg0kt8HE04Jyt2dc0y3/PBB+CB8ED4IH0Qn9V6vtwsCeXsTeXx0
ShDIy4tz7PVVhH9bf+AJWa9FvHU/yM2NczyOT4z3g8QHicMgfa9evca4vmqRIIfmxv8W5P5e
5ORE5OHBeVXovhY+SEiT+ldB/PVj3gT+E8IH4YPwQUIE2W732+aD8EFiswIRi0k9ziA/DbR3
WWLFQonFE/L0JKLlbwblPzdKkO9cpy4z6bnucpPuH+2V5f217Af50xPTbIroua1W8C9v91xd
f4sa5DtPtr9tu61jgRwC8Nf1xnsBbm8/1/Y/D7K17sRwOIwURPtYrVbyFRB/X3EACRpH6CA6
qReLReuT2LKL25nu1+tt8dYvLkx7X7daPzsbyaG6e269XpdqtbrXVqPROlj393V+bga27b/u
ZrMlh47r/tWVaS/p6DaoL3/99NRZAnp+/vVhHFrcJaKg+vW109fl5Siwrw8gKj6bzSJdb+L3
8clvWdPpVIL2w8xisdAvcrK23n9R9eGdBzebjWiJoo/xeGy3O5/PRUvoIOl0WjKZjLjbKAaR
TCZlMplIuVyWWq0WGUipVLLbNgxDtETRx2AwkOVyKYVCQdrtdvgg2WxWut2uNK3vlPl8PpJB
5HI5qVQq0u/3JZVKhd6HM/80RMfS6XRs9LDh3T50LNaPaNH9MPvg/3Mx7mtZ/PBB+OGD8EH4
4YPwQfjhg/BB+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfhg/DDB+GHD8IH4YcPwgfhhw/C
B+GHD8IH4YcPwg8fhA/CDx+ED8IPH4QPwg8fBJF3z7uGtXujWGMAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleHistogramWithNegativeValues [

	| data b ds |
	data := (1 to: 20) collect: [ :v | 10 atRandom - 5 ].
	 
	b := RTGrapherBuilder new.

	b extent: 300 @ 200.

	ds := RTStackedDataSet new.
	ds interaction popup.
	ds points: data.
	ds barShape width: 8; 
	      color: (Color green alpha: 0.3);
	     if: [:value | value < 0 ] fillColor: (Color red alpha: 0.3).
	b add: ds.
	b build.
	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleHistogramWithNegativeValuesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD+0lEQVR4XuXbzU7iUBiHcW/O
W/EOXJmIH9GFC5fGRHeuTFyocWEgiooGiRkM+B1HUwwgxAQDOpqoeZm+xympTtFSqQPz/Jum
B9LTlvOjPRwoPfU6P52UHn4T8EH44YPwQfjhg/BB+OGD8EH44YPwQfjhg/DDB+GD8MMH4YPw
wwfhg/DDB+GD8MMH4YcPwgfhhw/CB+GHD8IH4YcPwgfhp7tBZmZmJJFIyPPzs4yMjIjXOk9P
T/Lw8CC65Dd1yCBiZ2trS25ubiSfz3s2eK1Wk7OzM9Gln20uy7Ls2xMfJEBeXl7EOQseHx+b
NmKlUvHdwHyQb+hD+CB8ED4IH4QPwgfhg/BB+CD/AsSN8L58ak85e9LyL3vigzTJ0dGRTE1N
mQYaGBiQ+fl5mZ2dFa+RerFY/HCkzgdpA4iO0re3t00DraysiA4SR0dHJchInQ/SxkuW+53f
7CzgX7L4fQgfhA/CB+GD8EH4IL5BYhIz67TrmN3b02XanvggfBA+SFeDZDIZ2d9/bbxmP+Hq
2OT6+jr0kTofxM75+bnorOXJycnAv6nzQdoEomdHNpuVnZ0dmZ6ebnrAlmUFvmTtVfcCg9ze
3gZulMXaYmCQr+z3W/qQZDJZz+VyUrDxyomEaLmUTDbKUSsqKSvlWV7dW61nrawp/7R+mue9
5rgVN+u4n0ulUnX3Y92fHkOzbbjnhR8LdWd7uty1dhvbKKbTb9bNHx+b568uLszjw8PDzgZx
zhA5PRVZfn3XSSzWKIf1bntfV/enx/CVd7nZRvrt2SJXV+a1yP29dPQZojfQ6ayfsgqFgrQC
Uq1WRWcta91W9nt3dyflcrlRxyn7AdG6ep+Z3tznrusHpGJ/sPHab8eAaGeu88nJiTnQVkDm
5uZkY2NDSqWStPrCJiYmZGhoSIaHhxtLvyBad3x83OzXXdcPSGxpyXO/HQMSjUZFZ+30BwcH
WwJZW1szde3+x9Rt5YNGb2+vubVV76pcX1+XsbExXyBOXb1FVvftrvsZSMZeL9Lf77nfrhgY
+u1D2plW+pAPt/FJH9KVI3U+SAggTmerHbde7/Xy4nTE7pG612/qfJA2g+g10v14c3NTP/eb
mx38jNT5ICGcIfF43HS+CuGUDw4OxNclyx5EfbVx+CAhfdvLB+GD8EH4IHwQPggB5DvCB+GD
8EFCA7m8vDRfVevv6/ZYJNDd73yQNoHoILCvr898sxmJRHT+ax0doSuI3/+phwryJ//9JUv/
o+58n1Xnp/P7EH74IHwQfvggfBB++CB8EH74IPzwQfgg/PBB+CD88EH4IPzwQfgg/PBB+OGD
8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DjK78B7gqeCFF7BtEAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleLabelledBars [


| b ds |
b := RTGrapherBuilder new.
b extent: 400 @ 200.

ds := RTStackedDataSet new.
ds interaction highlight.
ds points: RTShape withAllSubclasses.
ds barShape width: 10.
ds y: #numberOfMethods.
ds histogramWithBarTitle: #name.
b add: ds.

b axisY.
b newAxisConfiguration plain.
b axisX.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleLabelledBarsIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleMethodSize [


	| b classes normalizer |
	b := RTGrapherBuilder new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| ds data |
		data := ((c rtmethods reverseSortedAs: #numberOfLinesOfCode ) collect: [ :m | m numberOfLinesOfCode ]).
		ds := RTStackedDataSet new.
		ds dotShape ellipse size: 0.
		ds points: data.
		ds connectColor: (normalizer rtValue: c).
		ds y: #yourself.
		b add: ds.
	].

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.

	b build.
^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleMethodSize2 [

	| b classes normalizer |
	b := RTGrapherBuilder new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| data ds |
		ds := RTStackedDataSet new.
		data := (c rtmethods reverseSortedAs: #numberOfLinesOfCode ).
		
		ds interaction popup.
		ds dotShape rectangle color: (normalizer rtValue: c).
		ds points: data.
		ds connectColor: (normalizer rtValue: c).
		ds y: #numberOfLinesOfCode.
		b add: ds.
	].

	b axisX.
	b axisY.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleMethodSize2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAHgUlEQVR4XuWc228TSRbG55/j
nb9hn1bat3kYrRAPgATSouWBWWl3EdKMVqBIK4YMkCU4Tpx4gvEkmeDM5OJ7fOlut/vubtvd
btvtr7erIzsGjCceDFicTzqSq7u6bNXPVXVOVXV95fv0tUj6in4V0AdCX/SB0AdCX/SB0AdC
X/SB0AdCX/SB0AdCX/SB0Bd9IPSB0Bd9IPSB0Bd9IPSB0Bd9IPSB0Bd9IPRFHwh9IPRFHwh9
IPRFHwh9IPT1eYC0Wi14nodqtQqW7vf7YEa/mj4TkHq9jo2NDViWFULI5XJg9vZD5XKZ3Rul
G0YCbkekD27eQDY3N7G6uorLly9jbW0N0Wg0tEkPViqV0fXBgH4r+uxjyDgQ+lpAIN2uQh/Q
IgFx7BJ9IIsEpN+z6ANZJCBuR6IPZFGAAB4cp0wfyKIASaT/AkF4RB/IvIE0m00MBgN0u93f
jdTf7rLaXZk+kI/RQu7du4elpaXfjdR3dnbeuMYrLwJ4bfpQ5gnk2rVrePLkCdLpNLa3ty8c
qTOd7n9NfxxZJC+rpR/Cdev0gSxMHFKOQm3+Sh/IwgDhX6KiPKEPZFGAhIO9EaUPZBGAiLKA
ttNCz6Y/hiwUkH5xBWJzjz6Uzw0kc3wEURLgaWmo1j59IPMGIoriTJG6cyxCKlbgCUmc1O7T
BzJvIHfv3p0pUtdPUuAKR2gfRuB5Dn0g8wKytbXlx2Ix3Lp1C5FI5MKReu1UhpIvQKnzcMQy
9Ep6dE93cqHR1yccQxgQLl8HX85Bqh2gJ5pgGgIpav+j32o+JZBi6huYyiuUK2WIu0/D616z
M4Ki2if0gXxKIFl9K/CujoKpey8c2NXfdv23oQhWkj6UTwWktLeLmrAdpmvZGAT+GGK2BM91
w+7LLSi+xZXQq1u+c8DTr/WPDYS1AvmXs3ksMx9B00qFC11yWYStiOi2zjZAVBtxeG2Xfkv5
2ECYGroO0xHQaChgW4I0lQ/vyyUetiyOeV15sK6MftV/RCBLPz7Hq+1XEMur4bVOx4EiS8GC
VQVcTvS549NR3rXCn/2qGENRX/FT4j8RO/2aPpxpQFRVHVWQLL9/nXwcSKMbC1YZM7C0HZjx
x9g5eDnqyhyn5FvqEUytGeY39E2/b9hvrjbqL+hDeR+QO3fuIJFIgC3nXr9+fWJFvR2p5w4y
iG7EoWs6JOMXuC/+5FstM2wlwzxWrQZTPYPi2GUMnB59KBcBcvXqVSwvL4PthL958+bESmL/
/ADK+WyvtIsUl0Q+/xtajWPIgQvcKO9CVc5bmGsaaFtO2IWF3ZohvFN2UX+O8aiedWsjoC6H
SmMD9MeQC3RZoryLRHID6Xww2ys9RdU6AFo6hJPzChz0z1pENSuGsUlfab6zKUK3s2A2TBe0
ZxgHUtBWoLaPYXa+3M0UcwFyL/Ma8cNNZPMVZMQsNOdp4E1VMdCqUPjzCnaUM2+rXjkbp5x2
4JUZCXSc6swVvFX6BnntKegDmQBENb5Hp5NGJLGFvb0UFP0fvtPPo93Twder/kn+MGwVtlpH
TNwKn1EEHVUuj5/q27D7TnifxS/MCZhFnLkdPDkAfSBjQLilH9DMFWGKOey9PsKdo5/9aOEx
Mvoz7BezvngSR2/9v2Ari0MPrN/rw8ieL/mKwfJv1syh1Cz7zowtxnCKYO40G3PO3Ol/IV76
K0hH6o4golOXkT5IBtMotfCe2xGgNFbQ7fFQudfgYs9gyOvBolcPekNFMfdr0CoORuWwfMy4
Fo9TPRUsC++Ovs/tyWg5qVHejsMF5TRHads+feP3sFYjtQ5CKxvrYGPQJGfhi43UzwZuL5hC
eQWeE8DLQYXzwbRJtwqjmYLR4GDze2g14zBNM3SRO46EprkPr5iDV8gEebnAFziGJQfRfquN
pv0ycJV3oItRuD0JLXsHmp1Bp1cHa0XjQJwASLfLyuQn7IbZgNU5b3X5wFlQ2yfB+v8uvkgg
P30XRzV1nj5c+Zsv5RKhnSaXQhumj7WIL9uF0Mrajp/hn4+e62+tofeff/tePBoamzW2JSE0
I/faF/cDL0t45jMTub9DV34IWxEzNm4NP2v6MurSeTr4jOCaPylvw1oObdI9vfEYkvLt1LyO
lw9N6exBdCIYpkU7AnZtmDa6q2/kLbcmL/y9A2Q8On9fpM7eZS8UCnP7d7HyXNelX94kIMMI
fVqkXiqV8PDhQ7Al33nY+vo6VlZWSJVXq9UuBuTGjRvhzvdpkTqjq2na3P4xFMsbnzP8oDHk
Il3aLGI/zHGc8CWheZTHxI4ICcekOR0NMtwWxU64GJ5y8Uc0fCFq2tElMwO5SJc2i9gOF0mS
8OjRo/fucJlVt2/fnrqNaVYNt0U9ePAA8Xj8g8pjL0RNO7pkZiAX6dJm0f3790MQ7CWhK1eu
fFB5w21Mly5dQjKZnLqNaZbyhtui2OcPKW/4QtS0o0voH8/0pcQh9EUfCH0g9EUfCH0g9KuA
PhD6og+EPhD6og+EPhD6og+EPhD6og+EPhD6og+EvugDoQ+EvugDoQ+EvugDoQ+EvugDoQ+E
vugDoS/6QOgDoa+Z9X8MrHoeNqHLDwAAAABJRU5ErkJggg=='
]

{ #category : #icons }
RTGrapherExample >> exampleMethodSizeIcon [
	^ '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
igib9zQAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleMethods [


	| methods trachelMethods b ds |
	methods := Collection withAllSubclasses flatCollect: #rtmethods.
	trachelMethods := TRObject withAllSubclasses flatCollect: #rtmethods.

	b := RTGrapherBuilder new.
	b extent: 200 @ 200.

	"Data set 1"
	ds := RTDataSet new.
	ds interaction popup.
	ds dotShape circle color: (Color red alpha: 0.3).
	ds points: methods.
	ds x: #numberOfLinesOfCode.
	ds y: [ :m | m getSource size ].
	b add: ds.

	"Data set 2"
	ds := RTDataSet new.
	ds interaction popup.
	ds dotShape circle color: (Color blue alpha: 0.3).
	ds points: trachelMethods.
	ds x: #numberOfLinesOfCode.
	ds y: [ :m | m getSource size ].
	b add: ds.

	b axisConfiguration withThousandsSeparator.
	b axisXTitled: 'LOC'.
	b axisYTitled: 'Size'.

	b build.

	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleMethodsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEZUlEQVR4XuWczUtUURiHr0Wt
gty0aJF/QK78B1oEItFGiqTATRAtBHc6fsTo+AkqSoMZigsDUQllFCF1xHFUVFqIo2AghPnt
oPhtI/n1s3mP3MHKcQwc53p/DxxmmHu4yn3uOe9577nnaMfH/BgJjf8S8Avhh18IvxB++IXw
C+GHXwi/EH74hfAL4YdfCD/8QviF8MMvhF8IP/xC+IXwwy+EXwg//EL44RfCL4QffiH8Qvgx
l5CpqSns7OxgdHQU/DoMIKS6uhpbW1soKipCfn4+Kisr4fP5wC8kQjQ0NMDpdCI5ORmNjY0o
Ly8Hfwvhh0OIxIbl5eXAHS9dk/wm39fW1vhjxlULKS0thc1mQ15eHvr7+5Gbm6t+k2Pd3d1/
CJmenlbFqMzNAVKurRCPx4P4+HgVqAcGBjA7O4usrCz1W09PD7Kzs/lbSKRiyMHBAf/F5w/q
/EL44RfCL4QffiH8QvgxqxDJxtfX19WQd2VlJZC1Ly4u8g+DI9VCXC4XRkZGUFVVpbL2lJQU
dHV1/SPE6Jm6KYTs7u6qC5+WloaMjAyVtff19aG4uJi/hUQyhgDgF8Af1PmF8MMvhF8IP/xC
+IXwY1YhMocuRc/a9Ux9ZmaGfxgcCSH19fUqEZTvMocumXp6ejr0eXX+TP2KhchjExGRk5Oj
5tAlU5eXHfgzdf5MnV8IP/xC+IXwwy/kv/D5AI/nesUvuhaC3l7wC+HHGEK2t7dxdHQUmEfX
M/WFhYWw3qXwz1RifBz8Qs6gpqYGJSUlaG9vD7wJX1BQwJ+pR0KICGhra1MCMjMzVabudruV
lLOSx3AnkHrL8d8d4M/U+eEI6ka+200vRHqb3clZqK5HyuvXgMmWxhlWiOrrW1rUxUZrK1yP
coGmJsBqBSoqAKcTmJ+HPyidfPpLOP6P1dVVdV5ZBSafw8PD4BQyNoa9cju8rm9AUhLc918C
sbFAQgIwOAhMTl5Jy+jo6Aism7fb7aBrIXKh9z47sPTmHX7euQerlgdERwMxMUBcHNDcfKVd
lMVikZHhcVlZGWR+R9bRHx4egkKI6qZSU1ESZcErrQEz2gM81now//Qt5rI/Ym7gB/hHWZfE
6fXqZ7G/v4/WZ5/wUJvADe0Qt7Q9PL/pwPvU7ycBfGgIej0pof5epOpdGyF6lh7s+ETXV0RF
Abe1X3hy9ws+vLCpruLv0tnZqcpZx8Jdb2NjwzwtRF+vHuy4PPeSEuo8Rq9nmhgSqksTZFsO
CahLS0vn1tUXCslmBaHOd5FFRPp2IPKgNNwPRg0jJFSXJni9XrULxEWGnzIi0t8JC8bprT+s
/vzmvHp1dXXY3NxEbW0th5BQXZrQ659ckrxAXiPy9+dB6+oLhRITE4PWO731h8PhCLotlF5P
WqW0uMLCQvA/OiGCXwi/EH74hfAL4YdfCL8QfviF8Avhh18IvxB++IXwwy+EXwg//EL4hfDD
L4RfCD/8QviF8MMvhB9+IfxC+OEXwi+En8vlN9AkwQP3P1GfAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleMultipleCurvesStacking [

| b points1 points2 minY maxY ds1 ds2 |
points1 := TRShape withAllSubclasses sortedAs: #numberOfVariables.
points2 := TRShape withAllSubclasses sortedAs: #numberOfMethods.

minY := 0.
maxY := (points1 maxValue: #numberOfVariables) max: (points2 maxValue: #numberOfMethods).

b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds1 := RTStackedDataSet new.
ds1 points: points1.
ds1 connectColor: Color blue.
ds1 y: #numberOfVariables" min: minY max: maxY".
ds1 stackX.
b add: ds1.

ds2 := RTStackedDataSet new.
ds2 points: points2.
ds2 connectColor: Color green.
ds2 y: #numberOfMethods" min: minY max: maxY".
ds2 stackX.
b add: ds2.

b axisXNoLabel; axisY.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleMultipleCurvesStackingIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEnUlEQVR4XuWbX08TSxjG/Wrc
8DHgQ3DDXUONOa1GUqIo2iAXBVvbGDiBHKyQUAgeaJEQaZAARkMEqiD9A8tuoe2z7ju0pkGI
Wtvuts9vs5kSNu3M/nZ25p1395Zp8uMkbvGfAn4h/PAL4RfCD78QfiH88AvhF8IPvxB+Ifzw
C+GHXwi/EH74hfAL4YdfCL8QfviF8Avhh18IP/xC+IXwwy+EXwg//EL4hfDDL4RfCD+tL6S7
uxuRSARerxfyt9vtRqlUwtXjdF2H7Cwn9eLiArYIgcX+/j66urpUBY6OjpDNZn+qzNbWFg4O
DmiEjORHYBgGmi6k8qPSK+SquKkS6XQaTLedZ3gGR48hTEJKuNz4hTgEP/xw/CyLScgABviF
OIUNbKAl4hAWIROY4BfiFCTOmtVn+YU4BTfcKBaL9gmJxWIqCOzo6FCVCAaDWFtbg8fj+alS
EhS2c6Q+gpG6ta1mIeFwWAno6elRlVlcXFRlIpGgitSj+Whd21WXW1b12o2maWC5ZckKxdv0
W+cJYR1D/jbm4BdSRzaxiSKK/EKcwnM8b0ib+IXUwGR2smHt4RdSA768j1+IU4gj3tC28Av5
Q4IIOlfI9vY25ufnsby8rCoZjV4fJKVSqbaI1NNIN2RmVTchsnyysLCA3t5eVUm/34/rAsN2
idTruUTSECEul8tcWlqCLJtIL+nr62vbnLphGGaykHS2EJYxZBjDmDamUSgU+IXYQSaTMe/h
Ht5k3yB6Fm1q3fmFXB0XEcP7k/e2/T6/kCsykkjaWld+IWVeZ17bLoNfSJlHeISz8zNH1JFO
iOS9X+ZeQh5oC5wFMJwfdtTFUrOQlZUV1ZCBgcskzd7eHuLxOKS8eqzdOXV5tHM0NWpO4nKV
9vz8XJV/85S644RI7nx9fR2dnZ2qUZXlk/7+fkdF6jJQy9Yqs7yahfh8PszNzZmyS8+QUq64
oaEhW3Pq8oqE5LplXJhNzyKn5VoqBmq7MWTCmMChftiyKwNtJeQBHtgmQnqmTBg+fQK8Xu3a
RVYaIXIiXFmXbTKs7AIikYI1Tur8j5IKHnhQmTk1g8pvDQ4Cfv9Xq2cA/Lcsi2/Zb/jP2prZ
G0IhIBzO8eTUq6/0fD6P6pnTR2u7q93FK+0V5CE1a1UW9b7qBXlXUq7627cNBIMnCASAUCiH
x491ruX3EKztJIRAeZvKTKly/GIcKSP1W98hJ1OSSeXPZiWHIUvqFU5PT1H5/+hoEVbiE0+e
aOrEyx6LHaNlZ1mVPPrMzAw2Nq5/g2hnZwfHx5eNrJ59yMlLWZtX8+Kp/hS/6iHV0bWVpMTD
h4fqBI6Nlays5RfcuQN8+PBnQpqRdGqakN3dXVQaZ6VzISndm45bXV2FlIkvCfyTHMf9zX/x
/+47a1DU1e1gbExXn6ens6qUfWoqo8pwWMeLF9qPYz9/TqnvcvJuWw8ZtKYa5Uj9xhdWUMbk
xxljCD/8QviF8MMvhF8IP/xC+IXwwy+EH34h/EL44RfCL4QffiH8QvjhF8IvhB9+IfzwC+EX
wg+/EH4h/PAL4RfCD78QfiH88Avhh18IvxB+fsl3T+IO9OMHW7cAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleNegativeY [

| b ds |
b := RTGrapherBuilder new.
b extent: 200 @ 200.

ds := RTDataSet new.
ds points: (-3 to: 6).
ds y: [ :v | v - 4 ].
ds x: #yourself.
ds connect.
b add: ds.

b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.

b build.

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleNegativeYIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD1ElEQVR4XuXcS0vzQBiGYf+j
P8GVW5cqCCriwqW4EF24EleiCIJ4ruBho9YzIiqIooLn8+GNfYKFWmvTfp+mk7kfCLUY0zJX
Z5J3JrUqCPhxKVX8JuCD8MMH4YPwwwfhg/DDB+GD8MMH4YPwwwfhhw/CB+GHD8IH4YcPwgfh
hw/CB+GHD8IPH4QPwg8fhA/CDx+ED8IPH4QPwg8fJJuNjQ3r6uoy/dzc3Gzv7++Wv8/r66s9
PDzY8/OzxfGeXl5eDAtimczNzYUNcH5+bldXV98a4/7+3qanp+3y8vLPG0ofiLOzM8MPWfpU
Pj4+/tgQy8vLsWAUew/8c0iMIJXG4IM4hsEH+czNzY1p419lOQCinnF3d2f8y14HQFwZpvgg
jmJUFGR/f7/s/YqBlHM8FZdRGKUezxuQ9fX14PDw0LQNDg6G28HBgbW1tVl3d7fNzMyEv1tc
XAz329vbs9HRUdvd3bXs3+Vu2f2iNu2noi9qP70/5JCVTqdte3vbNH2i5319fSrcbXZ21n67
Und1mKo4SEdHR9goQ0NDNjw8bLmVuh7f3t6stbXVxsbGLJVKWV1dnTU2Nlp/f/+3xsxCKu3t
7QUbe2tryzo7O0OMhoYGGxgYsJ6enoL7jo+Ph9M4mjvTvJr3IOoROzs79vT09KVn5DeKGkMo
ej4yMmJCqq6uLtpAS0tL9lPP6O3t/XKslpaWgvvq9ysrK6Y5taOjI0P0EM3aRs2m5g8tqhWK
ndR1vEL1xPX1tV1cXISzxLmvWez1NWRGzavxL3v/4bI3CecMDEgSMbwFSSqGlyA6ZyQVwzsQ
9Yw4VhQRIBMTE5aZrggvg09PTwuuqWeq7B/X1JM8TDkHMjk5aaurq3Z7e2tra2tWX19f1pq6
LxhO9ZCmpqZgamoq2NzcDCv0UocsnzASfw7JFn2BR0ksiG89I9EgvmIkEsRnjMSBaJbYZ4xE
gahnaF0j8DxVScFQz4jjVlI+yGe0cqhqXMXf/Py86ZI2FyOqUueD/FJUmdfW1lpNTU3Y0Lq5
QQ2vZdbcE3icd7/ze0gmqtIFoUfNa2kZ9eTkxKIqdT5IjOeMqEqdD1JBDD6IYxh8kJhTylcC
+CAx9oxSvhLAB3FgmOKDOIrBB/nj5N8ZqNs2VYdoKTdTi5S9ps4H+c/kfg9ca+oLCwvh88xS
rmk5Nz+q1I+Pj/mVepyVerYnaIokgIb/v074IPzwQfgg/PBB+CD88EH4IPzwQfgg/PBB+OGD
8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfhg/DjRj4AuTQugM8hpswA
AAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> examplePointAspects [


| b ds |
b := RTGrapherBuilder new.
b extent: 200 @ 100.

ds := RTStackedDataSet new.
ds dotShape rectangle color: Color red.
ds points: (RTShape withAllSubclasses sortedAs: #ageInDays).
ds y: [ :c | c ageInDays ].
b add: ds.

ds := RTStackedDataSet new.
ds dotShape circle color: Color blue.
ds points: (TRShape withAllSubclasses sortedAs: #ageInDays).
ds y: [ :c | c ageInDays ].
b add: ds.

b axisConfiguration noDecimals.
b axisX.
b axisY.

b build.

^ b view
]

{ #category : #icons }
RTGrapherExample >> examplePointAspectsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADx0lEQVR4XuWaPUtjQRSG82vE
znI7PwohpT/BdQsLS9E1FkaUVbSyE0H0F6hBLRZERQMJWqVQ1kYTxfgBalZFC8X37swNyYqb
3EQ2388DQy7cQ7iZ586cOTPxOQ6fWsLH7wK+ED58IXwhfPhC+EL48IXwhfDhC+EL4cMXwocv
hC+ED18IXwgfvhC+ED58IXwhfPhC+PCF8IXw4QvhC+HDF8IXwocvhC+ED18IH74QvhA+fCF8
IXz4QvhC+PCF8IWUg8vLS9nP+/t7PT09ycLv9ioKiUQiisVi6ujo0N7enlZWVv4RkkqlnKOj
I/ez0qRSMs+Ubva6qcm8MQsL0vGxNDIibW2lm7luCCHz8/NaWlpSf3+/Njc3FQ6Hc/6weDxe
0ZFjHkO9vdLpqRSNmtb+XeYB5QSDjhYXpZMT99rZ3k43e03KIaUQ8r7/7JseDKabzyclokl9
9SfV4os5v39GFPryQ2pvT4+C1lbxk3oZhCwvS8lkun28J/P99s2v1Jte80k9kUjo4eFBb29v
NTFloZe9Gxsbmp6edjt8bm4uZ1KPRqNVSeo4IX6/3yxStjQxMaHR0VGFQqGSjxCboLNTUw5q
fZqq2xzS3S3t7ko9PVJfn3R2JrW0yEiWTJnzt/Nt8/mc7DVfSGmF2KWpXaLmu6+2NrdWcCXw
pyxvXl5e9Pr6qvPz82zFzk/qVRSyv7/vdvT6+rp2dnZMXRB0/iepu1WzHRENNCoqKmRgYEDb
plIbHx/X9fW1AoHAp0ZIc7OUlWAKOPNl4o+QKuSQu7v0/lI9JeSGFmL3ksLfFvlCysHFxYVs
Ms8k9mKFuFsd/KReeiYnJ92OXTabTbnu8yv1CguZmZnRnUkK5swjpxBb0J3YEcE/vGqs3V6+
kFILeb/twRdSXpLmkMLrfr7p7CPPz881HVcXQq6urtyiMN99m8zNFr0TCPzS2Fhcthi0xWSu
Zs7knXz3yhlnFx0NI8QeSo14/EnAJnO7NC4mqdu4Ypfa1YhrmBxSaErLYE8eC8U8Pj66MTc3
Nyom7vb21jPu1Gw3f+YZ615IoSktgz0Czpw8epGJscvtQnG2RhoeHvaMs0Xt1NSUVldXGUIK
TWnvpzZ78lgorrOzU4eHhxocHFShuIODA83OznrGdXV1aW1tTUNDQ8JMWXz4QvhC+PCF8IXw
4QvhC+HDF8IXwocvhA9fCF8IH74QvhA+fCF8IXz4QvhC+PCF8OEL4QvhwxfCF8KHL4QvhA9f
CF8IH74QvhA+fCF8+EL4QvjwhfCF8OEL4QvhwxdC5g9sF+trm6wBMAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> examplePopulationUSA [

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
RTGrapherExample >> examplePopulationUSAIcon [
	^ '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
XcWjA7UAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleRandomCurves [

| b ds |
b := RTGrapherBuilder new.
b extent: 300 @ 200.

5 timesRepeat: [ 
	ds := RTStackedDataSet new.
	ds noDot.
	ds points: ((1 to: 500) collect: [ :i | 50 atRandom - 25 ]) cumsum.
	ds connectColor: Color green.
	b add: ds.
].
b axisX; axisY.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleRandomCurvesIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleScatterPlot2 [

	| b ds |
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

	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleScatterPlot2Icon [
	^ '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
VgAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleScatterplotWithHighlighting [


	| b ds |

	b := RTGrapherBuilder new.
	b extent: 290 @ 200.
	
	ds := RTDataSet new.
	ds interaction popup.
	ds dotShape ellipse size: 15; color: (Color red alpha: 0.3).
	ds points: RTObject withAllSubclasses.
	ds x: #numberOfMethods; y: #numberOfVariables.
	ds dotSize: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
	ds highlightIf: [ :c | (c numberOfLinesOfCode > 2000) or: [ c numberOfVariables > 10 ] ] using: #name.
	b add: ds.
	
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
RTGrapherExample >> exampleScatterplotWithHighlightingIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleSimpleCurve [

	| b ds |
	b := RTGrapherBuilder new.
	b extent: 300 @ 300.
	
	ds := RTDataSet new.
	ds dotShape ellipse color: (Color blue alpha: 0.5).
	ds points: (0.0 to: 1.0 by: 0.05).
	ds connect.
	ds y: [ :v | v sqrt ].
	b add: ds.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleSimpleCurve2 [

	| b ds |
	b := RTGrapherBuilder new.
	b extent: 300 @ 300.
	
	ds := RTStackedDataSet new.
	ds dotShape ellipse color: (Color blue alpha: 0.5).
	ds points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	ds connect.
	ds y: #numberOfMethods.
	b add: ds.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleSimpleCurve2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAE4UlEQVR4XuWdS08TURiG0X/g
kqU/wB/gzgRI+AdqXBhNGm8bI7Hh1rQUEWgkLlyQsGFhAomRkEDBhAINF8PFGBIXCCEpLChI
gF7Tcil963ynjqKW2o6lM/q+yclwyZx853vObb4zc05FJsMvK6mC3wX8QPjFD4QfCL/4gfAD
4Rc/EH4g/OIHwg+EX/xA+MUPhB8Iv/iB8APhFz8QfiC/Kx6PY3d3F/JzMBhU152dHfC70yQg
Ho8HXV1dmJ2dhcPhUCBcLhdaWlp+grK+vp5ZWVmhcebWFvDqVQplBbK0tISamho0Nzejp6dH
gVlYWIDb7cb09PRvxmhQqFpOMpmEpccQNiDpdJofCP8six8IPxB+IPxAitbJyQn4gVhIgUCS
H4iV9OlTHNEo+GdZVlEsFuNvIVZSVGse/ED4gfADOUuRSIQfCD+QTDb8LleJ2xwfH+cNv/MD
KQMQCb/39vZCDFhcXMwbfp+fn6d5yg6Hw+UHoofft7TgvySbzcYffjcTCP8Ywg+EHwg/EGMK
hUL8QPiB8APhB8IPhB8I/6D+n7SQDD8Qa7UQfiD8Ywg/EH4g/ED+oEQiAdHR0ZEyIJVKQRI/
EJOASHR3cHAQfX19yoDV1VVIygGDKvxuGpCJiQnMzMxgeXlZhdzHxsZU4p9l8T+H8APhB8IP
hB8IPxBj4n8NiB8IP5B84n9zkR8IPxB+IP+Qrl+P8wPhn/byA8mpYBB4946/hVhGIyOA1wvz
gMgAtrm5CT30zh5+9/limj9MAjI1NQWn05kZHh7OG34PBAKYm5ujAOJwxEpSTkNA5FuQhoYG
yJvw2nrHmeF3WcRiaCGfPwMdHSYC4R9DfujNG+D27ahWMcEPxAqqqwtDm+2WrIz8QP5CN27E
0dp6XNLy8QMxoA8fgEePonj+PFXysvEDKVI3b6bx+HEI79/jXMrFD6QIDQwAL19GzrU8/EAK
0JcvwK1bcVRWnuDjR/ADMUtv3wI2WwrV1Qm8fo2ylIMfyCm9eCEAkqirC+HOnYiWknC7UVb7
aYFoUR88fRpS6eHDMJ48CeH+fUCgmGnXfw9EpqhOZ9b5TU3i9Kzz794tTTCQH0hGFoIAlyvr
aLneu5dERQVw8SLU9cIF4PLlI+X4Bw+i2sMbIOsV/0K3aRjI6c1mztp4RjaFXFtbw1kD5rNn
gMcD1U+LY3UnX72adbDuZPldnGu3h9RV+nhxsqSODuPdjNh3eHhYMlClyM8wEH2zmVybzuiS
8PuVK4lvtTZ9yslpXLqUxLVr/u+pujqbqqr8GiQ//H5/5tfk8/kgIf9c/zOSziM//XCCsgPR
N5uZnJxEW1tbTiMODg6wt7dXshootc/q+emnRlhuDCmkSytU+/v72N7e/p6H1EJZrTTy2o3s
7yWrm/KxkeQhf5P9v6S72djYgFH7dHv+9viOcwNSSJdWiNrb29HY2Kjul9XHzs5ODA0NQU4h
0DdPK0ayv9eItgAu3Yvdblf3C+zx8XH09/cbslMW53R78h3fYSqQQrq0QiQfBXV3d6O2tlb1
9ZJnfX29NqC3GspT9veSccPr9SqH6TaOjo6qPb+KHZTlXqkwYo90V386vsP0aS+/+IHwA+EX
PxB+IPziB8IPhF/8QPjFD4QfCL/4gfAD4Rc/EH4g/OIHwg+EX/xA+HVaXwHyHHqxNmVDtQAA
AABJRU5ErkJggg=='
]

{ #category : #icons }
RTGrapherExample >> exampleSimpleCurveIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD/UlEQVR4XuWdTUsyURTH+3JC
Wz9JqwxaWL5BuOgL2BdoEYEICYkShRotbOlOAivd+N74fubxDPgw9KjP6IzOuff/BxmY4qLz
m3PPyz1z58g08SVJR/iXAB8IvvCB4APBFz4QfCD4wgeCDwRf+EDwgeALHwi+8IHgA8EXPhB8
IPjCB4IPZL36/T7x8fPzk/AvpQAgyWTSAtFut6nVav0DZXHerFar1hFFZ2dD8gVIpVKhQCBA
5XKZLi4uiLXq/2q1GoT19Ho9MgyDxPsQ3YEMBgO6uhqQMk5dVyAvLwaxVSgXZekGZDQaEQcz
uRyRkmGvLkCm0ymdnPRJ+TxEdSDZLFlT07qgBR/IgSOnu7spaZWpqwikWDSIoyflEkMdgXQ6
nb05bHwgWyga/aHhcOj7d4UHwhD2kU/gA9lSHDWFQj1x3w0SCCd2nOBJvFF2BrIsudfrdep2
u8RH6UAmkwklEgPRU+hOQBqNBjWbTeuHcYWTf2gqlVpZfl9Ug0WU3/mmmc1m4gOMnYDM53MK
h8P0+vpKsVjMAhKPx0VaCDvtWMxQJvTW2odwTqFaUqolEHbYkYihZMlGOyAcQangKyCAnJ93
lS/1awFkPB57sp6ND8QDPT8PiYGYmkhpIFyD8rMyiw/EplV9YPhAfAISj/e0bS1SCgiHs36t
5OED+aVcbqRNJKU8EAbx9DSGaEl1BWRZ8V1XevcCCE9Rh2rBURrI5eXlol4UsS5UKBRaecHc
lt8jkS7cYw47A8nn84vFnoTV/c5g1iVnu1oIr1+YgBLpQ3SPpJQCks0OoZ/GEgWEV/cKhRk+
EAlAOJJCyDOUAYLqxEUCOT3t4cOQAgR/mhIGREKDMz4QfL8hD8jt7QAfhhQgHOK+vU3wgUgB
omJHoXggy+737+/vjSX430C4CIlUTj8IEHv3O6tUKq3sfudGBP6bvSFB0tNK2gCxd78fHx/T
4+Pjyu53tgS2kKVF4OccwnzI9TW+dYgCIvUxMkgg+I5cGBDedQ7/cgsCgj9d4VsIPpBNQHi/
KfzLLQQIPgxhQPCnK2FA8B06voXgA9kEBD8pPBCQZcV3097vHx8fnsLwukApbTxPut/X7f3O
56LRpvnw8ECFQsH04nN/f296NdY+xisWi/5YiL37fd3e73zu6+vL0ymLx/PyjpY23l59iJMp
zamcrlBuOx4vmPFuRm7HY3nx+o69AXEypTmVfYVyMSXQ+/u7tS2UF+MFg0HLijOZjGsg/3t9
h69AnExpTmVfoby5uaF0Ov0XttvxeKWTx3MDmOX09R2+h734wgeCDwRf+EDwgeALHwg+EHzh
A8EXPhB8IPjCB4IPBF/4QPCB4AsfCD4QfOEDwZddfwAbTfhlYJ+zmQAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleSimpleValues [

| b values ds |
b := RTGrapherBuilder new.
values := #(5 6 7 -1 -3).
b extent: 400 @ 300.

ds := RTStackedDataSet new.
ds interaction popup.
ds points: values.
ds connectColor: Color red.
ds y: #yourself.

b add: ds.

b axisXWithNumberOfTicks: values size.
b axisYWithNumberOfTicks: 6.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleSimpleValuesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEeUlEQVR4XuWdy0srMRTG/evc
ubkLt/4ZLlwI4srrC6XgRgVRXAiCouLbIkWsIL6QqqAot1gfqFXRatXj7QkdL9zJTMe0M570
+2BwwDkk5jf5kpOEsebzE1+SVIPfBPhA8IUPBB8IvvCB4APBFz4QfCD4wgeCDwRf+EDwhQ8E
Hwi+8IHgA8EXPhB8IPjCB4IP5J9ubm6orq6O+L61tZXm5+dJF/j8/Ex82fqH5/N5sqaHjIyM
qMq2tLQQQ9E9c3h4SOfn51YCoY4OysVilMvlyBrL4jfIr8Lck6yCMD1NNDlJlMl81Zt+/6aq
GUNsAELpNNHUlAKh/f3gID6QqCyJr5LPPT7iA4nSkgLFCbMta4HwGFfKkgIBEWZbVgKp5CxJ
mm1ZA8TUkmyzLdFAlCUVQYRazsCAXCANDQ2qcvF4nPr7+6m9vV1bWU4Kw8rU1SypqyuyRpJk
Wy4gVBA39MvLC42NjRFn5Hz//3MHBwcVzdTDtCSbbMsFhAdKnsG8v7+rCnr1gnItq1KzpGqz
rR8bQ+7u7rQ978eACLGtql46sdG28IEIsy18IMJsCx+IMNvCByLMtvCBCLMtFxAnM19cXKRE
IkFNTU2UzWYpykwd2bZcQJzMfKqQsG1vb6ufusBKZ+r4tuUBhN9650QGL6OgWdZP2xb+GCLM
tvCBCLMtfCDCbAsfiDDbwgcizLbwgQizLXwgwmzLBeTp6YnGx8dVJRYWFmh/fz/yPXVk29L2
kO7ublWJ5uZmKlzaQJtPv0u2LReQy8tLBSGZTNLKysrX3jqqZUVtW/hjiDDbwgcizLbwgQiz
LXwgwmwLH4gw28IHIsy28IEIsy0XEM7OnQbnXOTo6Ag6U4/atlxAXl9fKZPJqIuBjI6O0sfH
R+in3/FtywNIb28vra+v0/LyMm1ubhJ/PEAXeHx8TA8PD8aVu7q6sjLesa1yy7++vtbGG48h
DCSVStHZ2ZnRtbOzY2X8n4IzVKL83d3dygLhMcbvVErJN60oG+PZtsIq3wjI3NwcMRC/5Xk/
8dvlTCC+Gx90e8CvISYmJozjWanGxrLi0+m0Z/y3gXB3eyzMNhiI3/K8nzY2Nkou7/spyPaA
n3p6eozj2Wp+1daWVX5nZ6dnvFEPicVitLa25rs876cgy/teCro94KW3tzdiIKbxrELcZ7K+
3iieDyH29fV5lo+fGJqOASF9AQIfiKGyt7eUGxqi0IHwQevZ2VlVEGfpp6entLq6SviZukdP
KY4HoQA5OTlRA3ZbW5sqxMnSdckhaqauhbK0RJRIUCg9ZGtrSw2anK0zCG74mZkZwresElDu
74mGhwl/DKkyC8MHIszC8IGEaWHFr7viA7HYwvCBCLMwfCDCZmH4QIRZWI1XY/PiF9/zUrvu
GfxMvTwLy8fjFAjI3t7e1366s9TuBQQ/UzfX/cWF9quq2h7i7KczFF5qx2++6IT//0PwgeAL
Hwg+EHzhA8EHgi98IPhA8IUPBB8IvvCB4AsfCD4QfOEDwQeCL3wg+EDwhQ8EWX8BBR3Ll9qy
s4kAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleStackingX [

	| b ds |
	b := RTGrapherBuilder new.
	b extent: 400 @ 300.
	
	ds := RTStackedDataSet new.
	ds points: #( 5 6 7 ).
	ds connectColor: Color red.
	ds y: #yourself.
	b add: ds.
	
	ds := RTStackedDataSet new.
	ds points: #(1 7 10 4).
	ds connectColor: Color blue.
	ds y: #yourself.
	b add: ds.
	

	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
	b build.
 	^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleStackingX3 [

	| b nbOfCurves normalizer |
	b := RTGrapherBuilder new.
	b extent: 400 @ 200.
	
	nbOfCurves := 3.
	normalizer := RTMultiLinearColorForIdentity new numberOfColors: (nbOfCurves).
	1 to: nbOfCurves do: [ :i |
		| data ds |
		ds := RTStackedDataSet new.
		data := (100 to: 1 by: -1) collect: #atRandom.
		ds dotShape ellipse size: 0.
		ds points: data.
		ds connectColor: (normalizer rtValue: i).
		b add: ds.
	].

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleStackingX3Icon [
	^ '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
TkSuQmCC'
]

{ #category : #icons }
RTGrapherExample >> exampleStackingXIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEZ0lEQVR4XuWdSU/jQBCF8+f4
KfwFDhxYDnDIhSCO7MsJBEisIgECB9ZLkNhBCA5JhmhYBJFAYSmPu2eAjGwn3Xbb6fZ7kpUQ
SBH1567qV25MwrLwpZMS+EOADwRf+EDwgeALHwg+EHzhA8EHgi98IPhA8IUPBF/4QPCB4Asf
CD4QfOEDQQPy9vZG7+/v/GBfFwoFwh+mBgLZ39+n8/Nzftze3lKpVHIAeXx8tOzv80cUbW5G
c2I6gDQ3N1M6nebHzs4OtbW1uX6Qm5sbmJkzMUH0+Ul0ckKkbQ1BAdLd/QOBgcEH0kB1djoB
rK2FCwUfiIf6+twHfmgIH0ikYrVifr72oIcJBR9IlfJ5oo2N+oMdZtrCB/JPW1tiMMIu8PhA
bGWzRIeHcgN8dET08aEeCjwQln7KZX8D29uLD0S54Qu6AFBtFmGBVBu+RkLFB+Jh+IKmPXwg
ig1fEKn0JQ4gT09PlLcX5H/X5XmKCxARw6cDFNcZMjMzw4O3tLS4/hLWdt/d3TWm/S5q+HRI
W65Azs7OyB5w6rSTbaVSMbr9Lmv4Gl3gY11D/Bi+IFJhFmMLZHW16Nvwualg0xX5uVQKH4jn
7AjyfmKFh1XqZJJfLhR9H5shQcxiLIGMjfkbEFpaIspkOIhG1ZLYAbHXIHRxIT4gfAYsLvLT
WodVV+yA1MvhflORrAYH8YFYuRxxhZWKojCLsQIyPv4zAL9Zj4RZc8WpSG6lBwwkvfIZSSoK
e4FhNJDqVDQ8TFrWNFmzaBwQPgMWFv5LRf39pLUn6umJERCRVVFQExi2ZMxiwrmOr3xvsK61
8z1MIDKrIr8mUNda4gAyNTXFN1qz53Z7nR4eHlx3v6tuv/+am5NeFcmawEZLxCw6gJzYA9La
2srb7+3t7a7rel2KetBGXtQaGPABxJRV1sEBeZ4sOquegzcWSLUJNEn1zKKRQOwSZ/QWpFoF
3kggIyNmA2FXMb3MonFARAqjCZqcLMYDiO4mMKiMAmKKCYQAYpoJjD2QMLb+4wMBM4GxBWKq
CYwlENNNoBIg9/f32ux+N90EKgHy1X732v3OWvLsPihurXl8E6gYyPr6+nf73Wv3Oyuw19fX
oRfaqHat49cQ/EJuFhBmAi8v8YFoAwTFBBoBhJlAC1jaAYniJmH4QPBNoJlARkfxgWgDZHq6
hH87Wgv/bkD4QPCFDwQfCL4UAxHZ/c5uRa7yg7y8vODHcwPS0dHBu7zsudfud/ZaJpOxlpeX
KZvNWiqO2dlZS1UsE+Jtb2+LzRDWfu/q6qq5+529ViwWlbbfWTyVZ6Cp8XzVEJGUJqNyuaw0
3tcVT1Xx7u7ulMZ7fX31jCcNRCSlySqZTCqNV+8PjmSVSqWUxbu6uqLj42PPeNJARFKajHK5
HDU1NSmLV33FU0W809NTYpeyVcV7fn6mvb09z3j4//IoLj4EX/hA8IHgCx8IPhD8IcAHgi98
IPhA8IUPBB8IvvCB4APBFz4QfCD4wgeCL3wghugPLJi7puVmqhwAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleTwoInteractions [

	| b ds |
	b := RTGrapherBuilder new.
	b extent: 300 @ 200.

	ds := RTDataSet new.
	ds interaction popupText: [ :c | 'Roassal class: ', c name ].
	ds dotShape circle color: (Color blue alpha: 0.3).
	ds points: RTShape withAllSubclasses.
	ds x: #numberOfMethods.
	ds y: #numberOfLinesOfCode.
	b add: ds.

	ds := RTDataSet new.
	ds interaction popupText: [ :c | 'Trachel class: ', c name ].
	ds dotShape circle color: (Color red alpha: 0.3).
	ds points: TRShape withAllSubclasses.
	ds x: #numberOfMethods.
	ds y: #numberOfLinesOfCode.
	b add: ds.

	b axisX; axisY.

	b build.
	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleTwoInteractionsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD7UlEQVR4XuXcS0sbURyGcT9a
N+5d9gu46K4bF4qaeEUEbXcFXbgQ7KItggYkSmK8LFSKsS4kbgzxLhrwjtc3nTN4gpeJTDQm
o88LQzKlh8b5deZc/sdU5XL8BClV/EvAB+GHD8IH4YcPwgfhhw/CB+GHD8IH4YcPwg8fhA/C
Dx+ED8IPH4QPwg8fhA/CDx+EHz4IH4QfPggfhB8+CB+En2CDZLNZXV1dybzf2tpyX/f29sS/
nBUCGR8f18LCgnZ3d2UhwuGwWlpaHqCk0+lcKpUqyQfV+rq0sSE+yKPE43E1NDSorq5OsVhM
zc3Nmp+fV2trq6anp59cMAeFf+cEqQ/hg3wgECUS4oOUEUSLi9L5Of8O4j+y+CD88EH4IHyQ
SoGcnJxof39fx8fH2tzcdC+4OT/36KD5IGUA6e7uVmdnpztTj0Qi7gW3549n6nNzc/yr/JYg
yWRS1dXV6u/vl1lCaWtrc2fq9px/h/D7ED4IH+SDgehuIMBPUEBSKT5IUECWltzlKz7Ie+pD
tLyMXXTkd+ofZaZuS7d2pl6ops4HKdNM3dbQzYTQ/FmhmrrXTN0x5COVeqZuauimvt7e3l50
Td0ZZPFBgtqH6G7YxacIYKeukRHxQfijLD4IP3wQPshjEKd7ePDq9hmQ7aGBvUPMGpZZFTHv
d37GNDnJH/6WBOTo6EjmyGQyun/+HEjyW9x9NUPcTKhfOztSNssHKQnI4OCgEolEHsGee2A8
mKnbR5SdqTvzSj5IKUDMrndTP6+pqVE0GpU9fzKvcGLuEP6FD1gf4nghQM7O5G5XDjwIv2Qb
JJCZGS2Hf/FBAgPi9DFjX8fyIyz9+8fHqfQd8vv7Oh8hKCDRaFpdXfxRVmBAfnyOiF8hLAPI
/Rp6oXr67empvnz6+yKMm5sbXVxcYNq+GsTW0L1q6TZra2v609vrrFlN5oo9JiYmNDo6+u7a
2i9SKDuIraGbunpHR4fnhzD/Ww4ODl70AWlt37wP8fNIKxSzRma2F11fX+cPfzPlM7Nao8vL
S/fvF9PWbG1yH7O3t/mvDfH7ue0vMJn3r/2qkTcD8fNI88rU1JRCoVDOPDbM+erqqszhp63Z
/TI8PKyhoaGi25qtTQMDAzo8PHS/NuT+z+CnbU9Pj2ZnZ9XU1FRU27KB+HmkFbqz6uvrZbYb
OSvF7qKl18KlV8wi54wz71lZWXH/bb9t7dam7e1t96itrX12a5NX28bGRvX19bkwfttWZNjL
Dx+ED8IPH4QPwg8fhA/CDx+EHz4IH4QfPggfhB8+CB+EHz4IH4QfPgg/fBA+CD98ED4IP3wQ
Pgg/fBA+CD98EH74IEHNf4EL0NxGzOIGAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleTwoStackedCurves [

	| b ds |
	b := RTGrapherBuilder new.
	b extent: 200 @ 200.
	
	ds := RTStackedDataSet new.
	ds points: #(0 1 2 3 10 20).
	ds connectUsing: (RTLine new color: Color blue).
	b add: ds.
	
	ds := RTStackedDataSet new.
	ds points: #(0 10 20 30).
	ds connectUsing: (RTLine new color: Color red).
	b add: ds.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleTwoStackedCurvesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEQUlEQVR4XuWcW0vrQBSF/XM+
+EP8C+KT1yqWvouXo1al+CBI8X6v1LsvCqK0LwqioiK9CEertitndjWHQmtN2mmaZi0YQkpm
muyveyZ79kybDINfblITvwn4gfCLHwg/EH7xA+EHwi9+IPxA+MUPhB8Iv/iB8IsfCD8QfvED
4QfCL34g/ED4xQ+EHwi/+IHwix8IPxB+8QPhB8IvfiD8QPjlHSC3t7f4/PzMFzm/u7sDv9nr
CKS3txfxeDxfHh4e8Pj4WAQkmUwasVgsf6y13t/f8XR9DUog4hXd3d1YX1/Pl8PDQ3R0dJQ0
xrVDRsL8PPjHEAtyDMjgID8QtwDBygr437LcBGRoiB+IW4BgcxP8b1luAjI6yg/ELUCwswP+
OMRNQIJBfiCm7u/v8fLyglwuBzNydxIIdnfBH6kXaHh4GIXH0RJ9uUToKmisSaSO6Wl+IKZk
mqSlpQVdXV0Ih8PY39+Hz+dzzENwcNBw82aeHkMwM8MPxC1A/p6eam0vlUqBH0g1BgyFtLYX
CvEDqbyrOjrSajzVHPi7LBeNHao5fiAVw9jb02o89WII/kG9GiDaxw6PAfn4+EA6nc4XOf8p
p64DCKJRrcZTzcFzr70nJycqWJ5W83s7ZXPqOiJ1TE5qNeDUlAeBtLa2Ymtrq+Y5dUQiWo2n
mgN/YFgNkLExrQYcH+cHUrEBdGcDVXN1m3LxBhDN2UDVHD+QSoHoXkmyuoq6Tkg2PpCREa0G
VM3xA6kUSHJuDm9vb9oMuLiY0NoeHRB8ZyF1KJOBzLrUPX9ScyASoZt59J/y6ZUA0b1GNxiE
K5JZjnjInOpa5NjW1lbyoSuJ1HV6Rz0i8roCicViKkVxlF8JL9sBioyrdHV1JQc47R0ym/v6
SgZE9xii0zvW1uCqvHvDAdHpHT4fXLcIovGAaPKO5WW4ckVKQwHR5R2pFNTMMz+Q6oFo8I6z
syzC4STnHkOdQOx6x1f8A/T3A2dnQCAA5HLg37CjDcgv3qEyxRgYAM7PvyDc3KSNRpQjQMy0
bbk96hKrWPUOiRvE+EtLT/D7M7i8tP7Lz2azyKh5ErvP8Kq+1BNAZKG1BITfETkSiUTRg8ln
GxsbxoqaSo9EIkZhubi4MOJ/Fo1AIIrm5ghmZyP/r1lYWJB6RXXKFble6tmpI0VmEjwBZHt7
G319fflIvbOzs2Q0Lp/JPhKrkbqp5+dn2792uV7q2X0OuT+aMcRKl/aTgUqtYiknc+OQnXrm
fTnxtyB1B2KlSyslcwNQYf3fNDExAVnFbqeO3+9XQ9i87ftrWCBWurRSHiUbgY6Pj9HT04Oo
xQVy4lVSzO+0Ukfabm9vt3V/nnjt5Rc/EH4g/OIHwg+EX/xA+IHwix8IPxB+8QPhFz8QfiD8
4gfCD4Rf/ED4gfCLHwg/EH7xA+EXPxB+IPziB8IPhF/8QPiB8IsfCD8Qfjmtf+Fp+dApOMdF
AAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleUsingLegend [

| clss b lb n ds |
b := RTGrapherBuilder new.
b extent: 300 @ 200.

clss := Array with: RTElement with: RTEdge.
n := RTMultiLinearColorForIdentity new objects: clss.
clss do: [ :cls |
	ds := RTStackedDataSet new.
	ds points: (cls rtmethods sortedAs: #numberOfLinesOfCode).
	ds connectColor: (n rtValue: cls).
	ds y: #numberOfLinesOfCode.
	b add: ds.
].
	
b axisY; axisX.
b build.


"defining the legend"
lb := RTLegendBuilder new.
lb view: b view.
lb addText: 'Distribution of number of Methods in some classes'.
clss do: [ :aClass |
	lb addColor: (n rtValue: aClass) text: aClass name.
].
lb build.

^ lb view
]

{ #category : #icons }
RTGrapherExample >> exampleUsingLegendIcon [
	^ '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
gg=='
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
	
	dataSet := RTStackedDataSet new 
		points: RTShape withAllSubclasses; 
		y: #numberOfMethods.
	dataSet barShape width: 10.
	grapher add: dataSet.

	dataSet := RTStackedDataSet new 
		points: RTShape withAllSubclasses; 
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

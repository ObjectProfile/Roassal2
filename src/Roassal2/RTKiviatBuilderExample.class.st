"
RTKiviatBuilderExample new installTitle: 'Colored3' 
		code:
		'
	| b myKiviatNodesElems m col |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	b open.
	myKiviatNodesElems := (b view elements select: [ :e | (e model isKindOf: RTKiviatElement)]).
	b objects do: [:o | m:= myKiviatNodesElems select: [ :e | (e model named name= o name)]. col := 	(Color random alpha: 0.6). m do: [:e | e color: col]].
	b build.
	b '
"
Class {
	#name : #RTKiviatBuilderExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Kiviat'
}

{ #category : #sources }
RTKiviatBuilderExample >> exampleColored [
	| b n |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	
	n := RTMultiLinearColorForIdentity new objects: (b objects).
	b shape circle color: [ :value | n rtValue: value kiviatNode named]; size: 10.

	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	b build.
	^ b 
]

{ #category : #sources }
RTKiviatBuilderExample >> exampleColored2 [
	| b |
	b := RTKiviatBuilder new.
	"shapes: takes in argument a collection of colors, at least of the size of the numbers of objects"
	b shapes: ((ColorPalette qualitative colors: 12 scheme:'Paired') do: [:c | c alpha: 0.3]).
	b objects: RTAbstractCircleLayout withAllSubclasses.
	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	
	b activateAxisTitle.
	
	b build.
	^ b view
]

{ #category : #icons }
RTKiviatBuilderExample >> exampleColored2Icon [
	^ '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'
]

{ #category : #sources }
RTKiviatBuilderExample >> exampleColored3 [
| b myKiviatNodesElems m col |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	
	b activateAxisTitle.
	
	b build.
	
	myKiviatNodesElems := (b view elements select: [ :e | (e model isKindOf: RTKiviatElement)]).
	b objects do: [:o | m:= myKiviatNodesElems select: [ :e | (e model kiviatNode named name= o name)]. col := (Color random alpha: 0.6). m do: [:e | e color: col]].
	
	^ b view
]

{ #category : #icons }
RTKiviatBuilderExample >> exampleColored3Icon [
	^ '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'
]

{ #category : #icons }
RTKiviatBuilderExample >> exampleColoredIcon [
	^ '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
AAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTKiviatBuilderExample >> exampleSimple01 [

| b |
	b := RTKiviatBuilder new.
	b objects: #('ABCDEF' ' 123' '      1').
	b addMetric: #size.
	b addMetric: [ :str | (str select: #isAlphaNumeric) size ].
	b addMetric: [ :str | (str select: [ :c | c = $ ]) size ].
	b build.
	^ b view
]

{ #category : #icons }
RTKiviatBuilderExample >> exampleSimple01Icon [
	^ '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'
]

{ #category : #sources }
RTKiviatBuilderExample >> exampleWithArea [

	| b n |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	n := RTMultiLinearColorForIdentity new objects: (b objects).
	b shape circle color: [ :value | n rtValue: value kiviatNode named]; size: 10.

	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	
	b activatePolygons.

		b build.
	^ b view
]

{ #category : #icons }
RTKiviatBuilderExample >> exampleWithAreaIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAIwElEQVR4XuWd61MTWRrG55+d
D/t1qvbTftmyrKl1LHdm1K2xtHbXy4g4iI6MOookgYTQ5N5Jpzud+61zIUBAHWS5PdlzDobL
JNxCp7vhfaueoqQArffHOe953/O+x686HfrmJPuKvgvoA6Fv9IHQB0Lf6AOhD4S+0QdCHwh9
ow+EPhD6Rh8IfbMEyGp9FfVUHfTd6hAgnptuIfrmECDL5SXM/yqhphj42PpIf6XYCSQUCgkA
3ndeRP1RfGh+QFWught9N9sA5MWLF8LxaliFf8ovgHAtFhaxkFmgD8VqIGtra1BVFYHpACS3
BCWo7EHhMuJVLFeW6YOx+tjbBbBQWkC71j4EhauWrOHz6mf6YKwGwhWbi/UA4VptrKLKVgx9
91sMhCun5PpC4Wqmm2jlW/TBWAkkFU2hnq8fCaUbX1aMFfpgrACSltMIzgSPBbIHJlHF5vom
6AMZIhAeL7KJ7KmAcK3UVljgN0AfyBCAJENJ8THsC+P54+enhsJVV2sih6EPxEQgYw/HxArh
YLgWK4tngrK7jRniI30gJgC5cfWGyNpD3hAis5GeZPEs4sfkne0d0AdyzhjSL8gPCmW5vIyG
3gB9ICYC4cfgQYEc3MaWSkugD8QEIGZBEWUYpYY/lv8AfSDnBJKJZ4TMgHLZyvy2ACmohb07
E7PESzAL2Ytf5rcFSDdhPKmkMlB8Yaex9gUu81sOpJuLzLydwfjP46YD2QPDrpHXP66DPpAT
HHX7+m0kAgm8n3iPyZeTpgX4o1ahccHK/LZtWWafuI4Tz10W8xejDGM7EC4tog0dSjfb58VL
+kBOyidyNbG9WAGlW+bf2tgCfSDHKKjoCBWKlkFpG21WUXZel6VjgNxQpA5XxWhZBqXbdLFU
dE4ZxjFAUuUanoeCKJQb0EsG3NkMEqUqCtWmZdvYxwX7uy0dAeTBnQdIlg28m/Ji2hcQUA4q
XaoJQEkGKj9kQHaX+R0BhOcm8yx+SEEZU25/D5B+gDxfAOWGAIhXkps2lfkdAcT1ygUpFId7
RsKUxw8pIJ8I5aAyX1aQyra9bKVhXnxhZX5+B0Myhrgy6f0VkKsgWzDOBOWgsgyQiwHS2DaY
qTZMKfOvtddA69ibLx5yql+KDgykHyC+gvjBIV2pnyu+kAHSz5ERWTMNSs8KymSgM0CpMwLi
nfyt7PC6LR0BpFVv93VckyWLzVj6RAcnU3khvs2NPXqNWJ/vWUpWUJPZ12n53W0x8jfEpZ+g
Z9j2WKqLFcQBaUwPUzGM68qJZf74hIzQaAiXDoi/UOjr6HYs0/kQL3cUvxvHKeFzITj1DtFp
FybHJzpxzzSMcBiFsIRM1I+yHAf/OStyrhOX7iIRfgU98HVHnf9rJxLWEFfSe3oTjYok9VYy
gFKqdKw8t9wwe4TPEUDUUm8Ar+QMpKQZKJLUo2wgimIwjsi0H0kpiHJMQS4uI5UI7Sv6FKn4
W+iJ36ErHmhqESnmxJRe7vm75EIZCktCG7WlUwZ5A2tDust3BBClWD0MI18Tv9EGqwLPvv4d
MdcM1OA8YgEfZt67EPL7MD35Rjj+ycO7zPkP8Pa3x/j16bf4990fkWZO50ppJSHPdAA/PxnH
zX/dEz//+j9vY1aKYC6fR7RUEf+G+Hwcd76/g2t/v7Z3gTb631F885dvDl168Rzl3r178Pl8
GB0dFVCuXr2KyclJXBogkxm957dWZTmJFgzgt/EnePZ4FMFZH9tqvMz595FSJOjyL9A1FSOP
n+8B6EJIJvPQtP1Tm28uvJt08hwnl0e8WMEP//ih5zLr5rWbePboGaqZqpht4d2W/PONTP1Q
PxhvqPB6vQgGg+JzV65cAYdyaYCkDmxZyehD6PNfd9xvxjE39RO0+Dxz/hj0VPaQ4w9KUwtQ
k0wMAs9h+p2qZAaBH3uXjWUx3dU3Q68uiStm/jXdzxXDRexsHS6lbG9v7/15c3MT6+vmXRU7
AshB52nh70TA1dlp6CgAXDqLB0klLyAcdfqayWYRKpYGLjba0VNsO5BM5U8Blh1ZjwORTBze
jv4spVBBgsWkqrE4EAjedb9kY9e97UBm8/tH3pRe6gtBYRBUtXhsLjKbyyFSLA+chfOrXQ6D
fPm9VGnuroxEGpJfFluRgBDPnQghzMotCos/i/X2uXuFNz87Y3LLdiBe9pvNc4PAXLITDmkn
QsiXGqLupZQNU5rqnDbbaDsQPzuGJhI5AUTTi5CV/qUSXzaHKNuSVk0oqzf1JhYdOv1rOxDu
7PuPnoqbwqfPJjDx+v3+iYsFZ54zFKoL5jXOJQz6bUBHDuA0VqBny/jP/RG8mHgrsufvbtw6
d4A+qplh/YPzW0ttBRJkOUL3dvCs9aTTxwnjQjVf2wZEq9REVZUH9diXepKZ4q2jF/EVItuA
qF+AyOWq+Z0jscqFHeCxBUir3BpKkzW/+/609OlCD+3YAoT38oZ94U6/55sGnQW5LEOgtgCR
JdmU5mr+IFoj1aA/9HkeIBzGnGtOPLfhfu0eGEZFrmB7a/vSjUZbDoRfAPGP169cFxroqQ22
ujqX1CwFosf0vVXB44fnjef0ZXGtTuIxGsuBnLksXl8RWXaHiFkGhD8fO8j2tPF5g9QTTZYA
EY0ChcaZWjbb1TbJR8yGDqTM7jrmPfOnK4vzRzFzLfpP/A0TSJHdf3PxWHCZ5skvLJCTSiS8
C5D+w8oWAMkn8+JUxRPAZrGJl6MvRQ3rYMC2ehiGNBDedMZPVvx/S+DP+/GXSV+NvRK5BI8V
9F1vMRD+nknvu1YV7Ozs0IdhNRDeislXyME48an1iT4Iu4B0V4fThvJJAuGxgid1vPZE3702
A/HemRETRZv/26QPwwlAtEkVkV/C9GE4BcjGxm4hcGtrC1z03WszkJGREQEhnU6Di757bQLi
8Xg6LpcLmqaJUS8+b2fWzB19IPSNPhD6Rh8IfSD0jT4Q+kDoG30g9IHQN/pA6AOhb/SB0Df6
QOgDoW+nsP8DRe4gRSmBD8QAAAAASUVORK5CYII='
]

{ #category : #accessing }
RTKiviatBuilderExample >> label [
	^ 'Radar'
]

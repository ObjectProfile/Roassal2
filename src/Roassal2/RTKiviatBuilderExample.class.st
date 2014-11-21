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
	
	^ b view canvas'
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
	b shape circle color: [ :value | n rtValue: value named]; size: 10.

	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	b build.
	^ b view
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
	
	b build.
	^ b view
]

{ #category : #icons }
RTKiviatBuilderExample >> exampleColored2Icon [
	^ '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
plgAAAAASUVORK5CYII='
]

{ #category : #sources }
RTKiviatBuilderExample >> exampleColored3 [

| b myKiviatNodesElems m col |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	b build.
	myKiviatNodesElems := (b view elements select: [ :e | (e model isKindOf: RTKiviatElement)]).
	b objects do: [:o | m:= myKiviatNodesElems select: [ :e | (e model named name= o name)]. col := 	(Color random alpha: 0.6). m do: [:e | e color: col]].
	
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
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAHTUlEQVR4XuWdW08TWxTH+Wy+
+3Q+gokPxA9gPBGImugLRnOCCeCDJAIa0BhRCHg5IBRslUihHkBoubWlpeUmFEHg37P/04wO
ldIL7czurJU0bZnplK7f3ntd9tp7atJp+aKT1MhXgXwg8kU+EPlA5It8IPKByBf5QOQDkS/y
gcgHIl/kA5EvtgD5/h2Ynz+EfLVqAqSzcxN1dctpKJGvWg2AxGIHePFiFYkEsL4uH4qjQAYH
B/HlyxekUin09LwyYKyuAoeH8sE4AuTatWsYGhpCfX19uqHhn18QCIRg5KvaZiBTU1MYGxvD
7OwsfL5ZBAKBExA2NmAMZfJV7pDbG40CG4pC9t8JZWtLPhhHgASDQZx1/PhYPhhbA8P9fSAU
CuGs4/G4fCi2AaHru7CwgJ2dnTOVnkzKty+2ANnbA8LhMLxeL46OjvIqfG0N2N2VDabiuaxw
+MjoIcfKYBT6mUhELpSKAqH9CAZT+Pr1KzweT1FKZk9hj5EPpIxy+fJlvH//HqOjU2DguKoi
xGKvQdtCGyMfSJnkx48fGBn5DwMDA2d6XPkkFgPolckHUgZR9hzWYazU6zBucbt9sW2Cysxn
LS8vn1uhjPTd6ibbBsQaAE5PT5dFmYTCHJl8ICWK6TXRDWbAWK6JLPY+67AoH0gRhjnzHMPE
xERZFfjzpzvS/LYXOVhbcjnsSbYwXVPN9sV2IIFA1IhN7t+/j46OjoopjlC2t6sPjO1ABgfH
0djYiObmZrS0tJwrNilEmOavpqILR+qyqKTfdiWGygen1ZPmdxwIhbkuO76Xw5ju9sWxykW2
2t8R+HHeOZNyu9+cGpAPJMsbsr6fm5vDT+W72vX9tCs6pmG06CGZSD7OqhXbqx5Z/qrTMOZo
sbXVljArzOjdqf9FlzS/FkCYmuczgTQ0tDs6McVsAqN+kUAoDN58Pp+hAL/fj9raf9HdDSwt
OacUZhOcsi+OA+EwMT8/ryaf9jE5OakmsqZVnmsG1uN8UEHKEbNVSZub9tsXx4FkF8utrGTe
rys3LFfrXVwEUqnMsx1OAKEQjggg5rhtuqLm34pJqVBZjMR5nUrmr+yottQCiGnEVfL3xI8t
1eui0sxexGmXcirx4CAD3tVAMnHInz+0r28OnZ3xvD9+T4XdUdV8zzqH9icU2kMgEDMWE3m9
wMjI6YrNvh7Pf/ny5LBFu+bx7KOrKwlXAjmtqqSraw23b4fSweCaaumJnI+ZmQg+f5458xzz
vE+fZjA3l1Dp/+9obd0q6Ho9PetoatpGX19SeYRxrKzEMTubxMOHG3j0aN2dQNgKs6dhvd5F
lDtdQvC5hjAW5ymHz/Dq+Fplc1SPEuZlWVMY1kj5woW/VDzSrYasTly5cuVUpZhZYnpkFy9e
VC2+FcPDw6ee++BBN4aGxvD06SDq61uN3sgpX9oa2gWeY36edci1tX/j3r2WnNe7c+eOUWvW
29urevFtuA5IOAwQivm+ubk7zeVx5iOftLe3Gy7wwMAIgsHMeM9W/vEjQO+I0J48eWIo++bN
m8jVg96+HTZij7a2NuN6Hz58QK7v4/ONGzdw69YtdwGxDiFUnt+/otIna/gdByRgPZctmx4Z
WzZfLywcGotLrRX29NysRpiLUc3XubLK0WjmOubxQir2zTycq4CYwSCFDfPx4+0Trdx8XagL
XWx0zcI7XeqHtQBizRs1NkYxOoqSirJLSXNYG4N8IL+GkIxSNjdTatg5RrHeWSnZYTNHltZM
anRJmySVdt69m1RjeGF7pdABKAUEDTUdiLSmUqODu5txYVcLWml1ngoS9ibda7W06SFTUxFk
3N9wzixvqSA4JMovAypAzH1QJiZWfimLwdlp0Eotpuaw5uQMYFUB4VhO6eh4oezHO2MdojXI
Os+qqezIXz6QAl1Oj+fP3R44vJxndpDXrdY9uxzuIVvIHl7Os8+Wrq5sVQBhMOj3Zwx4KdG1
7gFeVQGJxw/w7FkM5ai1ZY9w0+5CjgB5/nwPV6+GTyT8SvHQKjmVKgrI2FjMmAgq9fPsVW5d
s247kEQiiTdvhgxl9vf3F6VUel5u39XBdiADA5PG7kBLS0tFLUEwY5a0y8VWIKFQ0lhfOD4+
bkBpamrKq2C6wfL3OqmQcCawmPOz67TkAykrjDCKcWXdtkODdkC+fVvLq2AmEKXv8VtxINwq
tr8//64N7BW6rvtzFZDd3X1EIqvGcoPTjrP+VpLRdhyIz7ckf+9eXYAEAhGYRW7WTZVpsOX3
CgeA3L3bhkuXLhkTT5yAkurKagEk281lj5B/TxEHgSwuZsr0JeyTqD0Qc1qWvYJelHw1Owgk
mdxREI7l7+WuA5BXr7Zx/XoYBwfy79SmBRBOOvX27hW1z7t8qSAQc215JBKRD8RpIJz9403B
uEMcd/aRr1qHgfC2ea9fvzZuDFZXVycfiI6RunyRD0Q+EPkiH4h8IPJFPhD5QOSLfCDyRT4Q
+UDki3wg8oHIF/lA3Cv/A+XJ50lTpDSIAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTKiviatBuilderExample >> exampleWithArea [

	| b n |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	n := RTMultiLinearColorForIdentity new objects: (b objects).
	b shape circle color: [ :value | n rtValue: value named]; size: 10.

	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	
	b activatePolygons.

		b build.
	^ b view
]

{ #category : #icons }
RTKiviatBuilderExample >> exampleWithAreaIcon [
	^ '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
QOgDoW+nsP8DRe4gRSmBD8QAAAAASUVORK5CYII='
]

{ #category : #accessing }
RTKiviatBuilderExample >> label [
	^ 'Radar'
]

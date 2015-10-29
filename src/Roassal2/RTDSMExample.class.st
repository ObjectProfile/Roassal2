"
RTDSMExample new installTitle: 'TopLabelRotation' 
		code:
'
	| dsm |
	v := {#A -> { #B . #C} . #B -> {#A}}.
	keys := {#A . #B . #C}.
	dsm := RTDSM new.
	dsm rotation: 0.
	dsm objects: keys.
	dsm dependency: [ :k  | v asDictionary at: k ifAbsent: #() ].
	^ dsm
'
"
Class {
	#name : #RTDSMExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #sources }
RTDSMExample >> exampleClasses [

	| dsm |
	dsm := RTDSM new.
	dsm objects: RTShape withAllSubclasses.
	dsm dependency: #dependentClasses.
	dsm build.
	^ dsm

]

{ #category : #icons }
RTDSMExample >> exampleClassesIcon [
	^ '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
YII='
]

{ #category : #sources }
RTDSMExample >> exampleNumbers [

	| dsm |
	dsm := RTDSM new.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	dsm build.
	^ dsm

]

{ #category : #icons }
RTDSMExample >> exampleNumbersIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADAElEQVR4XuWZ22oiQRBA8/9f
kPckDyKSxzyEoEiCqBAveAmJ94yXKN4Vd12tbFezIyZRou6uDpwDRTNOz0udqanu9uz9nY+X
OOOngC+ED18IXwgfvhC+ED58IXwhfPhC+EL48IXw4QvhC+HDF8IXwocvhC+ED18IXwgfvhA+
fCF8IXz4QvhC+PCF8IXw4QvhC+HDF8KHL4QvhA9fCF8IH74QvhA+fCF8IXz4Qv4Jy+VSdvnN
JZPJSLFYFL6QA6hWq1KpVGzk83l5fX21Y7PZlOfnZ8nlcpJMJiUajYomWuPt7U0eHx9twm9v
b6Xb7UoikZBGoyGFQkFKpZKMx2O+kENxHMcmbz2J8/lcFovF6lqTreN0Ov2Q6NlstppXr9fF
fZb/ydoTffM1gfF43H5edEylUnZcD33bdUyn09/Ode91Oh2+kH0JBoN8IV5CEyrlsogR89P0
Ck18rVaz43q02+0P9z5fb5o7Go34QvZFm7Z5nUXOz2V2f8+vkFMzGAxEtEouL2UWi9kE6+pK
x/XQVdj6Pfdae9C2ubrq4gvZE11R8SvEQ8RMVfwyfeDHw4PMzN7BeXqSpknotr6g+5Nde4hX
9yCeFuLz+VarLMd8frRS5OqKXyGnomxWWNrYdRfefHkRubgQub621+uhfUFHd8f++XrTXH4P
OYBAIMCvEC+hZ1N8IR4im81u3KlbMSb4Qo5MJBLhC/Ha4WKv1/uylNWjFA3+svfI6P8X/Arx
EMPhUFqt1pfjEOfuzkb75sYG/+jkSHx3/O5WCr9CjrjK6vf7ohtE/fbrqH1Bx/KfY3kN9572
kG1z3XDv8XvIX+5D+BXiASaTycYe4vYDe5Rigt9DjtQ/wuHwTn/himnwWimOeYZfIf8Jv98v
oVCIL4QPXwgfvhC+ED58IXwhfPhC+EL48IXwhfDhC+HDF8IXwocvhC+ED18IXwgfvhC+ED58
IXz4QvhC+PCF8IXw4QvhC+HDF8IXwocvhA9fCF8IH74QvhA+fCF8IXz4QvhC+JyG3yIplAJj
8utNAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTDSMExample >> exampleTopLabelRotation [

	| dsm v keys |
	v := Array 
		with: (#A -> (Array with: #B with: #C)) 
		with: (#B -> (Array with: #A) ).
	keys := #(A B C).
	dsm := RTDSM new.
	dsm rotation: 0.
	dsm objects: keys.
	dsm dependency: [ :k  | v asDictionary at: k ifAbsent: #() ].
	^ dsm

]

{ #category : #icons }
RTDSMExample >> exampleTopLabelRotationIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAABqElEQVR4XuXWTYrCQBCAUe9/
Ak/jTvFn5TIIZhEwQkhAQcc4Us50JGFOkFHeB0VBL/vRJJPn0++dmvhX4IP4+SA+iJ8P4oP4
+SA+iJ8P4oP4+SB+PogP4ueD+CB+PogP4ueD+CB+PoifD+KD+PkgPoifD+KD+PkgPoifD+Ln
g/ggfj6ID+Lng/ggfj6ID+Lng/j5ID6Inw/ig/j5ID6Inw/ig3xch8Mh0t7tdpFlWazX60j5
IP9UVVXRNE1cr9c4n89R13WkMx9k5Iqi6C79crlEmpjNXrPfD9sHGbH5fB5t28bpdOomptPX
bDbD9kFGLM/z7sLbxSLSfG233Xwfj8P2QUZstVp1H/H+ZfQv5Xa7DdsHGbHlchn3+z0evzBp
+m9JOuu3DzJiZVl2F96/DP+FvAFIegXpV/fvJIh++yB+PogP4ueD+CB+PoifD+KD+PkgPoif
D+KD+PkgPoifD+Lng/ggfj6ID+Lng/ggfj6ID+Lng/j5ID6Inw/ig/j5ID6Inw/ig/j5ID6I
nw/i54P4IH4+iA/i54P4IH4+iA/i54P4+SAf0Q9xU5fjChaEpQAAAABJRU5ErkJggg=='
]

{ #category : #accessing }
RTDSMExample >> label [
	^ 'Dependency Structural Matrix'
]

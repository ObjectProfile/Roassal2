"
RTMondrianExample new installTitle: 'SystemComplexity' 
		code:
		'
	| b |
	b := RTMondrianViewBuilder new.
	b shape rectangle 
				withBorder;
				width: [ :cls | cls numberOfVariables * 5];
				height: #numberOfMethods;
				linearFillColor: #numberOfLinesOfCode within: RTObject withAllSubclasses.
	b nodes: RTObject withAllSubclasses.
	b edgesFrom: #superclass.
	b treeLayout.
	b open.
	b view canvas'
	
"
Class {
	#name : #RTMondrianExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #sources }
RTMondrianExample >> exampleArrowedLines [

| b |
b := RTMondrianViewBuilder new.

b shape circle size: 30.
b nodes: (RTShape withAllSubclasses).

b shape arrowedLine withShorterDistanceAttachPoint.
b edgesFrom: #superclass.
b forceBasedLayout charge: -500; nbIterations: 50..

b build.
^ b view
]

{ #category : #icons }
RTMondrianExample >> exampleArrowedLinesIcon [
	^ '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'
]

{ #category : #sources }
RTMondrianExample >> exampleClasses [

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
RTMondrianExample >> exampleClassesIcon [
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
RTMondrianExample >> exampleNestingAndTitle [

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
RTMondrianExample >> exampleNestingAndTitleIcon [
	^ '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'
]

{ #category : #sources }
RTMondrianExample >> exampleSimpleTreeLayout [


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
RTMondrianExample >> exampleSimpleTreeLayoutIcon [
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
RTMondrianExample >> exampleSystemComplexity [

	| b |
	b := RTMondrianViewBuilder new.
	b shape rectangle 
				withBorder;
				width: [ :cls | cls numberOfVariables * 5];
				height: #numberOfMethods;
				linearFillColor: #numberOfLinesOfCode within: RTObject withAllSubclasses.
	b nodes: RTObject withAllSubclasses.
	b edgesFrom: #superclass.
	b treeLayout.
	b build.
	^ b view
]

{ #category : #icons }
RTMondrianExample >> exampleSystemComplexityIcon [
	^ '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'
]

{ #category : #accessing }
RTMondrianExample >> label [
	^ 'Mondrian builder'
]

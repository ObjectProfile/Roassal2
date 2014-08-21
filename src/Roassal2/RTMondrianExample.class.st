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
	#category : 'Roassal2-ExampleBrowser'
}

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
	b open.
	b view canvas
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
RTMondrianExample >> exampleSimpleTreeLayout [


| b |
	b := RTMondrianViewBuilder new.
	b shape rectangle size: 10; borderColor: Color black.
	b nodes: (1 to: 100).
	b edges: (1 to: 100) from: [ :v | v // 2 ] to: #yourself.
	b treeLayout.
	b open.
	b view canvas
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
	b open.
	b view canvas
]

{ #category : #icons }
RTMondrianExample >> exampleSystemComplexityIcon [
	^ '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'
]

{ #category : #accessing }
RTMondrianExample >> label [
	^ 'Mondrian builder'
]

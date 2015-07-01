"
RTDynamicStackerGrapherExample new installTitle: 'Basic' 
		code:
		'
| b |
b := RTDynamicStackedGrapher new.
b numberOfBars: 10.
b minY: -200; maxY: 200.

b y: #yourself.
 
b barShape color: (Color red alpha: 0.3).
b view addMenu: ''+ 1'' callback: [ b add: 400 atRandom - 200 ].
^ b view'
	
"
Class {
	#name : #RTDynamicStackerGrapherExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #sources }
RTDynamicStackerGrapherExample >> exampleBasic [

| b |
b := RTDynamicStackedGrapher new.
b numberOfBars: 10.
b minY: -200; maxY: 200.

b y: #yourself.
 
b barShape color: (Color red alpha: 0.3).
b build.
b view addMenu: '+ 1' callback: [ b add: 400 atRandom - 200 ].
^ b view
]

{ #category : #icons }
RTDynamicStackerGrapherExample >> exampleBasicIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABeCAYAAADVA7GfAAACn0lEQVR4XuXcS8t5URTH8ecl
ehWmXgIGMmJg5h0YKhkwcB+4RYRCiKIMRC4RWZ7WKvJ/Jv+Jy6nvr05n785sf9p25+xt/dxu
/DgpP/wh4IPw8z+Q2Wwmp9NJer2e8IfEASCZTMYgqtUqH8QJILvdTs7nswyHQz4Ifw3hhw/C
B+GHD8IH4YcPwgfhhw/CB+GHD8IPH4QPwg8fhA/CDx+ED8IPH4QPwg8fhJ8XgCwWC7lcLnbN
53Pbj9f2crnk781/GqTb7UowGJRisSi5XE46nY5sNhvrr9frB8h4PJbr9coHejdINpu9uVwu
0SNEChIKheyu/XQ6/Q/AZDLhgzhpDeGD8EH4IHwQPggfhA/CB+GD8EH4IPy8AuR4PEosFpNE
IiHJZFLC4bDs93vr5/N5/ovhp0H0/yT6Zq5v5alUSsrlstRqNeuvVit5xuCDfOEnS2eMIt3b
/BnCX0P4IHwQPggfhA/CB+GD8EH4IPy8C6TVakmz2bQB1xdEPsiXQbT6g17T6VS0IsTf53rI
oVKp2HPSpQc+vgJSr9ftk8lgMLDPJ/wZwl9D+CB8ED4IH4QPwgfhhw/CB+HnnSB6Al7vkUhE
DoeDlEol6xcKBXneNeSDfACk3W4/Blm3bt1ut3i9Xuvr/d7m76l/cIZoaVm99JRJv98XRdJZ
02g0ZDQa8WcIfw3hg/BB+CB8ED4IH4QPwgfhg/DzcpDtdmv/Qb8XDbgXDPhbOIAP8sEZEo1G
rVCAx+MRv99vA+/z+R5t3VN/LiTAzxtBdODj8bh+MrGCAYFAwPbVFUO/Z/GH16FrCD98ED4I
P3wQPgg/fBA+CD98EH74IHwQfvggfBB++CB8EH74IHwQfvgg/PBB+CD88EH4IPzwQfgg/PBB
+CD8fCu/tkDt9Hdeg+0AAAAASUVORK5CYII='
]

{ #category : #sources }
RTDynamicStackerGrapherExample >> exampleComposing [

| composer a b |
composer := RTComposer new.
    a := RTDynamicStackedGrapher new.
    a minY: -200; maxY: 200.
    a view: composer view.
    a y: #yourself.
	a build.	
composer group: #first.

    b := RTDynamicStackedGrapher new.  
    b minY: -200; maxY: 200.
    b view: composer view.
    b y: #yourself.
	b build.
composer group: #second.

composer move: #first onTheLeftOf: #second.
composer nameGroup: #first as: 'aFirstName'.
composer nameGroup: #second as: 'aSecondName'.
composer setGeneralTitle: 'aGeneralTitle'.

composer view addMenu: 'Left' callback: [ a add: 400 atRandom - 200 ].
composer view addMenu: 'Right' callback: [ b add: 400 atRandom - 200 ].

^ composer view
]

{ #category : #icons }
RTDynamicStackerGrapherExample >> exampleComposingIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAENElEQVR4XuWc2yttXRiH93/m
zoXcy4VcoByK3JCclUiU5HwIF44JSZKc5Swh5CyJUCgXCnnX12+058quxd6fPutb2/PUas4x
11xzrfk+a8zZO8aY44fPxyeU+MEPAV8In4+ELC0tmVcoKyuzxcVFe7tDd3e3bW9v2/r6utve
39/vlldXV8YP3xcIGRkZsdvbW5OYqqoqq6ys/CXQNTU1VltbaxJRUlJiPT09Njk5abOzs3wh
XyGkqanJpqamfEVFRU7KysqKPT09+YN9cHBgR0dH7r3i4mLb3d11ZUnhh49/D+EL4cMXwhfC
hy+ED18IXwgfvhC+ED58IXwhfPhC+EL48IXw4QvhC/k8qamplp2dbTc3N5/qd4mPjzd1vkVF
RVl5ebkNDAy44ywvL1tjY6PxhfwBubm5lpSUZMfHx3ZxceEPWlZWlqWkpLhyfn6+xcbGuvXE
xETLyclxAdZyYmLCSTw9PTUJ+bm/z1uqIy4iIsIvJDMz0ySeL+QdqqurLSwszKdeybu7O1N/
vrqVY2JibGxszK6vr13PpYLb2dnptrW0tPgDrF5M1QZ1QwcS4n2Ht7/21XfwhbxDZGSkRUdH
uwAlJyebaowEqIYUFBS47Z4QkZCQ4C5Fb//x9fX1TkhcXFxAIeHh4a77eWNjwzIyMqy0tJQv
hA9fCF8IH74QvhA+fCF8IXz4QvhCAqEETAnU2tqaP3HSyPi+vj43tpcfOp9P46D39/c/jEVz
c/O/illAIWqSGB4etvb2dlMTRWtrq9XV1bkMuKOjw2W3c3NztrW1Zb29ve5Rhby8PKuoqMCI
Gh0dNT2SoaaboaEhS09Pd+e+t7dnGsCudQ1gl5D3YuY1Bf1WiJ4T0YG1rgOobamhocGNjFeN
0cGmp6ft/PzcvacfphHz+nEUIfrXq+VYV5G2tjZ7eXmxrq4uvwzx+PjomnI2NzcDxkyfkTT+
PYR/Uw8uquHz8/O2sLDgWou1zSvzhfwP6FJyeHjoXs/Pz3Z5eekve/uoz4QvJEiMj4+7+93q
6qrNzMzYzs6Ou/epzK8hfPhC+EL48IXwhfDhC+EL4cMX8hWoPYmfqYcQajr5XaZ+cnLCz9SD
hdePw8/U+fCF8IXw4QvhC+HDF8KHL4QvJNhomI2Wbx+PC3khZ2dn9je/3jsxPXFVWFjohtt4
Yt6iTD0Uz+fb1hBl65pFVaMtNYiPf8niwxfCF8KHL4QvhA9fCF8IH76QYOBl6H9Txv6thdzf
31taWprL2L2yJrXxMnW+kCChaZg0VZOmcvIy9p+T1pjg1xA+fCF8IXz4QvhC+PCF8IXw4Qv5
r3l4eLDX11fjZ+ohhKYC+ShT19zAfCFBQgMcBgcH+Zk6H74QvhA+fCF8IXz4QvjwhfCF8OEL
4QvhwxfCF8KHL4QvhA9fCB++EL4QPnwhfCF8+EK+Ef8AYYqQzBlo8q8AAAAASUVORK5CYII='
]

{ #category : #accessing }
RTDynamicStackerGrapherExample >> label [
	^ 'Dynamic stack grapher'
]

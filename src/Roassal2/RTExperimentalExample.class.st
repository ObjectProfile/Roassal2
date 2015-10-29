"
RTExperimentalExample new installTitle: 'ClusterBezierAndSlider' 
		code:
		' 
classes := Collection withAllSubclasses, TRTest withAllSubclasses.
b := RTMondrian new.
b shape circle.
b nodes: classes.
b shape line color: Color green.
b edges connectFrom: #superclass.

bezier := RTBezierLine new follow: #superclass; tension: 0.5.
b shape shape: bezier;
	color: (Color blue alpha: 0.5).
b edges notUseInLayout;
	connectToAll: [:cls | cls dependentClasses asOrderedCollection remove: cls ifAbsent: []; yourself ].
b layout cluster.
b build.
center := b view elements encompassingRectangle center.

(b view elements select: [ :e | e model subclasses isEmpty ]) do: [:e |
	lbl := RTLabel new elementOn: e model.
	b view add: lbl.
	angle := (e position - center ) theta.
	lbl translateTo: e position+((lbl width/2) * (angle cos @ angle sin)).
	angle := angle radiansToDegrees.
	angle := angle +  ((angle between: 90 and: 270)  ifTrue: [ 180 ] ifFalse: [ 0 ]).
	lbl rotateByDegrees:angle .
	].

edges := b view edges select: [:e | e shape = bezier ].
slider := RTSlider new.
shape := RTCompositeShape new 
	add: (RTEllipse new size: 30; color: Color blue; borderWidth: 0.01; borderColor: Color black);
	add: (RTEllipse new width: 24; height: 19.5;
		color: (LinearGradientPaint new
			start: 0@ -0.5; stop: 0@0.4;
			colorRamp: { 0.0 -> (Color white alpha: 0.6). 1.0 -> Color transparent } )) translateBy: 0@ -3.9;
	add: (RTArc new innerRadius: 12.9; externalRadius: 13.8; alphaAngle: 200; betaAngle: 340;
		color: (LinearGradientPaint new
			start: 0@ 7.0; stop: 0@12.0;
			colorRamp: { 0.0-> Color transparent. 1.0 -> (Color white alpha: 0.6) } )).
slider shape shape: shape. 
slider moveBelow; view: b view; callback: [:v| 
	bezier tension: v.
	edges do: [ :e | e trachelShape points: (bezier getListOfPointsForTrachel: e); resetPath.].
	
	].
slider build.

^ b view
	'
"
Class {
	#name : #RTExperimentalExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Experimental'
}

{ #category : #'public - generation' }
RTExperimentalExample class >> bumpLayer: n [
	"This method recibes a number and return an array of random numbers with that size
	Inspired by Lee Byron's test data generator."
	| rand arr bump |
	rand := Random new.
	bump := [ :a | | x y z |
		x := 1 / (0.1 + rand next).
		y := (2 * rand next)-0.5.
		z := 10 / (0.1 + rand next).
		
		(1 to: n) do: [ :i | | val w |
			w := (((i -1)/n) - y)*z.
			val := (a at: i) + (x * ((w negated * w) exp)).
			a at: i put: val. ] ].
	arr := Array new: n.
	(1 to: n) do: [ :i | arr at: i put: 0].
	(1 to: 5) do: [ :i | bump value: arr ].
	
	^ arr collectWithIndex: [ :d :i | i@(0 max: d)].
]

{ #category : #utility }
RTExperimentalExample >> createExampleButton [
	| shape base |
	base := Color r: 0 g: 84 b: 85 range: 256.
	shape := RTCompositeShape new
		add: (RTEllipse new width: 103; height: 50; 
			color: Color gray);
		add: (RTEllipse new width: 97; height: 47; 
			color: base );
		add: (RTEllipse new width: 71; height: 21;
			color: (TRPlatform current linearGradientClass new start: 0@ -10.5; stop: 0@10.5;
colorRamp: (Array with: (0.0 -> (Color white alpha: 0.4)) with: (1.0 -> Color transparent)))) translateBy: 0@ -10;
		add: (RTLabel new text: 'Swap Data'; color: Color white).
		
	^ shape element.

	
]

{ #category : #utility }
RTExperimentalExample >> dataFor: dim stack: s [
	^ s stack: ( (1 to: dim y) collect: [:n | self class bumpLayer: dim x ] )
]

{ #category : #sources }
RTExperimentalExample >> exampleClusterBezierAndSlider [

| b lb |
b := RTBundleBuilder new.
b from: (Array with: TRObject with: TRTest) using: #subclasses. 
b edges shape line color: Color black.
b bezier color: (Color blue alpha: 0.5).
b useBezierlineWith: #dependentClasses.
b build.
lb := RTLegendBuilder new.
lb view: b view; right.
lb addText: 'RTBundleBuilder: TRObject and TRTest subclasses'.
lb addColor: Color black text: 'Hierarchy'.
lb addColor: (Color r: 0 g: 120 b: 0 range: 255) text: 'Dependent classes'.
lb addColor: Color red text: 'Senders'.
lb build.
^ b view


	
]

{ #category : #icons }
RTExperimentalExample >> exampleClusterBezierAndSliderIcon [
	^ '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
rBoIldjiEkOdawZVKbpHfG5Wb99kvSK+qkR25wa1jyyyQ5NchpvE2NYjm4n/z25eqhkflBcu
nZDV9dmytblAWD+3zRjEFlsdIMDHeQtkvGH5OcuxxIxBUx7Z1VAu5weapMaYz9r0dm2i+/WR
y/LsqUzJCDXrhsfAwKhcbp0Ur2VAh5kILGrbiSkZHLuvEILFJdcGNcf5KLNK3tkZ1Lsp8B5J
I4zK4vqqtFaxidPPPurUGLQ8rVo95XBblcJevKkIEFfIwI8bl9xukkfgByJBTLvUOCmZzWHX
+teldquS2PZscwWvALMHWySjYUjHgiKtwDAGb2P2VzmKx7vkcG+J0Ftwvr9ZMvvb5Fyw0S01
2dpg3LP7SqTD1KaSeuokob1KSKasglgPb54ZUjeP33Fb3j1dJYdbq+SYyZq5uZkdZHnPFfn1
oeKokgOWrp0hZvK1XTfcXOX9jDJNBk+UhnWdgNtWMCC8AwKw1CxEYRi1V0KyIbPDzaK/OBlU
WLnYOO52uuv+kyEDTWXzTp9tzohy+m1mzCgERSLwjMC0HM0f0r8Zc8VoSIJzkzqGxaz/YHOV
xkRvsmeXrb+OUgjeJRNdcra/XnKGWlXuGcE2WZXi7DIGql0P4W46CL7FKGBXqeNSzW0P5cPD
vfp3VdMdQy/bpHXan6uE5qbk56fTFoLpfcdS7c29qsJjcrZ8TGMFAs9o7XcTOc63r6xNV9FQ
AHFK18ULnBak+OIaOZw77FpQcumIQgkCHAg/Usq6+nKlXockEogjPmy53Oxu/rfQgJWfqxiR
1PzrqnztRDQQxZa+TYZ6LlbwO5FxXfYVdEdl2yg78vaFT3OUjfdK5WRQr8kWvjM9zg0F1qb0
6p374gpGuiRvqMNdB7hUekcSKjtkWUqt02Mb6pZznW0xL0wf1xv56VHbEezvl+qnpNrAgn1t
1a4ZGbt9zdl3UtolDQPX1JpZuLL7MIgFBUFnKx23FJy+O6f1MyZv75Wo58psVOVszHCy+vPm
s3wXZeE1pw1jS6sPa2c/AZ0DRVzuDcvZyzP6Xa0YXL0nRcFBSakJq4CiqasTS9JbBuRk9lWj
yIXbQNldY19FIcynZXpEqsZDUjTeqePLpUH9yrCmD+ohHUM35NDFITlQ2KvCItmjlzett3XR
FbTBsRH5ZtI2944EBCevK8+Y1/enTLsFStzxWIazf531l9KecaXHGAHsC4ZF7pGWf8NN1k6U
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
TkSuQmCC'
]

{ #category : #sources }
RTExperimentalExample >> exampleScaleLog [
 
| g s extent x y superscript |

extent := 500@300.
superscript := '⁰¹²³⁴⁵⁶⁷⁸⁹'.
g :=  RTGrapher new.
g extent: extent.
x := RTScale linear
	domain: #(0 100);
	range: (Array with: 0 with: extent x).
	
y := RTScale log
	base: Float e;
	domain: (#(0 9) collect: #exp);
	range: (Array with: 0 with: extent y).
s := RTDataSet new.
s points: (0 to: 100).
s x: [ :n | n ].
s y: [ :n | y scale: ((n * n)) ].
s interaction popup text: [ :n| 
	'Number: ',n asString,'
Value: ', (y scale: (n*n)) asString ].
g add: s.
g axisX numberOfTicks: 10.
g axisY 
	numberOfTicks: 10;
	labelConversion: [:n | | v | 

		v:= (y invert: n) ln + 1.
		v := v isInfinite 
			ifTrue: [ 1 ]
			ifFalse: [ v rounded ].
		v > 10 ifTrue: [ v := 10 ].
		'e', (superscript at: v) asString ].
	
g build.
^ g view.
]

{ #category : #icons }
RTExperimentalExample >> exampleScaleLogIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADmklEQVR4XuWdS08qQRBG/f//
BzescOEKhZ3GDU8fCCoPX7wacyYZ403ExtwBGs+XGIxTGU2drq7qmp72aLXyKyUd+V3gB+KX
H4gfiF9+IH4gfvmB+IH45QfiB+KXH4hffiB+IH75gfiB+OUH4gfilx+IH8hqVa/Xg98dfiB+
+YGkpdlsFiaTSXh6egr9fj/4gexA0+k0jMfj8Pj4GG5vb0Or1QrNZjN0u90MwnA4DM/Pz2E+
n/uBFCWcmY/0u7u7zOmNRiNz+mAwCKPRKLy9vQXkn7IKHu04FyfjbJze6XQ+R/rLy0tYLpfB
n0MKFk5lxDPNfHV8PtoBs7WkDtWTk5NgTqw4mVGez++9Xi8b8a+vr8FfZW1Ri8XiH+fzxff8
jDzgL3u3LEY4iZbpJh/5qThfAYR5n3mekQ8EcgBTsn9huMMIeHh4+ARANGwr4fqBrKl+SLY4
HwhEwPv7e/C3TnZcBeF4cgCLLla9f7XoSBYIEMgF1P9UQaxyDVVgUkBoK5ADcgh/aSo6KCBU
RuSEm5ubrMlm7hDsFUgeDSTplV/7AUKVdH9/n0XEIa0P/hwQQFAh8ZXqKlkDhIgAxP+0pf1A
CsoRTE3+iPglECqbItvvtC5I1lRPfhfvOULoK7Gg87s2ASC0NoyLueSA0NYgV/jdmQAQFnU0
/vyuTAAIVRRP3/xuTAAIMPxVVCJAiAo/jESAsMjzNwMTAsJzCr/bEgHC6tvvskSA+KepxID4
y9uEgPhX4Qe0UvdrC0B+ar/TMPS7yR8hfiDfAfE3DRMDYtkt6J+y/Po9EH+p648Qv/xADgSI
f0NbYkDYZeh3jX/K8ssPxA/ELz+QAwfiXxAmAIT2e6VS8YPwT1l++YH4gfjlB+IH4pcfiAGI
f3diYkA22Z24aSTVarW92J2fn+/F7uzsrBA7/39HSDFCOJmNz3a7vZZe/vJ//qxk3TMTpj3O
uuI6b+SuO24PO67H7BAHlsXseB2bAy5jdjx8Y3tTzI57bXI/duZwzGDMjhec8GHMLgNydXWV
Xby4uPgxnDg+iT8y//zOhjOvCEuuc99198QxtGtidkyRx8fHUTt2WJ6enkbtLi8vQ7Vajdqh
6+vrqB2vaJTL5agd79WUSqWoXQaEs2y/fv4kbHBmzDZ2PT8DfZPfuY/7FW236d/nzyGpVll+
+YH45QfiB+KXH4gfiF9+IH4gfvmB+IH45Qfilx+IH4hffiB+IH4VpQ8Ov0piikAREgAAAABJ
RU5ErkJggg=='
]

{ #category : #sources }
RTExperimentalExample >> exampleSimpleBundleBuilder [
| tree searchTree relationsBlock relations b |

tree := 'president'->(OrderedCollection new
	add: ('assistant1'-> #());
	add: ('director1'-> (Array
		with: ('employee1'->#())
		with: ('employee2'->#())
		with: ('employee3'->#())));
	add: ('director2'->(Array
		with: ('employee4'->#())
		with: ('employee5'->#())));
	add: ('guard1'->#());
	add: ('guard2'->#());
	add: ('chef'->(Array
		with: ('subchef'->#())
		with: ('employee6'->#())));
	add: ('vicepresident'->(Array
		with: ('assistant2'->#())
		with: ('guard3'->#())));
	yourself).
searchTree := nil.
searchTree := [ :s :t| t key = s ifTrue: [ t ]
	ifFalse: [ | r |
		r := nil.
		t value do: [ :child | 
			r ifNil: [ r := searchTree value: s value: child.] ].
		r ] ].
relationsBlock := [ :str| | res strings |
	res := Dictionary new.
	(str substrings: '
') do: [:s| 
		strings := s substrings:' '.
		res at: strings first put: 
			(strings allButFirst collect: [:st |
				searchTree value: st value: tree] )].
	res	 ].
relations := relationsBlock value: 'president director1 director2 vicepresident
assistant1 assistant2
director1 employe1 chef
employee1 director1 employee2 employee3 assistant2
employee2 employee3 guard1 subchef
employee3 guard2
director2 director1 vicepresident assistant2
employee4 employee2 employee5
employee5 assistan1 chef guard2
guard1 president
guard2 employee6 vicepresident
chef president vicepresident subchef
subchef employee6 employee1 assistant1
employee6 employee5 employee4
vicepresident president director1 director2 chef
assistant2 assistant1 guard3
guard3 vicepresident president'.
b := RTBundleBuilder new.
b explore: tree using: [ :asso| asso value ].
b labelShape text: #key.
b bezier color: (Color purple alpha: 0.5).
b useBezierlineWith: [ :asso | relations at: asso key ].
b build.

^ b view.



]

{ #category : #icons }
RTExperimentalExample >> exampleSimpleBundleBuilderIcon [
	^ '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
mAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTExperimentalExample >> exampleStackExpand [
 
	^ RTExperimentalExample new helper: #expand colorA: Color yellow colorB: Color orange
	
]

{ #category : #icons }
RTExperimentalExample >> exampleStackExpandIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAWhklEQVR4Xt2daXATZ5rHX9V+
3P08+2lrq3Y/7NRuTe1s1dZMZaeyU1O1NVPJZDLJZJIhIQEGwhUTrsTgCxth2ZZvW77vQ74t
3/jANr7BNra5bLC5HBICIRwJIZMECLy9/0dt0ZLVLbVaLV8f/gU+Wup+f/3cb8vs1Zd+wotS
mbB5HRNs+PevbzHhTy8z4e0/MuH1l5jw5itMCN3NhLoCJuzfLn7PFMKEg/j/AShsJxMKTUwo
j8PXH0BBTFiHY3esZ0JMKBPeXy8e8/arTEjcx4SobTgev/e7XzHhhZ8z4b9+yoTfvsAE84eM
73v37/jPf/YT/srLv+YjHZE8xbyXG41RQnT0YX606RDvOmrkt2/f5qdPT/HcnHS7pqeneV5u
PK+tMvHK8hienGTmRQUm+9ekksIYnmGJ5+dOvs4vTGzm1VVWfuLEIK+uMPHJk0be0/4xn5qa
5C02I58YOcR7O4382szB58c7lJQY9/w9L0zu5BXlKXxmZoZnZ0XzZtsR/tnsZpzjEd7VdoRP
Dv6BXz6zng/1GvknM1vsx1vSo3lNZTS/Nh2Ec4zG68Xav391JsQu+3skxXImPGQCqa6M8bFm
xpuT8fXkytVgPhNSPmK8v5pxukmEL9eWngNxVncL4/XJjK9kMA7N2phQlciEoxVrGIhDPbCY
sdLVAYaUuJfxVusaBkJ6fI8JfUWrBwpp70bGZ0/gnNciEIeSw1YXlMECxjetW31QVAMhxXy8
uqCQ/vIy49bs1QPGJyCk9MjVB2WokPGQYAPvaWL83tzKBHF3lgmNyBx9BkI6XrT6oJAq4xjv
6WS8osQe/FeM1Qwiq527gPP5UYOFOEQ+ejVCITVmMX4fC1FfbeADzcsL5uY5xucv4/8/itIM
5CyymDs9qxfKxXrGh/rEu7Kp1tVibs8wwQJr+gxuZLSfCS2VjD/+PDBAWurFc/AbCGm4ffUC
cajT5rogSrp7mwkDrfpa04mj7u/tFxBSasTqh5IZqw4KSU8oHY0BAELqy139UArMjPMn6qAM
tfgPhcPi5N5PFyBDnasfCOlqMxPOdTEeF8P45YvKVnNiiPGnt/wDkhUv//q6ACFlHF4bUJx1
pQkZWZn8wpXm+WclRbkBBkIaLVl7UEimA/KL11GtDQq5KyXrY0MwUb2ANFrXJhBSl0xG9Ok1
JsxpaGJmmpXdIXtUiAIpXx7Kdzg4Gf7UbGS8LE8duMbktQllpFh+EYf7UWRecl3wKrijwlSD
IihrsQcgBdvxwzIUKPsYv45hz4M+TA9DGR8ME7/vrE+S8LMUz2CGj61dKynNl1/IqXGsVweC
/TEM9zql3+mUycYoGXj22IPLEjrRmwp1X3xPGkLe/vRrD1aSuTaBWKPVpcXOSopxhdJW7bnm
sQMh9YX5BmXCpAxlborxZxOre/G/P4GxMLrE1iwD786SrP7qJfVFpEO9NglKX49KIKSCnYz/
WKweyqhZ2X2VJRlWresaQuN09LjrtQ3ki1D6G3wH8h2OT4hiPD/T+7EuQEh3a5HOwVouxauz
mJQ98lDIem50rL540pkvb/lk9fTzpmTfgfgiNyDOKsRil2/3DqajRB5Kc/HKBNKayng6brhv
EWBLME0cxuDq7hkmVBd7ziBbssXreXBvmYA41BsLUw1RBvO4CC2Hk/JQujJWFpSSeO111/lR
8Vpy0pcZiEMpm5Sh9IXLX+hw18oBMlDkG4wRnPsoRtadwYyP94vHViPDtMYHzm35BIRUG6wM
pTpB/oLTo5YfygyGUA9u+DARRT3BS6VrOxkpXlt7BeOftK4QC3HoFHzw0xJ3IPS9S6flodAW
0GW1jnbfrGMw3P3Ga7Qwfuuy+Ho3P11BQEhjgEKxY/FJt0bIX7itfPmsJCHENxhZCvFyzizF
xey0wLgtzUBIJ1PkobRVyC9AfcLS1yYDhT7GjW7PWWU5enrjjYBStAKBkEZT3N3XpFE+l7fm
L62VoMCzN0h9AdLvpWOBPp9gQazsylyhQOwxJc39IopDFDZwZy9dta0Uz5Rki/Rec31XsPD7
k/Ij2BUBxF6rRLtfTE+d+4J0VgbeSobhpm5f9Q4gL53xSgTqa3BBI4fU9/Jq4BGsR9AKydHf
StgMjRJ1gpK22fWi6G6i9NF5Eb7/MsCWUerdKk4Po10e7lsz1VlT5Uw408aE6f4AWEhHun5A
7MXjRtcLvZrIOKaSLguSEx4YK6lJ9Q7j7ieMn4nWDoNUuo3xJHS70w8GwEKEs+g5ResLpXfR
3Xc9BXeuE5SiNP2zrVp6TTVblqL8g+EQWfqtrkDEEAB5dArTrmR9oSz2yVTp/viVUzd4XMfx
apnK8XKGPjBIOUhkrtBu+tsBAEIaQcf2bo2+UOr3ui6ANUxanPwo3R7MEZxBK+nOPBO+ytYH
BmmmBlBQBCea9XVbz4GQBlHkXSrUF0pLJDqs2yQwM+Pi3Zyd7L/bejyKG+mYOutoNupnHfY5
0HrGBzCsmh8JkIU4NN+Okz+sLxT7iBh30hPMG9pjpAV8MOAfkLZydTCOVekL43mRCFdpORBA
C3FWRYyBlwfrC6YdoJ+hg/rk/kJN4sczJrYMdTBo39nDPP1hkAYcE1GdYEyM0hNUCkAcuoJW
cxcCWAomh9eK/YfSvJ/xYwv9pQGNI96TiHf8G+8welsZv5wQGOuwd39Rw1UgQ22o08dKWnJU
AJHTwxNMaEBWlrzfwOnZ8DkEuKxdjH/ToK4h2f6RdHc3JPoOxQ5SBgBBKspC3QNXlr1ZHxB1
C16iV6aQrPwYjUYbhlid/gOZPiuuA6uJ9x2IJxUcMvBigHKGcMOKAtHJuqw7Ge9fmE9U+dhw
TAxzh9Fez3hJkEF3S2jcL53zM8RW2uXpUrGjfZKNGyoz1OA3kJa8BSC3e5nwGY1Zz+oLhtSd
g3rjtPR1UYR4t1UfRJ8rSVrYzgxtI1iyCGtY4FzSVIZrDG076P5el88snJ8fML7DdfCFfWxo
ytgXLiBAnOUAk7ZbvMiWPU7TuQ4VxR9gfPuFdMxns4wPRwQGBCl/i3tCcybLHUgasscvu3Gz
5Wt3W111onWg8ud2ICTTrsCAiEeMMQUhbuBu2/4a49QVmEV21Yw7u9oiLbB9qqcA40Kd68Y1
2iM1HBE4y7AD2S2fYZ4+4vq+l21MSEZMHKnXDoSeoycLKX5/wUIcitEApS4R8xBMCNMQ/K61
2St++4fAxH3I+MVG6bUdCt9k4G1J4sXW7XJ1QfEH3aHQ43ITA9Lv3ZhzhXEvS38Ys2bldH9k
EZBUFIiTSDK+6tMYOxrF6zS+J74uW7xgNgSpuwOeIdBdfjTDXtnzxcd70zTupBZkWtQRsO5h
vDbHFcrxNgBAtlaKArJ+0fj1/qfi5oN5AP31TxmPfg9FnwlVMzoBQb+DHy7VB0hvpDIQyw53
y2yrFW8ka77vQAbRruqwSK/F5BaNnxYDshl+/gru+q+HmdCKQU4hOqWFkb5DWKwD7zDeFC9e
YN0uA3cUip704HOYdjhaLn9l/M3/xTlQ3FmkNIDRo191PsdLQbzo9xvgIZ6MITiPiM+L0EKf
GlXnwm7gvGPfkiAzfxdXi87ijqqLZfxcNtLfOMQXo+eq++KEOFB670XGW6PcQTjLhgamLxvG
5WYdXvemBblayUQ146kfubtbxAbh+4fKMErgAWzxru+/LEBIQX9k/GiqePGxsJgaxIVnD9xh
tFkZL93K+I5XACXBMwyHDv3Fc8A3447MVtiFWf6RdyATca7HpiMunlf4VIv6TGUgbag9kja4
vtayAalHMpCNSrfRuJAGwwJo//A0qv4U9NG6ixnPhXsq/sDAX/kl47QPTA0Mh4wyUAZhPfGo
4CmDeoSW0DBNM50q8M4Qdb27tG2ur02xq8OmnCXOnJN3X9cRDu4vSkqY1eR/TNAqas1Ty7/V
aWKZ9D5AwCUkwypoaHYQ2ce3DepBOMuC17qCXtYjvEfUG4CdI/2sNlR6zy5YZzfA3KtV14+7
WeFuWRVwP0rda3rwZzGM3EwDN+9yv2lYa8rywCDVxBr4LVxcN1Lb/AgDr8AiIf0TqrFAEVsM
3Gb0zSp8VeUB7d3sb3IXVfW4jvQD8lZCT5M9+psrkOJoA49+QwbI45PLB4R0zCQueiq6yQ9w
obebmZAZFDgQ6FjzM0g1RzHLsAZr71onv+26mFU77Wm6YqehPF3qd52dZPzmos3cpIwNVKmD
Xm748rmtnpzAWsFitVuka21ErcM7tAG5nOHuts6eVAZCewgc83dqs8u5q/TgBSB5YcsHhGRv
EC4BjLpFN95VBNWkrdrcVuIW9wUtRcE74uHT9iaRMTZkij+P/rPrscPhYtFtB0K60bW8UIYS
Ag/E3kRd9L5bXzJoAnKnxt1C8nYY+Mk67+ME2gtwI9X12Cqj2OB9DqTDsrxATpRi1GoLHIya
EPnro8+c1yuwk7JUfJKFcfuiLbcHROtojFtwWaSpiuUFQjpVHjjXZY2Wv75TVrEm0SOwkyzx
jJMFeASyqEYaKha3YdF5PgdCKjcZlh1KbrD+UI7HucKg2seKGmisXPw6ZZs2K7mU7m4hVTh/
pfT3efX+oQQkEbUSgPAH9eK5ugApPbz8QOxjgK36QmkwS0CocTpOu1DQMK08LH7vyAZtQFK3
uVsI9dFKPTx5nHFAOqY72D54czlXFyAkzDRWBJSKcIMuULpjXF+3DBBs0YBBn7MIKL2IAyn7
tAG5XSXfK8v08KTYrj9IQEwfuN94bkBoVrESgJCOxvhvKQMFrteTTqPjW6LS9+E90Kmw+FGx
yw3IygE4U2ECmv6uCCRjE46tcT9fNyAP+kWzXilQqiK0Q0nY6QojFzP43FgJiBWDoaZY8Wff
t2gDkrhOvmucYXYHkrRf+t19r8mfsxsQ0tH0lWMl9qD7oW9QnqLgyz/ofg0fvyPBcKgrGV1X
HJO+Q5uVzCsMxI6i5plZVJPsWXBX1TuVr0cWyHjpygJiLxxRAVsPeI4rJXAV43BRd/rkp6C1
KSKE+TH0nZBhzY8z3ptnr0WEZI2ZVuFeeQs5hx5de5UEpBmB/nyM+LtH3vERCKkiZuVBIc0f
hdtBV3geaSIpH+0QW5L37DAOi35hQARynB60eYzAjmZgTAju5iT8/4j2OKI0y6cnxUox/z+a
xXjsTnEjHz1GTh1un4H0Zq9MIFr1i38XYWSbRRgOzQ2LWVecHxV75gblCWUhYkm+01NbCevk
rWMAo1xLqFOlLqdq89qA8gzuqoKyRwCJo4rdCUhbJawMrYt7/dpb8edT1e8Ri9koASkGKAut
MT3TvyCPQPpz1waQ2F2iddyZdrUOksnIhL4CjGWD3beOqhVt1lAD40KsBCP8A1cQqoCQ7B/7
usqB/OzfRCANJe5ASBYUi0P5aIlv0G4ljbu9A6lYyBYzg+VhqAIyXY0hjg51CQo0IePg0rdm
riEJqM4WgZiMru7KoXffsKfWwlCmHw8jqdhnTJsqEND5nSvyMFQBIWWH+mclw2iePTslvlaZ
cWktbsPvRRiPrstbB2kYd+1o7sJWWj8eRvL0OZWp60VXFbdX2TpUAyHZP1VHw4LcR6p5HlbW
i7w/Drl5Jzqk340uDYzvR8U/Q2G3jhB56yDFII5Y0FI5lu0fkG4PD5b2xSHWZHmG4ROQ65gZ
TFX7DmUMff4B6q4+ETV0HP42aWms5OVfiTBIZfnKFvIDPRiaJf7x5G8b/YNikpmRZG4RY0d6
hGcYPgEhTWCA1F+gbjFu9zLeRyNTHFdXJQEhpUYuwW4W3O1DjVKL5Ju7ykBIwVvhtors8wm/
n6NsQ//t4sLuxui3RBid0d5h+AzEoToUV9TNjEXW0JkpTvpoFFqKvLoBs/FTZdLvUkPPGQZp
bASBNi5wMGgAVZUhWUdhkmcYpH/5Z8bjdqAgTtEOYjaf8Y4j4gaIhM2MjySJMH5oZkJrVQCB
qNUTerCfnu144g5l458C47bWv+RqGaTeVu9AZnG+nzcu1CwaYAwlIqjDe1xBO+aLSqkCv46+
4PvrvMeOJQESG+IOwjmWVMXqB+UQXI7F5N7NJZ2f8g7EhFrkeBqCb76GmUidaBVR2zELgWWa
wtEfg9fIgBcYbFcHIuBAzB5gOLTu9/4DwfxaqMyUB0HKMXuHQXr2Azq+qEXi94iPbvsC5MCf
MZCKUG8FSw4k+mPGH33rHcgsWhl739EGhfpssaFSnFBSSZ46IKQazEZsGFhZQ9TDqMHvGnfq
A0N3INcQvPZtY8LDy+JiDDVhhlEiH0Oeu64+cfD/+TF1YExBAB7sHQRpolM9DNI//D3qpTQk
KLvVwfhbE4ZOiA9UWOoBg9ybbkCu4uRiDsJ3YloncFElGBZdOYF5BSr1uRl3MPSh9vG4I5NQ
4f73fzD+P//J+D/9I+ORgEqLQj7ZiMwnGPPnuFAMztq9Q3BWcbZvQOamxN0olzHOVbPnd9Nv
GbdncDrA+OoTDK62emm/qxVHWySS5sVcguHQrZsYk1aLd3R2vNjHqS9GAK3zbXF9VV6CcmWu
GNhRsU8jZW/CIids8RxH2pAERAeJrqoaXYwO+nsqPdpc1+Mv4SlQxW/fqBOQ//sl409/dIfh
rATMIfjNwEJwyFbgvRBUEgV22hdm3q0M5IcWcac6XBU/liVuJ3Io3cfgPn+WcYKx+Q3xpvUb
SD2ymKFBzzAcmr+GCrqN8Uo08uJx4ia4uLF2dfFAjUbR2d2PGMMfaYNBCtsmLuwVLHrTIXkg
215DSovKe7zQFYZDCQfVQemhD0CDp7B8xPjUMR2AkKt67111MJR0Hb4zChX+C79gPPmw73Ce
3kADEd2BF19gfGzYdze1WL95UVzUfMQs2gBBgdsZRjhmJvTnKiZK5GE4VJHmGUpamHg8tfyH
mqTr8QvIKy/Kxw01akEG1ka7x+dc1VeGFgwWOCNGGQ65vsRDjJdjvtCFu7Sv2z8IzsrLgEtC
0foI2d8kKm7q3cVsYpyGV7Svinpk3mA4lBvtDqW3WXRR9PMvWxmvyXW9Ns1AhnGiw0O+A3n2
FJ1XevRhzh2GnBLgq/NwYZ3I1LJhQRmHxO8/Oo8aoNB/i1is0+PoMGwXF6zfYt+z9TwdD96I
1DRTHQyHSsMZb8J5thQbeDntnXb62cY3XW+6wUY/gLz2qu8wuuEnT1Srh6GkPrQlzpzSH4ZD
O96WFm0OVmJCWyYxyDcQ3hT1gatltBQh6bmgEcjet30D8fAbJtTm+g+CZI8zAQLhULpZv4WX
k72yXwDx+FNkhWR1F/H1RQ1ApqwwrQH1MOhzQO6P+w+CLGuwN7AgHCpD+z5tj74W4VBxmASj
txbJQb0EQxOQN99Q56ouoDLvKdPHKkqRsfiTymrRS7/RH0ZFlFSLpR1yBaEJSOiH6qyirkwM
uv6C6MUsoacj8C5KTlXIpGqP6GclcXulwD1Q5g7CZyChQSpSWaR03cX+gzgJ99RYuTwgnBWB
VvxspXYId1Go2hLEOuMLVORlicogVAM5VcqEv76r7Kb4M4xIc+1/KsIvCE+RYeQgvS3MXn4Q
DqETzWkzdkWkOksZy2M8ERPH4+WwsCykzTY0VvG9/GgD9wbCI5DLDeKju+g/2dsdzgDO0qPE
mEVcPMmElFBtMYLcWWsO4xZc6FWkr9mWlQFATl+j8ZeKyeZOFIYJmATO4K6/iVbRZygcj8Eb
rH+dCf+KeXxZKtog+L4ZbZCzTeoWX07/D0I/I0c+pwKjAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTExperimentalExample >> exampleStackOnRoassal [
 
| s classes extent layers x y color area maxY dates |

classes := (RTShape withAllSubclasses reverseSortedAs: #ageInDaysRounded ) select: #hasMethods.
dates := (classes flatCollect: [ :cls | cls rtmethods collect: #date ]) 
	asSet asSortedCollection.
extent := 500@300.

s := RTExperimentalStack new 
	offset: #zero;
	values: [ :cls| dates collect: [ :d | 
			d -> (cls rtmethods select: [ :m | d >= m date ]) ] ];
	x: [ :asso| asso key julianDayNumber ];
	y: [ :asso| | temp |
		temp := 0.
		asso value do: [ :m | temp := temp + m numberOfLinesOfCode ].
		temp.
		 ].

layers := s stack: classes.
maxY := layers inject: 0 into: [ :max :arr | arr inject: max into: [ :a :each| a max: (each y0 + each y) ] ].

x := RTScale linear 
	domain: (Array with: layers first first x with: layers first last x); 
	range: (Array with: 0 with: extent x).

y := RTScale linear 
	domain: (Array with: 0 with: maxY);
	range: (Array with: extent y with: 0).
color := RTScale linear range: (Array with: Color green with: Color darkGray).

area := RTAreaBuilder new
	x: [ :d|  x scale: d x];
	y0: [ :d| y scale: d y0 ];
	y1: [ :d| y scale: d y0 + d y];
	data: layers.
area shape color: [ :e | color scale: Random new next ].
area interaction highlightColored: Color red;
	popupText: [:obj | classes at: (layers indexOf: obj)].
area build.

RTAxisConfiguration new builder: area; minValue: maxY; maxValue: 0; title: 'Number of lines of code'; titlePosition: -0 @ 320;numberOfLabels: 10;tickLabelOffset: -20@0;noDecimal; axisFrom: -15 @0 to: -15 @ extent y.

RTAxisConfiguration new builder: area; minValue: layers first first x; maxValue: layers first last x; title: 'Time'; titlePosition: -30 @ 0; labelRotation: -30; labelConversion: [:v | (Date julianDayNumber: v) ]; numberOfLabels: 15; axisFrom: 0 @(extent y+15) to: extent x @ (extent y+15).
	
^ area view @ RTDraggableView.
	
]

{ #category : #icons }
RTExperimentalExample >> exampleStackOnRoassalIcon [
	^ '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'
]

{ #category : #sources }
RTExperimentalExample >> exampleStackSilhouette [
 
	^ RTExperimentalExample new helper: #silhouette colorA: (Color r: 177/255.0 g: 175/255.0 b: 134/255.0) colorB: (Color r: 98/255.0 g: 101/255.0 b: 73/255.0)
	
]

{ #category : #icons }
RTExperimentalExample >> exampleStackSilhouetteIcon [
	^ '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'
]

{ #category : #sources }
RTExperimentalExample >> exampleStackWiggle [
 
	^ RTExperimentalExample new helper: #wiggle colorA: Color cyan colorB: Color blue
	
]

{ #category : #icons }
RTExperimentalExample >> exampleStackWiggleIcon [
	^ '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'
]

{ #category : #sources }
RTExperimentalExample >> exampleStackZero [
 
	^ RTExperimentalExample new helper: #zero colorA: Color black colorB: Color green
	
]

{ #category : #icons }
RTExperimentalExample >> exampleStackZeroIcon [
	^ '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'
]

{ #category : #utility }
RTExperimentalExample >> helper: method colorA: colorA colorB: colorB [

| num m layers0 layers1 s width height x y color area button elements |
num := 20."Number of layers"
m := 200."Number of samples per layer"
width := 960.
height := 500.

s := RTExperimentalStack new 
	offset: method; yourself.

layers0 := self dataFor: m@num stack: s.
layers1 := self dataFor: m@num stack: s.

x := RTScale linear 
	domain: (Array with: 1 with: m);
	range: (Array with: 0 with: width).
y := RTScale linear 
	domain: (Array with: 0 with: (self maxYValueFor: layers0 and: layers1));
	range: (Array with: height with: 0).
color := RTScale linear range: (Array with: colorA with: colorB).

area := RTAreaBuilder new 
	x: [ :d | x scale: d x  ];
	y0: [:d | y scale: d y0 ];
	y1: [:d | y scale: d y0 + d y];
	data: layers0.
area shape color: [ :e | color scale: Random new next ].
area interaction highlightColored: Color red.
area build.

button := self createExampleButton.
elements := area view elements.
area view add: button.
TRConstraint move: button below: elements.
button when: TRMouseClick do: [ | temp |
	temp := layers0.
	layers0 := layers1.
	layers1 := temp.
	elements doWithIndex: [ :e :i | e model: (layers0 at: i) ].
	area view addAnimation: (RTXPSVGAnimation new 
		on: elements
		during: 2.5
		path: area). ].

^ area view @ RTDraggableView.

]

{ #category : #accessing }
RTExperimentalExample >> label [
	^ 'Experimental'
]

{ #category : #utility }
RTExperimentalExample >> maxYValueFor: layers0 and: layers1 [ 

	^ ((layers0, layers1) inject: Float fmin 
	into: [ :max :arr | arr inject: max into: [:a :each | a max: (each y0 + each y) ] ])
]

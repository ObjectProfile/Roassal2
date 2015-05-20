"
RTCalendarExample new installTitle: 'VisualizationCSV' 
		code:
'
| b tab colors dictionary |
tab := RTTabTable new input: 'http://bl.ocks.org/mbostock/raw/4063318/dji.csv' asUrl retrieveContents usingDelimiter: $,.
tab removeFirstRow.

dictionary := Dictionary new.
tab values do: [ :ar | | value |
	value := (ar fifth asNumber - ar second asNumber)/ ar second asNumber.
	dictionary at: ar first asDate put: value ].

colors := #(#(165 0 38) #(215 48 38) #(244 109 67)
	#(253 174 97) #(254 224 139) #(255 255 191) #(217 239 139)
	 #(166 217 106) #(102 189 99) #(26 152 80) #(0 104 55)
  ) collect: [ :ar| Color r: ar first g: ar second b: ar third range: 255 ].

b := RTCalendarBuilder new.
b dateShape rectangle size: 15; color: Color white; borderColor: Color lightGray.
b monthShape shape: (b monthShapePath: 15.0).
b yearShape composite: [ :comp | 
	comp add: (RTLabel new text: [ :d | d year ]; height: 20 ).
	comp add: (RTBox new color: Color transparent). ] .
b dates: ((Year year: 1990) to: (Year year: 2010) ).
b dateLayout gapSize: 0.
b monthLayout month.
b yearLayout horizontalLine.
b dateShape if: [ :d | dictionary includesKey: d ] color: 
	[ :d | | value index |
	value := (dictionary at: d)+0.05.
	index := (value * 11/ 0.1)+1.
	index < 1 ifTrue: [ index := 1 ].
	index > 11 ifTrue: [ index := 11 ].
	colors at: index. ].
b dateInteraction popup.
b build.
(b view elements select: [:e | e model isKindOf: Month]) pushFront.
^ b view


'
	
"
Class {
	#name : #RTCalendarExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Calendar'
}

{ #category : #sources }
RTCalendarExample >> exampleBasic [

| b |
b := RTCalendarBuilder new.
b dates: (Date today to: Date today next next).
b build.
^ b view

]

{ #category : #icons }
RTCalendarExample >> exampleBasicIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAB0klEQVR4XuXYvWoCQRSAUR/Q
d7K3sxK0WhTc0idQ/CnEwk4LRUERKxEsxEK4G2aLtIEQo8n5YIsdmGYOOxe2UhR+71TFPwIf
xM8H8UH8fBAfxM8H8UH8fBAfxM8H8fNBfBA/H8QH8fNBfBA/H8QH8fNB/HwQH8TPB/FB/HwQ
H8TPB/FB/HwQPx/EB/HzQXwQPx/EB/HzQXwQPx/EzwfxQfx8EB/EzwfxQfx8EB/kT9VsNuNw
OMTpdIpWqxW73S6u12v4IC8qz/Not9txPB6j0WhElmXR6XR8kHfodrtFv98P/8r6pdLVNBwO
i+88k8kkfJAfLs2HV+z1Qb441DQz0hCfTqfl+3K5jNFoFOkruN/v5Vqv14vH4xHj8Th8kCeD
1Ov1clZUq9XPQ+52u1Gr1Yr0pBLGer2O+XzugzwbZDAYxH6/Lw88va9Wqzifz7FYLGK73ZZr
s9ks0pDfbDY+iD9DEJDL5RKv2OuD+L9O/HwQPx/EB/HzQXwQPx/EB/HzQXwQPx/EzwfxQfx8
EB/EzwfxQfx8EB/Ezwfx80F8ED8fxAfx80F8ED8fxAfx80H8fBAfxM8H8UH8fBAfxM8H8UH8
fBA/H8QH8fNBfBA/H+Q/9gEUtn5Gru2F5QAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTCalendarExample >> exampleMonth [

| b |
b := RTCalendarBuilder new.
b dates: (Month current to: Month current next).
b build.
^ b view


]

{ #category : #icons }
RTCalendarExample >> exampleMonthIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFOklEQVR4XuWa10vtShTGz5+n
b4Lvgvrmk/okItixvagPYsGGiBW7IvZeUVRQUezYGyr2sjz3C3eFJLjvLudc93Z/HwSdJGsy
mV+yvpnJ/vX5ya9A0i/+LuAHwi9+IPxA+MUPhB8Iv/iB8APhFz8QfiD84gfCL34g/ED4xQ+E
Hwi/+IHwA+EXPxB+IPziB8IvfiD8QPjFD4QfCL/4gfAD4Rc/EH4g/OIHwi9+IPxA+MUPhB8I
v4IESH5+vkRFRcnm5qasrKwI9j09Pcl3tgHXxt/T01OZnJyUmZkZeXl5EUogMTExEh0dLVtb
W9La2iqxsbHf2hEfHx+yu7srUEtLi/T19UlkZKSMj48Ldcp6fX01OqC+vv5bO+L+/t643sPD
g3ndt7c3CYqUhafKX9vBwYHRie3t7X5rQ8AB2dnZ8duTpdf2ZxuogBwdHdnqXl1dlbm5OfEU
iLt4eAjeLus5U1NTtjLM/vHx0dyHAcDFxYVQAvlK3d3d8idviDUeKiwstJXDw8PNVAjB9K0e
NzExIW1tbZxAhoeHPwcHB8VaTk5O9jhluYuHkTuBWI0eKisrEx18QOvr6zI9Pc3/hvB7CD+Q
nw1kZGREysvLbR3T2NhoK2dnZ9vKubm5xuTMehyTNC3X1dVJZ2enWW5qapKcnByXHuJtPCaD
PT09kpWVZeyrqqqyzYswCNB26moC/m9oaBCn+QcckOfnZ8EN637c6OzsrK3R1hEONDY2Jufn
5+a+2tpa2/H+/n5jJq3lq6sriYiIcAnE23h0blpammRkZIi1fc52lpaW2mJQz9+ezP51IO/v
7+LpDFllHU5+JflXzmUPT1OWu3iVt+toTuPn9xB+D+EH8qOAqNkhF6upIseqKaqBolxUVGQa
KNKcrvTquc3NzTYDTUpKEoz9tc6BgQHB5MwJxJd4XeGNj4+3mbqavNaZl5dnltF+630G7Bvi
yiCdIyrtDD1eXV1tO29hYUEwQNAYQEtPTzdjurq6ZGlpSVy9Id7E6+gJ+/Q4lkWsIzMIEABY
22+9z4BOWb58ZHJnkM6BgJq1pynrv+JdyXkf7sr8HsLvIfxAfhQQ5GzNx2tra6KTMviDLu7F
xcUZebekpMQ0SBjw/Py8Ub67u5Pi4mLBeXock0v8hYEiteE4vnvjm7wTiC/xSD2Yl6iH6Lnb
29u2NunkUuu03mdAAsFqKIyzoKDAbCSWUpaXlwWzcZRxfH9/XyoqKkRnv5il/7MCa5Qx2kEH
qAHjhjEiwnnoTKi3t9eoQzvFCsSXeDxEuD5GYtqmvb098yHSOkdHR+Xy8lK0Tut98qcs/pTF
D+RHAsGCm3Wt6Pj4WG5vb40NZaQK/NXPqicnJ4IPRIeHh2a+RizirIuB1jLORYz+QsTpId7G
BzUQmGFlZaXc3NwYZZh3TU2NwEtQBhgsfXd0dJidgS9vaqgao7NkrTMzM9OchMEfNjY2jO2r
N8Tb+KAFMjQ0JImJicbTiO3s7ExCQ0MNc9QlhrCwMGMGnJCQYJRDQkJgqJ9qwikpKca3aoyA
rq+vzTrRyfh1I57q1NRUoz6t0wrEl3h+D+H3EA4g+Dkq3jZ/bAEJBKupSBHfnQqC4c34394Q
zMqdK7z8QPwEZHFx0RhN4dfsuvTND4TYQ/iBWIQhpr9uwp/XDlgg/OIHwg+EX/xA+IHwix8I
v/iB8APhFz8QfiD84gfCD4Rf/ED4gfCLHwi/+IHwA+EXPxB+IPziB8IPhF/8QPiB8IsfCL/4
gfAD4Rc/EH4g/OIHwg+EX/xA+IHwyy/6DSC1D9R8yJyVAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTCalendarExample >> exampleVisualizationCSV [

| b tab colors dictionary |
tab := RTTabTable new input: 'http://bl.ocks.org/mbostock/raw/4063318/dji.csv' asUrl retrieveContents usingDelimiter: $,.
tab removeFirstRow.

dictionary := Dictionary new.
tab values do: [ :ar | | value |
	value := (ar fifth asNumber - ar second asNumber)/ ar second asNumber.
	dictionary at: ar first asDate put: value ].

colors := #(#(165 0 38) #(215 48 38) #(244 109 67)
	#(253 174 97) #(254 224 139) #(255 255 191) #(217 239 139)
	 #(166 217 106) #(102 189 99) #(26 152 80) #(0 104 55)
  ) collect: [ :ar| Color r: ar first g: ar second b: ar third range: 255 ].

b := RTCalendarBuilder new.
b dateShape rectangle size: 15; color: Color white; borderColor: Color lightGray.
b monthShape shape: (b monthShapePath: 15.0).
b yearShape composite: [ :comp | 
	comp add: (RTLabel new text: [ :d | d year ]; height: 20 ).
	comp add: (RTBox new color: Color transparent). ] .
b dates: ((Year year: 1990) to: (Year year: 2010) ).
b dateLayout gapSize: 0.
b monthLayout month.
b yearLayout horizontalLine.
b dateShape if: [ :d | dictionary includesKey: d ] color: 
	[ :d | | value index |
	value := (dictionary at: d)+0.05.
	index := (value * 11/ 0.1)+1.
	index < 1 ifTrue: [ index := 1 ].
	index > 11 ifTrue: [ index := 11 ].
	colors at: index. ].
b dateInteraction popup.
b build.
(b view elements select: [:e | e model isKindOf: Month]) pushFront.
^ b view



]

{ #category : #icons }
RTCalendarExample >> exampleVisualizationCSVIcon [
	^ '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'
]

{ #category : #sources }
RTCalendarExample >> exampleYear [

| b |
b := RTCalendarBuilder new.
b dateShape if: [ :date | date weekdayIndex = 1 ] color: Color red.
b dates: Year current.
b build.
^ b view


]

{ #category : #icons }
RTCalendarExample >> exampleYearIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAASg0lEQVR4XuWd968VRRTH779m
iBETjRr/AjGa+JtRwYK9YMGKYgGNEhuosTdsNBXFXrGggKBgxQYqwsH5DPvdnJ3de+9e2Hvf
880kN+9tOTtn5uzOKfOdM70DB/Iv06n08u+CjAXyxRdf2KOPPmrToeHwwt9Vq1bVrq1fv35i
PL733nuVunovvPCCvf3223bTTTfZfffdZzB6//33j4WhZ5991r766is7/fTTbdGiRfbaa6/Z
vffea7/88ouJueuvv97OOeccW7Zsma1evXpsHQMv11xzjV100UUH5syZE+tbunSpff3113bt
tdfaW2+9NRGhPPPMM7HuhQsX2t133229119/3V566SX77LPP7P33349MwNA430pegF27dsXG
f/jhh6a3kuN33303nrv55ptt3F/IDz/8YK+88opR96effhr7AB74f9OmTRMRCP3/3Xff2e23
327bt2+33rp168z/XnzxRUvPDfpt2bIlMv7xxx+PRDfs99hjj7W+9/fff488rF27tlMeRvmp
gw+V/rnnnot/D1uH8Eb5v1NRpgMPE1XqP//8c6WhfFqjdMYgeso///xTOf7xxx9tz5491u8Z
v/32mw3iwfburdDyBe3fv79y7qeffqoc88xBPPIMiudHuq+r8scff7T7QlD8/viyyy4bSSCD
6CkPPPBA5XjBggW2c+fO8tzKlSttzZo1lXu8tVYTyIYNNV7uuOOOyrkbb7yxcnzEEUdUjufN
m1c5PuGEE+JY78+9/PLLnQoEI6MmEMxAXxFK77zzziuP//33X7vkkkv6CyTQ2wj0FJTo33//
XZ7D2vFCxNrCGvE0KOC+Apk71w44c/biiy+2xx9/vLx/48aN5jucr/HMM8+sPB8e/Zd7+eWX
25NPPlmh6dr8PfLII/PXITPOMcxfIB0L5KqrrjLvrb766qsVM45xk3N+ONm9e3d5rjZchPM2
Ar2GJkxW/n7yySem8ZS/f/31V7x3xYoVkc7fK75rPATbPjg6ZZ3c/84771SOcUrxAcST6hFP
+/bts7vuuqvCk/wz3YuhwP9NHWtXXFE5z7DrvXKGv6efftq8QueZPfkRKrfeemvJCIWx95hj
jjGvePBu+TV2RqC3Eeg3FAp4Q6KI33zzzQoNFo0cV+6lMX15eOghM2cEYON/8MEH5TH0X375
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'
]

{ #category : #sources }
RTCalendarExample >> exampleYearShape [

| b |
b := RTCalendarBuilder new.
b dateShape if: [ :date | date weekdayIndex = 1 ] color: Color red.
b yearShape composite: [ :comp | 
	comp add: (RTLabel new text: [ :d | d year ]; height: 20 ).
	comp add: (RTBox new color: [:d | 
		(d year % 2 = 0) 
			ifTrue: [Color lightGray alpha: 0.2] 
			ifFalse: [ Color lightGreen alpha: 0.2 ]]). ] .
b dates: (Year current to: Year current next).

b build.
^ b view



]

{ #category : #icons }
RTCalendarExample >> exampleYearShapeIcon [
	^ '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'
]

{ #category : #sources }
RTCalendarExample >> exampleYearWithDayNames [

| b |
b := RTCalendarBuilder new.
b dateShape composite: [ :com | 
	com add: (RTEllipse new color: [ :d | 
		d = Date today
			ifTrue: [ Color blue alpha: 0.2 ]
			ifFalse: [Color transparent] ]; size: 18).
	com add: (RTLabel new text: [:d| d dayOfMonth];
		color: [:d | (d weekdayIndex = 1) 
			ifTrue: [Color red] 
			ifFalse: [ Color black ] ]) ].

b showDayNames.
b yearShape composite: [ :comp | 
	comp add: (RTLabel new text: [ :d | d year ]; height: 20 ).
	comp add: (RTBox new color: [ Color blue alpha: 0.1 ]). ] .
b dates: Year current.
b build.
^ b view


]

{ #category : #icons }
RTCalendarExample >> exampleYearWithDayNamesIcon [
	^ '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
QmCC'
]

{ #category : #accessing }
RTCalendarExample >> label [
	^ 'Calendar'
]

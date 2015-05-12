"
RTTimeLineExample 

b := RTTimeLine new.

b addEntry: (RTTimeLineEntry new identifier: #WP1; start: 0; end: 5).
b addEntry: (RTTimeLineEntry new identifier: #WP2; start: 5; end: 8).
b addEntry: (RTTimeLineEntry new identifier: #WP3; start: 7; end: 10).

b axisX numberOfLabels: 5.
b
"
Class {
	#name : #RTTimeLineExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-TimeLine'
}

{ #category : #sources }
RTTimeLineExample >> exampleClassAges [

	| b e |
	b := RTTimeLine new.
	b extent: 500 @ 500.
	((RTShape withAllSubclasses sortedAs: #ageInDaysRounded) select: #hasMethods)
		do: [ :cls | 
			e := RTTimeLineEntry new.
			e identifier: cls.
			e start: cls computeYoungestMethod ageInDays.
			e end: cls computeOldestMethod ageInDays.
			b addEntry: e ].
	^ b 
]

{ #category : #icons }
RTTimeLineExample >> exampleClassAgesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAKH0lEQVR4XuWdR28UTRCG/T/4
CZy5ckLiBhIinggXhBCIA0kgcs4554wBEUww2eScTM6IZJkMJhgTapmn+NoaL5/N7pruXU+1
NNrdmV3b26+7qt56q3qKUqlU6ufPn5L6b3z+/FnWr18v1dXVeo5rV65cqb3uc5w/L2L9KHKT
cfToUTly5IicPn36j8kPBYj9kUoVrVq1SubOnStlZWWp0tJSmTp1aoTUeenRo4csXLhQJk6c
KO3bt5fZs2fbByUEIHfv3pVdu3bJjRs35MKFC3Lz5k25d++erpSVK1fK5cuXZfXq1fLu3Tv7
gIQApKGLHz9+VJDs+5CAPmTr1q0yaNAgGThwoIwePVqOHTumK6ZLly4Kwvbt29VcTZkyRQ4e
POgVmMhCivWjqG/fvmqatmzZIosXL9ZJ37Bhg3Tq1ElGjBiRIuJihQwfPlxu3bplHxDfgGQy
UU0hyoqidUnCoSaLVcCqqKysVJOFmbp+/bps3rxZxo0bJ+3atZNXr17pKvr69ascOnRIj/v3
7+vnCgGQxKyQL1++KCBM9pIlS+Tq1asyc+ZMuXTpkk708ePHhaOkpERfw1Xatm2rnzl16pR+
7vXr12IfkH9osr5//y4w9PgXdOwdwM6dO1fnmkQDQByzL4QVkpgoa+nSpboCYOoVFRXSVH1I
IY6cVgiRlctf4U8IbwEJ1t6vXz8Nee0DEhAQ0iSwcCYdlk66BPa+Z88eJYXumv3pDQTI4cOH
65gqAHLPASgbkxUFZmKfbTfSh4wdO1ZNFKti//790r9/fw19MWWYsGwAKS62T+waHWUBSJs2
bWTWrFmaSMRvENqSRlmwYIF9QCwz9aSw7UYxdRg35onQF9aNT8Ghk37fsWOHPH36VNatWyf2
yV2gFcJkL1++vJatI1YBCP6DA5/iSKB9QAIAEmfa9bFul0axz7YDRFnz5s1Tk4R5wpk3Vaae
mBWC5gEB3L17t6xdu1Y1dPQRHu0DkgdASBw+f/5cWTrPIYY4djK59gEpgLD34sWLdZg7QDlA
HHO3PzwWOUAA+/Tpo0nFyHxJt27dlLmXlZWpnEuUReQVZ+72h0dAmOg5c+bI4MGDZcaMGdKz
Z09l7qiE+BeYO9fjzN3+yFMZUNyHMOwz6QBMnWoSwl6iLKIrclo8YrLQzDFZrI5v3+yTtiBO
HXZOZLVp0yaBk4wcOVIePXokK1asqC0DQmO3D0geoqxPnz79wdrR1DFZP37YZ9FBmDqVJpis
8vJyOXHihH1NPU8jyu3+XiGEsjB1srqYJqKt8ePHy8uXL8U+IHkAhII4mDrMHP2cuixS7y9e
vLAPSD4AOXnypK6QQhCoQo2QPiFrHjJq1CiNsKiAh5EPGzZMTRf6OvIufiVpgISMmrIGhEkf
MmSIcg9CXDhH8+bNVV+HtbOC7AMSEJCGLmZbBpS00VjWzcgaEDR1TBY5qzNnzkhNTU1tghGd
HeEK1o7ztwZIY1dHROGyBwQOQk8hfqN79+7SqlUrBYPDlZd27txZQsm45gGBkcPQGVTBc5Ie
kPQoK97LbmU0NsIi3ZQ1IFQpNvSGt2/fauG1JUecL4eugNAhhf/AVNEaTaEDpopUSseOHTWt
wjVCYszYtm3bxD4gHgGBZ0AMqcX68OGDNnbC1gFm7969cufOHfUvdOYSdZGStw+IR0D+xtIZ
FNLZT24EUgwxQU4/x1RNmzZNJk+erOaLpk+eo7nbn6pAgABCr169VIxiYJJg7zB1XpNSGTBg
gH1AQgGSyZvsZ3sDAoJ8y8FKoXKRRxg7FSauJ33ZsmW11fH2S4E8A4I5onsKIM6ePauPMHYO
15MOIIhWrpfd/rR5Nlk/IsGcR/Rz2Lpj7AwYPCbrW0Q7YfWF0peeWEAWLVpUa4ZQDu37kDwD
wk5ybmCuEKZcf7p9QPIAiNs2g/1KYOg8d/3p9gEpoLD3/fv3fwASWTTTNVN8f++AUEJKyQ9h
La0I5LZ27typG1/yBiTc4uJiPc8fZbmqMJeihawBQUvHXxDOkmqHd5BKofq9qqpKHT7XOG8f
kACA2GfqBeZD+M9nG1hyWDxinshjkVx89uyZVsU7QFxPO8/R3e1PnwdAEKBIiZBgJOwl6iJt
gh+BoaOTwODprlqzZo22K5CIRKyyP30eAPk/5p2un7sVEmfq6bq7/fEPfciTJ0/qnVwiL5TD
9POZCFv2Rw6AdOjQQTZu3Kgy7ZgxYzShSNTVtWtXNVGcJ8qixJSIDG0dE4cpsz99HgBhdZA+
QS/ncJslP3z4UFsU3Aqhd53qE95LpQoZYvvT14TC3srK5DD0x48l2D9fEbuREtpSLMdzIipW
AAfVipSZYray/cHl5ckhhFGSQoKuEPgFoHBXHQAg/KX4wW3b1Lt3b/uA5MNksZ34mzdv6uxz
km6yqFe1duRSxZ4zIOSqGDBw2tiIotjrhPPsBU9ykV529wGLOaxIQA0LCGU/MHCeY6YwYW5H
OULieKGcfUA8A+LubpDO2OOv43u/W9RBosSF5C3sdZNPnS+7OdCRm0nYm5TUfCSU5pVfFWGq
YOfcrY0iB3oM58+fL9OnT9fsr9stiPeR4yIc5nX6xpj2AflHgJBih50jTgEMB4Vy1PoeOHBA
2TuFD7dv3xbKhWDwXKcsyD4gHk0W4S6PLsSLh3o+BaqIe+bdRxRU6sRt5+daol3lCY+sDNg6
vsTXHxBJLk2yj8MrIHRLEW1NmjRJfQMlQc5HcDs9nztb2wckUHKR2D0Uk86lubJgs72sBBw7
Orq7Wxv6OmU/Tm+fMGGCuJuD0ULN+b/94Chrn6hqkKArxOnoAPLgwQNp2bKlauhONwcQrnE0
a9YsIxNmH5AcAaHinSdwDKre03eVczvK1cfi6xuRa0pURWEwQFgdbJ+BFsKJ+u6nDln8PdEV
GX35kCskUYrh0KFDdR8TUiWQQhKK1GaxISbCFFo6NVitW7fWL07vOtlfzjd0Q0n7gOQIyL59
+1ScQjuHsVNNwipxGjtaOnduw58AAAIW7+G8/RVSYGFvVZVdRu1VD3FRE82frBLKfQh7nb+o
DxAct1UC5w0QQCBF4hg7rQmIUpgm+4AkiKnHR02NSHV1WOWtyQLibkMBC3dMHQfuetQhhVzn
fK43BystTR6B8waI09LpQ3d3aiPJGL9vOlGWu4ObfUA8A+JYN4JT+n3VnSaCyeJ8vH89mxGl
vxLHqL36kDj7ZmVQ+gMvcX3r9juoAgKClo45oje9RYsWytjxG24TTCIwGkDjfev2h0dAWBGk
TmDfVCyimRP+UszgtmgiBR/vW7c/PJssp6dnEvaGLKs0u0KInsj4ktMqKSlRHR1TRSYYfwJR
ZI94PgBh5L1UpdifPg+AMOGkTuAjgEHZKDo6oS+7XNM9RVhMxxTJRbK9vJdMMNXy9qcwD0yd
iAs/4/O4du2a/d8RHRkBwi/x/Z/hyo+a+u8gIPK+QuyPcOMXfpWNeoiPbiEAAAAASUVORK5C
YII='
]

{ #category : #sources }
RTTimeLineExample >> exampleColorPerEntry [
	| b d |
	b := RTTimeLine new.
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 6; end: 8).

	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 8; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c3; start: 0; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c4; start: 5; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c5; start: 5; end: 8).

	d := RTVerticalTickLineDecorator new.
	d shape line color: Color white.
	b addDecorator: d.
	b axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :v | Date year: 2015 day: v ]. 

	b shape color: (RTMultiLinearColorForIdentity new objects: b entries).
	^ b 
]

{ #category : #icons }
RTTimeLineExample >> exampleColorPerEntryIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAE5klEQVR4XuWca0sjSRSG/YOC
CP4Nv/lFBUWRBXEVQbwi3vGGQVcNIuMlKl4yLIpRNzPRmE0wxjhJJ9lcZzKn19OQLzMVqJ5N
YtW+Lxwaijehup/uqnOqL3WmiS+VVId/CPCB4AsfCD4QfOEDwQeCL3wg+EDwhQ8EHwi+8IHg
Cx8IPhB84QPBB4IvfCD4QPCFDwQfSG2Uy+XIjp/eVAl/JpWhp4ennyL2HBO2l4vkl0RV+19z
IMlk8l2APD+G6djhMn+MTx//MkXt5cLvecAHgg+kArq9vaWXlxfCB6IAEIbh8XiotbUVH4gK
QMbHx+nu7o52d3fxgeDPIfhA8IHgA7HvL+QLlIwbP0UmnRa2lwu7/lwmiw9E1J4yEuT3+swf
IxqOmKL2cmHXH4u+4gPBB1JGe3t7hA/kVY06ZGpqitrb2/GBqACE6xDexuNxfCD4cwg+EHwg
OgNJJAyKGJfSYaQDtvwJm/5q/38q+6Q2ECMRo/NPfaZs+MLbph3//bNdv7Oq/r+jLnwg+EAE
CgQCdHR0RPhAXGrUIbzt6urCB6ICEK5DvF4vOZ1OfCD4cwg+EHwgOgNJGgZl/3RLR95/b8//
+CBsLwT8VInCs/itQMbjR+nIxkKKF4axGEV/6zRlI/nHmmnP7xC3b61XBMi3XIo+b3aZsvF6
9wEfCD6QMqmv2+0mfCAf1KlDtre38YGoAITrkIODA7OjowN/yMKfQ/CB4APRGkgyQVdfItIR
SNn1G8L24D/i9zq+fy+SEX+Rjmwm9f96UC72doPqd8+ZKRvOkM+shH8ndC88MF+/Fuiz123K
xms0iA8EH0gFlM/naWdnh/CBkDp1SG9vLz4QVd4Puby8JFEdgg8Efw7BB4IPRCMg/PDDzc2N
dFxdXWnt51f7lAYSCtm7YWPXHwwGtfbXHAi+NAbCtYzO/ouLC1IaCKfDg4OD0p3s7++ns7Mz
bf1ra2vU2dmp5pD1VpNYTzKKblqJ1NfXZ/kODw+19HMd9nZPiGT9NQUyMjJC19fXVF9fL9U5
3hGGNzY2pqWfv2CxuLhI+/v7ag1ZnPL19PRYl+3GxoZU56anp60vQAwMDGjpZ2hDQ0PU1tZG
yk3q/DhpJBKhiYkJqc6VLu+TkxMt/cfHx5avsbGRlMuyOMNoaGgg2UqV642FhQXpQko1P8Pb
2toSPs/8rkB8Pp811k5OTtL6+rpU5/gM5J3nl0S5utXNz5nX8PAwuVwuKq10KwOEx0/umGy6
d3p6ai1HbG5uaun3+/3Ey0EzMzOkXGHIwxSnh/yOumwqyWfj6uqqln7+MAInLd3d3aRcpX5+
fk7z8/PW1SHjj0ajllf2TFTNz0MzF4oOh4OUWzrhHJ0nNZk8nbMu3vLO87irm58VDoetVFj0
gbZ3B8LLA01NTdI7U6raSymijn4uFCsxeVcUSDqdppWVFWpubibRR2bKFVmls1HG39LSYsvP
/SkNPXaWQ2T9pQqcJ/FfufFU9StkaWnJmjfs/Ea2yGLxutfy8rK0n69UzvJk/XyAZYvWubk5
a1j+LxV4VYAUi0UqLZyZYBodHa3JPtfZXQ6ZnZ395YUzfFVhyOIqHP+wKQQEX/hA8IHgCx8I
vvCB4APBFz4QfCD4wgeCDwRf+EDwgeALHwi+8IHgA8EXPhB8IPjCB4IPBF/4QED0L6DGXb+3
QA7lAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTTimeLineExample >> exampleColorPerTimeLine [

	| b d |
	b := RTTimeLine new.
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 6; end: 8).

	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 8; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c3; start: 0; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c4; start: 5; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c5; start: 5; end: 8).

	d := RTVerticalTickLineDecorator new.
	d shape line color: Color white.
	b addDecorator: d.
	b axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :v | Date year: 2015 day: v ]. 

	b shape color: (RTMultiLinearColorForIdentity new command: #identifier; objects: #(c1 c2 c3 c4 c5)).
	^ b 
]

{ #category : #icons }
RTTimeLineExample >> exampleColorPerTimeLineIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAE1UlEQVR4XuWc20sjSRTG/QcF
Efw3fPNFBUXxRVzFRbwi3tcbut4RwVt0jbrrxNUkuJPdRJMxMZntJO1lNDvh9Hoa8jLTgaqZ
Tqya74NDoPmU6vzSVeerdLrCsvClkirw3wJ8IPjCB4IPBF/4QPCB4AsfCD4QfOEDwQeCL3wg
+MIHgg8EX/hA8IHgCx8IPhB84QPBB1IePT8/k4yfXuWG/8l4ots/b78qI2I4Hi9WZtws6fjL
DsQ0zTcBkvAnyPPzgfVlXW39ZTkdL1bhwzA+EHwgLigQCFAymSR8IAoAYRiXl5dUX1+PD0QF
IIODgxQMBmlrawsfCP4agg8EHwg+EHl/7uWBTCPyVX16SDkeL1ay/ucnAx+I0/H79A1F/GvW
l5WK+Syn48Xq4wc5v5EI4gPBB1JE29vbhA8kqEYOGRkZocbGRnwgKgDhHMKv6XQaHwj+GoIP
BB+IzkCy2SxFIu+FK5WKS/oTSvkN46PaQHhdWVn5xRKts7MjS8b/7l2p/V4pfyDgwweCD8RB
19fX5PF4CB+IT40cwq8tLS34QFQAwjnk6uqKNjY28IHgryH4QPCB6AyEc0gynBCubDLjit9M
ZcmN4Jn/nJcaz71hqg0kk87Q6a+/WaL1z+/vLSn/H87+8FnIFSC5Tzmp8Uf9EXwg+ECKtL6n
p6eEDySiTg5ZX1/HB6ICEM4hu7u7VlNTE/6Uhb+G4APBB6IzkKyZpfN/74Tr+l7Wn3E8Hn1w
ziG5fF7q/98+3v9YN8oZ2Qz9dOm1RGsjFrLc8G/G/nb+JvG/nNR4PIkbfCD4QFzQy8sLbW5u
Ej4QUieHtLe34wNR5fchPp+PnHIIPhD8NQQfCD4QjYDwzQ9+v1+4zs/PtfbzT/uUBhKLxaiU
/mg0qrW/7EDwpTEQzjI6+09OTkhpINwOd3d3Cw+ys7OTvF6vtv6FhQVqbm5Wc8p6zST2nYxO
X1o5qaOjw/bt7e1p6ecc9vqdEIn6ywqkr6+PLi4uqLKyUmhwfCIMb2BgQEs/P8FienqadnZ2
1JqyuOVra2uzL9vl5WWhwY2OjtpPgOjq6tLSz9B6enqooaGBlFvU+XbSu7s7GhoaEhpc4fI+
PDzU0n9wcGD7qqurSbkuizuMqqoqEk2qnDempqaEg5Rqfoa3trbmeD/zmwIJhUL2XDs8PExL
S0tCg+NPIJ8832bK6VY3P3devb29tL+/T4WdbmWA8PzJAxNt946OjuztiNXVVS394XCYeDto
bGyMlAuGPE1xe8i/URdtJfnTOD8/r6WfH4zATUtrayspl9SPj49pcnLSvjpE/KlUyvaKfhJV
8/PUzEFxcXGRlNs64R6dFzWRPp27Ln7lk+d5Vzc/Kx6P262w0wPa3hwIbw/U1NQIn0whtRda
RB39HBTdWLxdBfL4+Ehzc3NUW1tLTg+ZKRayCp9GEX9dXZ2Un8dTmHpktkNE/YUEzov4t3zx
VPIrZGZmxl43ZP5GNGSxeN9rdnZW2M9XKnd5on5+g0VD68TEhD0tf08CLwmQfD5PhY0zC0z9
/f1lOecK2e2Q8fHxb944w1cJpixO4fhvm0JA8IUPBB8IvvCB4AsfCD4QfOEDwQeCL3wg+EDw
hQ8EHwi+8IHgCx8IPhB84QPBB4IvfCD4QPCFDwRE/wNQxCWw1JBh9QAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTTimeLineExample >> exampleGantt01 [

	| b |
	b := RTTimeLine new.
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 6; end: 8).

	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 8; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c3; start: 0; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c4; start: 5; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c5; start: 5; end: 8).

"	b addDecorator: RTVerticalTickLineDecorator new."
	b axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :v | Date year: 2015 day: v ]. 
	^ b
]

{ #category : #icons }
RTTimeLineExample >> exampleGantt01Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEJUlEQVR4XuWcSUsrQRSF/YOC
CP6N7NyooETciCiCOCLOOKEoDgRBY5wVp2gcQBBxwgF048KF3LzcfvQuPqqfSXeV34EimyNW
5+uquqe6UyXZLF82qYT/FfCB8MUHwgfCFx8IHwhffCB8IHzxgfCB8MUHwhcfCB8IX3wgfCB8
8YHwgfDFB8IHEo5eX18liot8exPJZH7e7u9FfhWQdDodCZCLC5HOzp+3ZJIPhA+kEDo7O5Pn
52fhA7EAiMI4PT2VqqoqPhAbgHR3d8v5+bksLS3xgfDXED4QPhA+kOhySBi5hT9CithWVvhA
+EC+0/LysvCBWABEc0hfX5/U1NTwgdgARHPI34X0jQ+Ev4bwgfCBuAxkfz8dSR6IqlmfQzY3
05HcqVE160cIH0hEQG5ubmRtbU34QCzJIfoZj8f5QGzJIZeXl7K4uMgHwl9D+ED4QFzPIbkl
JvT28FCYB0vv78H+Lz+HFPlJX9DEz5+y+EC+L3339vaED8SiHLKwsMAHYksOSSaT2draWv6U
xV9D+ED4QPg5pHA5RN/XKnau4I+QACMk6B3/695c5AOJCMjn56ckEgnhA7EAiJ9DGhsb+UBs
AKI55OjoSFzIIfw1hA+ED4QP5B86PDyUTCZj3IL6Dw4OrPJrsxrI3d2dFNN/e3vrtD90IHw5
DESzjMv+3d1dsRqIlsOtra3GnWxubpbt7W1n/VNTU1JXV2fnlJXLJN6bjPkeWuVTU1OT51td
XXXSrzks90xITP2hAuno6JCTkxMpLS016pxeiMLr6upy0q8nWIyOjua23lfsmrL0NIeGhgZv
2M7Ozhp1rr+/3zsBoqWlxUm/Qmtra5Pq6mqxblHX10mfnp6kp6fHqHP+8N7Y2HDSv76+7vnK
y8vFuipLK4yysjJRmeaNkZER74wUF/0Kb35+Pu/7zJECubq68uba3t5emZmZMeqc3oF68foj
UZNka5tfK6/29nZJpVLi73RbA0TnT+2Yabm3tbUlx8fHMjc356T/+vpa9LcwAwMDYl0w1GlK
y0P9jbppKal34+TkpJN+PRhBi5b6+nqxLqnv7OzI8PCwNzpM/C8vL57X9E60za9TswbF6elp
sW7rRGt0XdRM6nStuvRTL17nXdf8qsfHR68UzndAW+RAdHugoqLC+GL81O6XiC76NSgWYvEu
KJCPjw+ZmJiQWCwm+Q6Z+S5k+Xejib+ysjKQX/vjTz1BtkNM/X4C10XctJwPdYSMjY1560aQ
vzENWSrd9xofHzf260jVKs/Ur1+waWgdGhrypuWfJPCiAPn6+hJ/4ywLU2fuGW4Y/6ck6HbI
4ODgf2+c8VWEKUtTOP9rswgIX3wgfCB88YHwxQfCB8IXHwgfCF98IHwgfPGB8IHwxQfCFx8I
HwhffCB8IHzxgfCB8MUHAtEfxTYBJq0poOcAAAAASUVORK5CYII='
]

{ #category : #sources }
RTTimeLineExample >> exampleSimpleGantt [

	| b |
		
	b := RTTimeLine new.

	b addEntry: (RTTimeLineEntry new identifier: #WP1; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #WP2; start: 5; end: 8).
	b addEntry: (RTTimeLineEntry new identifier: #WP3; start: 7; end: 10).

	b axisX numberOfLabels: 5.
	^ b
]

{ #category : #icons }
RTTimeLineExample >> exampleSimpleGanttIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACvUlEQVR4XuXbO2vCUBiH8X5q
v4Au2kUHRUURnVwUWhG831GoiyJqwdvS4GLBgopmeK0n0C4dmmLVxOcPhyxv4JhfOJE3Jw/H
Iz9WygP/EvBB+OGD8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfhg/DD
B+GHD8IH4YcPwgfhhw/CB+HnPkBms5nY4SK8voq8vJw/Pj5ELA1SrVZtAfL8LBIMnj/e3vgg
fBA+CB+ED2ImmqbJYrGQ+XwurVbLmMhqtRI+yI1AIpGIDAYD6ff7MhqNZDKZiNfr5YPcCiQW
i50mEfyewHg8FofDwQfhP0P4IHwQPggfhA/CB+GD3C2IavK9v58/dF2uPv+7BHl6ss4dzwfh
g/BB+CB8ED6I5UFcLpckEgmJRqOSSqUkk8lIIBAQPsiNQDqdjiSTSVEJhULG8asNzwfhL1l8
ED4IH4QPwgfhg/BB7hFE7UTsds8f/7ET0VIgj4/Vf7lT/zo0TWzR9ueD8EH4IHwQPggfxBIg
zWZTTv+ijvV63Wgu7na7H70sPsgVQbLZrLGVdLlcGs1FtdfX4/HwQW4F0m63pdFofP9wXdel
UqnwQfjPED4IH4QPwgfhg/BB+CAXB0mn0zKdTk2PUqlk63r1JZmlQdQ3iBeuP164/qLzvzoI
PxYB8fl84vf75ev4W/1wOJRCoWC6Xr34Wq/XputVV+FwOJiuj8fjUi6XTdXv93ujQ9Hr9WSz
2YhqKdVqNbEUiNowpzbQqZZKOBz+dXKqZrvdmq53u91GV8BsfS6XO70B7JquV18Wqy6EmXrV
oXA6nQaEOq9YLEo+nxf+ksVfsvjhg/BB+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfhg/DD
B+GHD8IH4YcPwgfhhw/CB+GHD8IH4YcPwg8fhA/CDx/E3vkEm1504ZwBcTkAAAAASUVORK5C
YII='
]

{ #category : #accessing }
RTTimeLineExample >> label [
	^ 'Time line'
]

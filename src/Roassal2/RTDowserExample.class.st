"
A RTDowserExample is a group of examples to show the different capabilities of RTDowserBuilder.

"
Class {
	#name : #RTDowserExample,
	#superclass : #Object,
	#category : #'Roassal2-Builder-Dowser'
}

{ #category : #basic }
RTDowserExample >> basic [
	"
	self new basic
	"
	|a |
	a := RTDowserBuilder new.
	a addColumn: { 'a' . 'b' . 'c' }.
	a addColumn: { 'a' . 'b' . 'c' }.
	a addColumn: { 'a' . 'b' . 'c' }.
	a edgesTo: #yourself.
	a open.
]

{ #category : #duoDowser }
RTDowserExample >> coolStuff [
	"
	self new coolStuff 
	"
	| builder |

	builder := RTDuoDowserBuilder new.
	builder legend: 'Compiler instance variables usage'.
	builder labelRight: [:a | a selector asString]. 
	builder left: Compiler instanceVariables.
	builder right: Compiler methods.
	builder edgesTo: [ :a :b | b referredInstVars includes: a  ].
	builder open
]

{ #category : #duoDowser }
RTDowserExample >> differentRelations [
	"
	self new differentRelations
	"
	| builder |

	builder := RTDuoDowserBuilder new.
	builder legend: 'Example of a relation between two set of integers'.
	builder left: (1 to: 10).
	builder right: (1 to: 20).
	builder edgesFromLeft: [ :v | (v - 5) to: (v + 5) ] edgesToLeft: [ :v | (v / 2) ].
	builder octopiEdges.
	builder open
]

{ #category : #duoDowser }
RTDowserExample >> doubleParameterRelation [
	"
	self new doubleParameterRelation
	"
	| builder | 
	builder := RTDuoDowserBuilder new.
	builder left: (1 to: 20).
	builder right: (RTObject withAllSubclasses).
	builder edgesFrom: [ :a :b | a numberOfSubclasses = b].
	builder open
]

{ #category : #duoDowser }
RTDowserExample >> duoBasic [
	"
	self new duoBasic
	"
	|a |
	a := RTDuoDowserBuilder new.
	a left: { 'a' . 'b' . 'c' }.
	a body: 'a b c a b c'.
	a edgesTo: #yourself.
	a open.
]

{ #category : #duoDowser }
RTDowserExample >> inferedRight [
	"
	self new inferedRight
	"
	| builder |

	builder := RTDuoDowserBuilder new.
	builder height:  [ :e | e numberOfLinesOfCode  / 10].
	builder color: #numberOfMethods.
	builder left: RTShape withAllSubclasses.
	builder edgesTo: #referencedClasses.
	builder open
]

{ #category : #duoDowser }
RTDowserExample >> ironMaiden [
	"
	self new ironMaiden
	"
	|builder maiden1 maiden2 |
	
	maiden1 := {{2013 . 46 . { 'United States' . 'Germany' . 'United Kingdom' . 'Brazil' . 'Spain' . 'Russia' . 'France' . 'Poland' . 'Sweden' . 'Austria' . 'Finland' . 'Argentina' . 'Switzerland' . 'Romania' . 'Paraguay' . 'Netherlands' . 'Turkey' . 'Chile' . 'Portugal' . 'Slovakia' . 'Czech Republic' . 'Belgium' . 'Croatia' . 'Italy' . 'Mexico' }}.
{2012 . 34 . { 'United States' . 'Canada' }} .
{2011 . 63 . { 'United Kingdom'	. 'Brazil' . 'Australia' . 'Germany' . 'France' . 'Russia' . 'Indonesia' . 'United States' . 'Mexico' . 'Colombia' . 'Netherlands' . 'Peru' . 'Poland' . 'Denmark' . 'Czech Republic' . 'Sweden' . 'Singapore' . 'Argentina' . 'Austria' . 'Belgium' . 'Chile' . 'Greece' . 'Norway' . 'Puerto Rico' . 'Turkey' . 'Finland' . 'South Korea'	. 'Switzerland' . 'Portugal' . 'Italy' . 'Spain' }} .
{2010 . 36 . { 'United States' . 'Canada' . 'Italy' . 'Ireland' . 'Belgium' . 'United Kingdom' . 'Spain' . 'Sweden' . 'Germany' . 'Finland' . 'Norway' . 'Hungary' .  'Romania' }} .
{2009 . 22 . { 'Brazil' . 'Mexico' . 'New Zealand' . 'Colombia' . 'Ecuador' . 'Serbia' . 'India' . 'Chile' . 'United Arab Emirates' . 'Peru' . 'Argentina' . 'United States' . 'Venezuela' . 'Costa Rica'}} .
{2008 . 68 . { 'United States' . 'Canada' . 'Australia' . 'Mexico' . 'Brazil' . 'Japan' . 'Sweden' . 'Norway' . 'France' . 'Finland' . 'Argentina' . 'Puerto Rico' . 'Czech Republic' . 'Chile' . 'Poland' . 'Hungary' . 'Portugal' . 'Costa Rica' . 'Romania' . 'Colombia' . 'Greece' . 'United Kingdom' . 'Croatia' . 'Denmark' . 'Netherlands' . 'Russia' . 'India' . 'Switzerland' . 'Germany' . 'Italy' . 'Belgium' . 'Spain' }} .
{2007 . 16 . { 'United Kingdom' . 'Germany' . 'Italy' . 'Slovenia' . 'Belgium' . 'India' . 'Greece' . 'United Arab Emirates' . 'Spain' . 'Serbia' . 'Netherlands' . 'Czech Republic' . 'Bulgaria' }} .
{2006 . 45 . { 'United Kingdom'	. 'United States' . 'Japan' . 'Sweden' . 'Finland' . 'Canada' . 'Norway' . 'Italy' . 'Denmark' . 'Germany' . 'Switzerland' . 'Ireland' . 'France' . 'Spain' . 'Netherlands' }} .
{2005 . 46 . { 'United States' . 'United Kingdom' . 'Germany' . 'Finland' . 'Norway' . 'Canada' . 'Portugal' . 'Belgium' . 'Czech Republic' . 'Switzerland' . 'Netherlands' . 'Greece' . 'Austria' . 'Sweden' . 'Poland' . 'Ireland' . 'Iceland' . 'Italy' . 'France' . 'Spain' }} .
{2004 . 14 . { 'United States' . 'Japan' . 'Brazil' . 'Canada' . 'Argentina' . 'Chile' }} .
{2003 . 90 . { 'United States' . 'Germany' . 'United Kingdom' . 'Spain' . 'France' . 'Sweden' . 'Italy' . 'Canada' . 'Belgium' . 'Czech Republic' . 'Denmark' . 'Switzerland' . 'Finland' . 'Hungary' . 'Netherlands' . 'Poland' . 'Norway' . 'Croatia' . 'Portugal' . 'Slovakia' . 'Austria' . 'Ireland'}} .
{2002 . 4 . { 'United Kingdom' }} . 
{2001 . 6 . { 'United Kingdom' . 'Argentina' . 'Brazil' . 'Mexico' . 'Chile' }} .
{2000 . 79 . { 'United States' . 'Japan' . 'United Kingdom' . 'Germany' . 'Canada' . 'Spain' . 'France' . 'Poland' . 'Czech Republic' . 'Switzerland' . 'Sweden' . 'Slovenia' . 'Portugal' . 'Norway' . 'Greece' . 'Belgium' . 'Netherlands' . 'Hungary' . 'Denmark' . 'Slovakia' . 'Finland' . 'Italy' . 'Austria' . 'Estonia' }} .
{1999 . 28 . { 'United States' . 'Canada' . 'Germany' . 'Spain' . 'Sweden' . 'Italy' . 'Netherlands' . 'Greece' . 'France' . 'Finland'}} .
{1998 . 87 .  {'United States' . 'Germany' . 'United Kingdom' . 'France' . 'Spain' . 'Italy' . 'Japan' . 'Brazil' . 'Canada' . 'Mexico' . 'Turkey' . 'Greece' . 'Argentina' . 'Hungary' . 'Poland' . 'Finland' . 'Czech Republic' . 'Portugal' . 'Malta' . 'Belgium' . 'Denmark' . 'Sweden' . 'Switzerland' . 'Netherlands' }} .
{1996 . 75 . {'United States' . 'France' . 'Japan' . 'Spain' . 'Italy' . 'Brazil' . 'Canada' . 'Argentina' . 'United Kingdom' . 'Greece' . 'Mexico' . 'Slovenia' . 'Denmark' . 'Netherlands' . 'Chile' . 'Ireland' . 'Colombia' . 'Finland' . 'Belgium' }} .
{1995 . 55 . {'Germany' . 'Italy' . 'United Kingdom' . 'Spain' . 'Israel' . 'South Africa' . 'Sweden' . 'Switzerland' . 'Greece' . 'Denmark' . 'Norway' . 'Romania' . 'Belgium' . 'Finland' . 'France' . 'Portugal' . 'Bulgaria' . 'Austria' . 'Poland' . 'Slovakia' . 'Netherlands' . 'Hungary' . 'Czech Republic'}} .
{1993  . 45 . {'Italy'  . 'United Kingdom' . 'Germany' . 'France' . 'Russia' . 'Spain' . 'Czech Republic' . 'Slovakia' . 'Sweden' . 'Netherlands' . 'Ireland' . 'Austria' . 'Switzerland' . 'Portugal' }} .
{1992  . 65 . {'United States' . 'Japan' . 'Canada' . 'Spain' . 'France' . 'Mexico' . 'Brazil' . 'Australia' . 'United Kingdom' . 'Venezuela' . 'Sweden' . 'Italy' . 'Germany' . 'Belgium' . 'Argentina' . 'Puerto Rico' . 'Finland' . 'Norway' . 'Denmark' . 'Switzerland' . 'Uruguay' . 'Iceland' . 'Netherlands' . 'New Zealand' }} .
{1991 . 50 . {'United States' . 'Canada' . 'Japan' . 'Switzerland' . 'Denmark' . 'France'}} .
{1990 . 56 . {'United Kingdom' . 'Germany' . 'Italy' . 'Spain' . 'Netherlands' . 'Belgium' . 'France' . 'Sweden' . 'Finland' . 'Ireland' . 'Portugal' . 'Norway' . 'Denmark' }} .
{1988 . 97 . {'United States' . 'United Kingdom' . 'Canada' . 'Germany' . 'Spain' . 'France' . 'Sweden' . 'Finland' . 'Portugal' . 'Italy' . 'Belgium' . 'Hungary' . 'Denmark' . 'Netherlands' . 'Austria'	. 'Switzerland' . 'Norway' . 'Greece' }} .
{1987  . 85 .  {'United States' . 'Canada' . 'Japan'}} .
{1986  . 66 .  {'United Kingdom' . 'Germany' . 'Poland' . 'France' . 'Italy' . 'Sweden' . 'Spain' . 'Austria' . 'Serbia' . 'Portugal' . 'Hungary' . 'Switzerland' . 'Croatia' . 'Slovenia' . 'Netherlands' . 'Norway' . 'Belgium' . 'Finland' }} .
{1985 . 104 .  {'United States' . 'Japan' . 'Australia' . 'Brazil' . 'United Kingdom' }} .
{1984 . 87 . {'United Kingdom' . 'Canada' . 'Germany' . 'United States' . 'France' . 'Poland' . 'Italy' . 'Spain' . 'Portugal' . 'Sweden' . 'Slovenia' . 'Switzerland' . 'Finland' . 'Hungary' . 'Belgium' . 'Netherlands' . 'Austria' . 'Denmark' . 'Serbia' }} .
{1983 . 137 .  {'United States' . 'United Kingdom' . 'Germany' . 'Canada' . 'France' . 'Spain' . 'Sweden' . 'Netherlands' . 'Denmark' . 'Belgium' . 'Finland' . 'Switzerland' . 'Norway' }} .
{1982  . 181 . {'United States' . 'United Kingdom' . 'France' . 'Canada' . 'Australia' . 'Japan' . 'Germany' . 'Spain' . 'Belgium' . 'Switzerland' . 'Netherlands' }} .
{1981  . 137 .  {'United States' . 'United Kingdom' . 'France' . 'Germany' . 'Italy' . 'Sweden' . 'Netherlands' . 'Japan' . 'Canada' . 'Denmark' . 'Belgium' . 'Serbia' . 'Switzerland' }} .
{1980  . 157 .	{'United Kingdom' . 'Germany' . 'Italy' . 'France' . 'Belgium' . 'Sweden' . 'Portugal' . 'Netherlands' . 'Finland' . 'Norway' . 'Switzerland' . 'Ireland' .	'Denmark' }} .
{ 1979 . 89 . { 'United Kingdom' }} .
{ 1978 . 4 . { 'United Kingdom' }} .
{ 1977 . 38 . { 'United Kingdom' }} .
{ 1976 . 34 . { 'United Kingdom' }}}.
	maiden2 := {'United States' -> 686 . 'United Kingdom' -> 538 . 'Germany' -> 154 . 'Canada' -> 111 . 'France' -> 109 . 'Japan' -> 70 . 'Italy' -> 70 . 'Spain' -> 68 . 'Sweden'	-> 39 . 'Australia' -> 32 . 'Brazil' -> 32 . 'Netherlands' -> 28 . 'Finland' -> 24 . 'Belgium' -> 24 . 'Poland' -> 23 . 'Switzerland' -> 22 . 'Denmark' -> 19 . 'Norway' -> 18 . 'Mexico' -> 17 . 'Portugal' -> 16 . 'Greece' -> 13 . 'Czech Republic' -> 11 . 'Austria' -> 11 . 'Hungary' -> 10 . 'Argentina' -> 10 . 'Ireland' -> 8 . 'Russia' -> 8 . 'Chile' -> 7 . 'Serbia' -> 5 . 'Slovenia' -> 5 . 'Slovakia' -> 5 . 'Croatia' -> 4 . 'Romania' -> 4 .'Colombia' -> 4 . 'Turkey' -> 4 . 'New Zealand' -> 3 . 'Venezuela' -> 3 . 'India' -> 3 . 'Israel' -> 3 . 'South Africa' -> 3 . 'Puerto Rico' -> 3. 'United Arab Emirates' -> 2 . 'Indonesia' -> 2 . 'Bulgaria'	-> 2 . 'Peru' -> 2 . 'Iceland' -> 2 . 'Costa Rica' -> 2 . 'South Korea' -> 1 . 'Uruguay' -> 1 . 'Ecuador' -> 1 . 'Estonia' -> 1 . 'Malta' -> 1 . 'Singapore' -> 1 . 'Paraguay' -> 1}.
	
	builder := RTDuoDowserBuilder new.
	builder title: 'Iron Maiden'.
	builder legend: 'Concerts around the world per year'.
	builder body: 'Iron Maiden are an English heavy metal band formed in Leyton, east London, in 1975 by bassist and primary songwriter Steve Harris. 
The band''s discography has grown to thirty-seven albums, including fifteen studio albums, eleven live albums, four EPs, and seven compilations.
Pioneers of the New Wave of British Heavy Metal, Iron Maiden achieved initial success during the early 1980s. After several line-up changes, the band went on to release a series of US and UK platinum and gold albums, including 1982''s The Number of the Beast, 1983''s Piece of Mind, 1984''s Powerslave, 1985''s live release Live After Death, 1986''s Somewhere in Time and 1988''s Seventh Son of a Seventh Son. Since the return of lead vocalist Bruce Dickinson and guitarist Adrian Smith in 1999, the band have undergone a resurgence in popularity, with their latest studio offering, The Final Frontier, peaking at No. 1 in 28 different countries and receiving widespread critical acclaim. Considered one of the most successful heavy metal bands in history, Iron Maiden have sold over 85 million records worldwide 
with little radio or television support. The band won the Ivor Novello Award for international achievement in 2002, and were also inducted into the Hollywood RockWalk in Sunset Boulevard, Los Angeles, California during their United States tour in 2005. As of October 2013, the band have played over 2000 live shows throughout their career. For the past 35 years, the band have been supported by their famous mascot, ''Eddie'', who has appeared on almost all of their album 
and single covers, as well as in their live shows.'.
	builder colorLeft: #second.
	builder colorRight: #value.
	builder heightLeft: #second.
	builder heightRight: [:v| (v value / 10) max: 10].
	builder left: maiden1.
	builder right: maiden2.
	builder labelLeft: #first.
	builder labelRight: #key.
	builder edgesTo: [:a :b | a third includes: (b key) ].
	builder open.
]

{ #category : #basic }
RTDowserExample >> manyRelations [
	"
	self new manyRelations
	"
	|builder |
	builder := RTDowserBuilder new.
	builder legend: 'Four Columns'.
	builder addColumn: (1 to: 10).
	builder addColumn: (1 to: 10).
	builder addColumn: (1 to: 10).
	builder addColumn: (1 to: 10).
	builder edgesWith: [ :v | (v - 5) to: (v + 5) ] from: 1 to: 2.
	builder edgesWith: [ :v | (v - 2) to: (v + 2) ] from: 2 to: 3.
	builder edgesWith: [ :v | (v / 2) ] from: 3 to: 4.
	builder open.
]

{ #category : #duoDowser }
RTDowserExample >> numberSubclasses [
	"
	self new numberSubclasses
	"
	| a |
	a := RTDuoDowserBuilder new.
	a label: [ :c | c name asString].
	a height: #numberOfMethods.
	a color: #numberOfLinesOfCode.
	a onLeftAndRight: Number withAllSubclasses.
	a edgesTo: #allSubclasses.
	a open.
	a inspect.
]

{ #category : #duoDowser }
RTDowserExample >> santas [
	"
	self new santas
	"
	|builder hohoho|
	
	hohoho := {'Afghanistan' -> 'Baba Chaghaloo'.'Albania' -> 'Babadimri'. 'Argentina' -> 'Papá Noel'. 'Armenia' -> 'Gaghant Baba'. 'Belgium' -> 'Pere Noel'. 'Bosnia and Herzegovina' -> 'Deda Mraz'. 'Bolivia' -> 'Papá Noel'. 'Brazil' -> 'Papai Noel'. 'Bulgaria' -> 'Dyado Koleda'. 'Canada' -> 'Santa Claus'. 'Chile' -> 'Viejo Pascuero'. 'China' -> 'Dun Che Lao Ren'. 'Colombia' -> 'Papá Noel'. 'Denmark' -> 'Julemanden'. 'Ecuador' -> 'Papá Noel'. 'Egypt' -> 'Papa Noël'. 'France' -> 'Pere Noel'. 'French Canada' -> 'Père Noël'. 'Finland' -> 'Joulupukki'. 'Germany' -> 'Weihnachtsmann'. 'Hawaii' -> 'Kanakaloka'. 'Hungary' -> 'Mikulas'. 'Iran' -> 'Baba Noel'. 'Iraq' -> 'Vader Kersfees'. 'Ireland' -> 'Daidí na Nollaig'. 'Italy' -> 'Babbo Natale'. 'Jamaica' -> 'Santa Claus'. 'Japan' -> 'Hoteiosho'. 'Lithuania' -> 'Kaledu Senelis'. 'Malta' -> 'San Niklaw'. 'Netherlands' -> 'Kerstman'. 'Norway' -> 'Julenissen'. 'Perú' -> 'Papá Noel'. 'Poland' -> 'Swiety Mikolaj'. 'Portugal' -> 'Pai Natal'. 'Romania' -> 'Mos Craciun'. 'Russia' -> 'Ded Moroz'. 'Serbia' -> 'Deda Mraz'. 'Scottish Highlands' -> 'Daidaín na Nollaig'. 'South Africa' -> 'Vader Kersfees'. 'Spain' -> 'Papá Noel'. 'Sweden' -> 'Jultomten'. 'Turkey' -> 'Noel Baba'. 'United Kingdom' -> 'Father Christmas'. 'US' -> 'Santa Claus'}.
	
	builder := RTDuoDowserBuilder new.
	builder title: 'Merry Christmas'.
	builder legend: 'Santa Claus over the World'.
	builder colorLeft: (Color green).
	builder colorRight: (Color red).
	builder left: hohoho.
	builder labelLeft: #key.
	builder edgesTo: #value.
	builder open.
]

{ #category : #duoDowser }
RTDowserExample >> singleParameterRelation [
	"
	self new singleParameterRelation
	"
	| builder | 
	builder := RTDuoDowserBuilder new.
	builder legend: 'Power'.
	builder onLeftAndRight: (1 to: 20).
	builder edgesTo: [ :v | v * v].
	builder open
]

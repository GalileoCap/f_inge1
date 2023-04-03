!classDefinition: #I category: 'Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Naturales'!
I class
	instanceVariableNames: 'next prev'!

!I class methodsFor: 'as yet unclassified' stamp: 'N 3/27/2023 21:18:17'!
* aNaturalNumber
	aNaturalNumber = I 
	ifTrue: [^self]
	ifFalse: [^self * aNaturalNumber prev + self]! !

!I class methodsFor: 'as yet unclassified' stamp: 'N 3/27/2023 20:53:15'!
+ aNaturalNumber
	self = I 
		ifTrue: [^aNaturalNumber next]
		ifFalse: [^prev + (aNaturalNumber next)]! !

!I class methodsFor: 'as yet unclassified' stamp: 'N 3/27/2023 21:04:08'!
- aNaturalNumber
	self = I 
		ifTrue: [^nil]
		ifFalse: [
			aNaturalNumber = I
				ifTrue: [^self prev] 
				ifFalse: [^self prev - aNaturalNumber prev]
		]! !

!I class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:38:39'!
/ aNaturalNumber
	self = aNaturalNumber 
		ifTrue: [^I]
		ifFalse: [
			aNaturalNumber = I 
				ifTrue: [^self] 
				ifFalse: [
					self > aNaturalNumber 
						ifTrue: [^self - aNaturalNumber / aNaturalNumber + I]  
						ifFalse: [^nil]
					]
			
		]! !

!I class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:32:43'!
> aNaturalNumber
	self - aNaturalNumber ifNil:[^false].
	^true! !

!I class methodsFor: 'as yet unclassified' stamp: 'N 3/27/2023 20:54:25'!
next
	| tmpPrev |
	tmpPrev := prev.
	prev := self.	
	next ifNil: [next := 	self cloneNamed: (self name append: 'I')].
	prev := tmpPrev.
	^next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'N 3/27/2023 20:51:00'!
prev
	^prev! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'mm 4/3/2023 15:44:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.
	prev := nil.! !


!classDefinition: #II category: 'Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Naturales'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:11'!
* aNaturalNumber
	aNaturalNumber = I 
	ifTrue: [^self]
	ifFalse: [^self * aNaturalNumber prev + self]! !

!II class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:11'!
+ aNaturalNumber
	self = I 
		ifTrue: [^aNaturalNumber next]
		ifFalse: [^prev + (aNaturalNumber next)]! !

!II class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:11'!
- aNaturalNumber
	self = I 
		ifTrue: [^nil]
		ifFalse: [
			aNaturalNumber = I
				ifTrue: [^self prev] 
				ifFalse: [^self prev - aNaturalNumber prev]
		]! !

!II class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:11'!
/ aNaturalNumber
	self = aNaturalNumber 
		ifTrue: [^I]
		ifFalse: [
			aNaturalNumber = I 
				ifTrue: [^self] 
				ifFalse: [
					self > aNaturalNumber 
						ifTrue: [^self - aNaturalNumber / aNaturalNumber + I]  
						ifFalse: [^nil]
					]
			
		]! !

!II class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:12'!
> aNaturalNumber
	self - aNaturalNumber ifNil:[^false].
	^true! !

!II class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:12'!
next
	| tmpPrev |
	tmpPrev := prev.
	prev := self.	
	next ifNil: [next := 	self cloneNamed: (self name append: 'I')].
	prev := tmpPrev.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:12'!
prev
	^prev! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'mm 4/3/2023 15:44:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !


!classDefinition: #III category: 'Naturales'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Naturales'!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:14'!
* aNaturalNumber
	aNaturalNumber = I 
	ifTrue: [^self]
	ifFalse: [^self * aNaturalNumber prev + self]! !

!III class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:14'!
+ aNaturalNumber
	self = I 
		ifTrue: [^aNaturalNumber next]
		ifFalse: [^prev + (aNaturalNumber next)]! !

!III class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:14'!
- aNaturalNumber
	self = I 
		ifTrue: [^nil]
		ifFalse: [
			aNaturalNumber = I
				ifTrue: [^self prev] 
				ifFalse: [^self prev - aNaturalNumber prev]
		]! !

!III class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:15'!
/ aNaturalNumber
	self = aNaturalNumber 
		ifTrue: [^I]
		ifFalse: [
			aNaturalNumber = I 
				ifTrue: [^self] 
				ifFalse: [
					self > aNaturalNumber 
						ifTrue: [^self - aNaturalNumber / aNaturalNumber + I]  
						ifFalse: [^nil]
					]
			
		]! !

!III class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:15'!
> aNaturalNumber
	self - aNaturalNumber ifNil:[^false].
	^true! !

!III class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:15'!
next
	| tmpPrev |
	tmpPrev := prev.
	prev := self.	
	next ifNil: [next := 	self cloneNamed: (self name append: 'I')].
	prev := tmpPrev.
	^next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:15'!
prev
	^prev! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'mm 4/3/2023 15:44:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !


!classDefinition: #IIII category: 'Naturales'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Naturales'!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:17'!
* aNaturalNumber
	aNaturalNumber = I 
	ifTrue: [^self]
	ifFalse: [^self * aNaturalNumber prev + self]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:18'!
+ aNaturalNumber
	self = I 
		ifTrue: [^aNaturalNumber next]
		ifFalse: [^prev + (aNaturalNumber next)]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:18'!
- aNaturalNumber
	self = I 
		ifTrue: [^nil]
		ifFalse: [
			aNaturalNumber = I
				ifTrue: [^self prev] 
				ifFalse: [^self prev - aNaturalNumber prev]
		]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:18'!
/ aNaturalNumber
	self = aNaturalNumber 
		ifTrue: [^I]
		ifFalse: [
			aNaturalNumber = I 
				ifTrue: [^self] 
				ifFalse: [
					self > aNaturalNumber 
						ifTrue: [^self - aNaturalNumber / aNaturalNumber + I]  
						ifFalse: [^nil]
					]
			
		]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:18'!
> aNaturalNumber
	self - aNaturalNumber ifNil:[^false].
	^true! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:18'!
next
	| tmpPrev |
	tmpPrev := prev.
	prev := self.	
	next ifNil: [next := 	self cloneNamed: (self name append: 'I')].
	prev := tmpPrev.
	^next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mm 4/3/2023 15:39:18'!
prev
	^prev! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'mm 4/3/2023 15:44:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := AnObsoleteIIIII.
	prev := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
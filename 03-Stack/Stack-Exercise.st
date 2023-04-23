!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FGCL 4/21/2023 21:04:26'!
test01ReturnsEmptyIfPrefixDoesntAppear
	| sentenceFinderByPrefix stack sentences |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	sentences := sentenceFinderByPrefix find: 'wint'.
	
	self assert: sentences isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FGCL 4/21/2023 21:04:20'!
test02FindsPrefixThatDoesAppear
	| sentenceFinderByPrefix stack sentences |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	stack push: 'winter is coming'.
	sentences := sentenceFinderByPrefix find: 'wint'.
	
	self deny: sentences isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FGCL 4/21/2023 21:06:37'!
test02FindsWithOneInstance
	| sentenceFinderByPrefix stack sentences winterIsComing |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	winterIsComing := 'winter is coming'.
	stack push: winterIsComing.
	sentences := sentenceFinderByPrefix find: 'wint'.
	
	self assert: sentences size = 1.
	self assert: sentences first = winterIsComing.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FGCL 4/21/2023 21:34:26'!
test03FindsMultipleInstances
	| sentenceFinderByPrefix stack sentences prefix |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	prefix := 'win'.
	stack push: (prefix, 'ter is coming').
	stack push: (prefix, 'ning is everything').
	sentences := sentenceFinderByPrefix find: prefix.
	
	self assert: sentences size = 2.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FGCL 4/21/2023 21:07:29'!
test04IsCaseSensitive
	| sentenceFinderByPrefix stack sentences winterIsComing |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	winterIsComing := 'winter is coming'.
	stack push: winterIsComing.
	stack push: 'Winter is here'.
	sentences := sentenceFinderByPrefix find: 'wint'.
	
	self assert: sentences size = 1.
	self assert: sentences first = winterIsComing.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FGCL 4/21/2023 21:26:43'!
test05RejectsEmptyPrefix
	| sentenceFinderByPrefix stack |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	self
		should: [ 	sentenceFinderByPrefix find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixError
		].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FGCL 4/21/2023 21:27:10'!
test06RejectsSentencePrefix
	| sentenceFinderByPrefix stack |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	self
		should: [ 	sentenceFinderByPrefix find: 'this is a sentence' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixIsSentenceError
		].! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'FGCL 4/21/2023 20:43:42'!
initialize
	top := OOStackEmptyElement new.! !


!OOStack methodsFor: 'testing' stamp: 'FGCL 4/21/2023 20:43:34'!
isEmpty
	^top isEmpty.! !


!OOStack methodsFor: 'manipulating' stamp: 'FGCL 4/23/2023 07:21:13'!
pop
	| prevTopValue |
	prevTopValue := self top.
	top := top prevElement.
	^prevTopValue.! !

!OOStack methodsFor: 'manipulating' stamp: 'FGCL 4/23/2023 07:22:23'!
push: anElement
	top := top push: anElement.! !


!OOStack methodsFor: 'accessing' stamp: 'FGCL 4/21/2023 20:42:41'!
size
	^top size.! !

!OOStack methodsFor: 'accessing' stamp: 'FGCL 4/21/2023 20:42:17'!
top
	^top value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'testing' stamp: 'FGCL 4/21/2023 20:46:28'!
isEmpty
	^self subclassResponsibility.! !


!OOStackElement methodsFor: 'manipulating' stamp: 'FGCL 4/21/2023 20:49:38'!
push: anElement
	^OOStackStuffedElement after: self with: anElement.! !


!OOStackElement methodsFor: 'accessing' stamp: 'FGCL 4/23/2023 07:20:36'!
prevElement
	^self subclassResponsibility.! !

!OOStackElement methodsFor: 'accessing' stamp: 'FGCL 4/21/2023 20:46:38'!
size
	^self subclassResponsibility.! !

!OOStackElement methodsFor: 'accessing' stamp: 'FGCL 4/21/2023 20:46:40'!
value
	^self subclassResponsibility.! !


!classDefinition: #OOStackEmptyElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackEmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyElement methodsFor: 'testing' stamp: 'FGCL 4/21/2023 20:47:11'!
isEmpty
	^true.! !


!OOStackEmptyElement methodsFor: 'accessing' stamp: 'FGCL 4/23/2023 07:20:10'!
prevElement
	self emptyError.! !

!OOStackEmptyElement methodsFor: 'accessing' stamp: 'FGCL 4/21/2023 20:48:27'!
size
	^0.! !

!OOStackEmptyElement methodsFor: 'accessing' stamp: 'FGCL 4/21/2023 22:33:26'!
value
	self emptyError.! !


!OOStackEmptyElement methodsFor: 'error' stamp: 'FGCL 4/21/2023 22:33:39'!
emptyError
	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOStackStuffedElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackStuffedElement
	instanceVariableNames: 'prevElement value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStuffedElement methodsFor: 'initializing' stamp: 'FGCL 4/21/2023 20:51:11'!
initializeAfter: anElement with: aValue
	prevElement := anElement.
	value := aValue.! !


!OOStackStuffedElement methodsFor: 'testing' stamp: 'FGCL 4/21/2023 20:48:40'!
isEmpty
	^false.! !


!OOStackStuffedElement methodsFor: 'accessing' stamp: 'FGCL 4/23/2023 07:19:42'!
prevElement
	^prevElement.! !

!OOStackStuffedElement methodsFor: 'accessing' stamp: 'FGCL 4/21/2023 20:49:59'!
size
	^prevElement size + 1.! !

!OOStackStuffedElement methodsFor: 'accessing' stamp: 'FGCL 4/21/2023 20:49:09'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStuffedElement class' category: 'Stack-Exercise'!
OOStackStuffedElement class
	instanceVariableNames: ''!

!OOStackStuffedElement class methodsFor: 'initializing' stamp: 'FGCL 4/21/2023 20:50:45'!
after: anElement with: aValue
	^OOStackStuffedElement new initializeAfter: anElement with: aValue.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initializing' stamp: 'FGCL 4/21/2023 21:08:23'!
initializeOver: aStack
	stack := aStack.! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'FGCL 4/23/2023 07:16:22'!
find: aPrefix
	self checkIsValidPrefix: aPrefix.
	^(self sentences) select: [ :aSentence | aSentence beginsWith: aPrefix ]! !

!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'FGCL 4/21/2023 22:03:53'!
sentences
	| sentences |
	sentences := OrderedCollection new.
	self overStackDo: [ :aSentence | sentences add: aSentence ].
	^sentences.! !


!SentenceFinderByPrefix methodsFor: 'prefixChecks' stamp: 'FGCL 4/21/2023 21:24:31'!
checkIsValidPrefix: aPrefix
	self checkPrefixNotEmpty: aPrefix.
	self checkPrefixIsntSentence: aPrefix.! !

!SentenceFinderByPrefix methodsFor: 'prefixChecks' stamp: 'FGCL 4/21/2023 21:24:13'!
checkPrefixIsntSentence: aPrefix
	(aPrefix includesSubString: ' ') ifTrue: [ self error: SentenceFinderByPrefix prefixIsSentenceError ].! !

!SentenceFinderByPrefix methodsFor: 'prefixChecks' stamp: 'FGCL 4/21/2023 21:24:01'!
checkPrefixNotEmpty: aPrefix
	aPrefix ifEmpty: [ self error: SentenceFinderByPrefix emptyPrefixError ].! !


!SentenceFinderByPrefix methodsFor: 'manipulatingStack' stamp: 'FGCL 4/21/2023 22:38:51'!
copyStack
	| newStack tmpStack |
	newStack := OOStack new.
	tmpStack := OOStack new.
	
	self over: stack do: [ :anElement |
		newStack push: anElement.
		tmpStack push: anElement.
	].
	self over: tmpStack do: [ :anElement | stack push: anElement ].

	^newStack.! !

!SentenceFinderByPrefix methodsFor: 'manipulatingStack' stamp: 'FGCL 4/21/2023 21:53:20'!
over: aStack do: block
	| anElement |
	(aStack size) timesRepeat: [
		anElement := aStack pop.
		block value: anElement.
	].! !

!SentenceFinderByPrefix methodsFor: 'manipulatingStack' stamp: 'FGCL 4/21/2023 21:55:07'!
overStackDo: block
	self over: (self copyStack) do: block.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initializing' stamp: 'FGCL 4/21/2023 21:08:10'!
over: aStack
	^self new initializeOver: aStack.! !


!SentenceFinderByPrefix class methodsFor: 'errors' stamp: 'FGCL 4/21/2023 21:15:09'!
emptyPrefixError
	^'prefix cant be empty!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'errors' stamp: 'FGCL 4/21/2023 21:22:42'!
prefixIsSentenceError
	^'prefix cant be a sentence!!!!'! !

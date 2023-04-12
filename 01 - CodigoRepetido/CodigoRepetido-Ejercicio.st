!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'FGCL 4/12/2023 09:57:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self checkThis: [ customerBook addCustomerNamed: 'John Lennon'. ] runsInLessThan: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FGCL 4/11/2023 21:01:28'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self checkThis: [ customerBook removeCustomerNamed: paulMcCartney. ] runsInLessThan: 100 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FGCL 4/11/2023 21:02:06'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self
		errorOrFail: [ customerBook addCustomerNamed: ''. ]
		andThenCheck: [ :anError | 
			(anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage)
				and: customerBook isEmpty.
		].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FGCL 4/11/2023 21:03:12'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		errorOrFail: [ customerBook removeCustomerNamed: 'Paul McCartney'. ]
		withError: NotFound
		andThenCheck: [ :anError |
			(customerBook numberOfCustomers = 1)
				and: (customerBook includesCustomerNamed: johnLennon).
		].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FGCL 4/11/2023 20:03:30'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addThenSuspendCustomerNamed: paulMcCartney.
	
	self assert: (customerBook hasTotal: 1 andHasActive: 0 andHasSuspended: 1).
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FGCL 4/11/2023 20:03:34'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addThenSuspendThenRemoveCustomerNamed: paulMcCartney.
	
	self assert: (customerBook hasTotal: 0 andHasActive: 0 andHasSuspended: 0).
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FGCL 4/11/2023 21:08:01'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		errorOrFail: [ customerBook suspendCustomerNamed: 'George Harrison'. ]
		withError: CantSuspend
		andThenCheck: [ :anError |
			(customerBook numberOfCustomers = 1)
				and: (customerBook includesCustomerNamed: johnLennon).
		].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FGCL 4/11/2023 21:08:16'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addThenSuspendCustomerNamed: johnLennon.
	
	self
		errorOrFail: [ customerBook suspendCustomerNamed: johnLennon. ]
		withError: CantSuspend
		andThenCheck: [ :anError |
			(customerBook numberOfCustomers = 1)
				and: (customerBook includesCustomerNamed: johnLennon).
		].! !


!CustomerBookTest methodsFor: 'testUtils' stamp: 'FGCL 4/11/2023 20:55:40'!
checkThis: block runsInLessThan: time
	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	block value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: ((millisecondsAfterRunning-millisecondsBeforeRunning) < time).! !

!CustomerBookTest methodsFor: 'testUtils' stamp: 'FGCL 4/12/2023 09:59:30'!
errorOrFail: blockThatShouldError andThenCheck: blockThatChecksError

	[ blockThatShouldError  value. self fail. ] on: Error do: [ :anError | self assert: (blockThatChecksError value: anError). ].! !

!CustomerBookTest methodsFor: 'testUtils' stamp: 'FGCL 4/11/2023 21:08:42'!
errorOrFail: blockThatShouldError withError: expectedError andThenCheck: blockThatChecksError

	self errorOrFail: blockThatShouldError andThenCheck: [ :anError | (anError isMemberOf: expectedError) and: (blockThatChecksError value: anError). ].! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'FGCL 4/11/2023 21:14:41'!
customerAlreadyExists: aName
	^((active includes: aName) or: [suspended includes: aName]).! !

!CustomerBook methodsFor: 'testing' stamp: 'FGCL 4/11/2023 20:13:23'!
hasTotal: expectedTotalCustomers andHasActive: expectedActiveCustomers andHasSuspended: expectedSuspendedCustomers
	^(self numberOfCustomers = expectedTotalCustomers)
		and: (self numberOfActiveCustomers = expectedActiveCustomers)
		and: (self numberOfSuspendedCustomers = expectedSuspendedCustomers).! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/11/2023 21:14:52'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self customerAlreadyExists: aName) ifTrue: [ self signalCustomerAlreadyExists. ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/12/2023 10:03:24'!
addThenRemoveCustomerNamed: customerName
	self addCustomerNamed: customerName.
	self removeCustomerNamed: customerName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/11/2023 19:47:22'!
addThenSuspendCustomerNamed: customerName
	self addCustomerNamed: customerName.
	self suspendCustomerNamed: customerName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/11/2023 19:47:30'!
addThenSuspendThenRemoveCustomerNamed: customerName
	self addCustomerNamed: customerName.
	self suspendCustomerNamed: customerName.
	self removeCustomerNamed: customerName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/12/2023 10:07:11'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/12/2023 10:04:51'!
removeCustomerNamed: aName 

	active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent:
			[ ^NotFound signal. ].
	].
	
	^aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/11/2023 19:54:15'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/11/2023 19:55:45'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FGCL 4/11/2023 21:25:14'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [ ^CantSuspend signal. ].
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !

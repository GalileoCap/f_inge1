!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/9/2023 14:38:18'!
test01NewCartsAreCreatedEmpty

	self assert: factory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/9/2023 14:39:50'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := factory createCart.
	
	self 
		should: [ cart add: factory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/9/2023 14:38:36'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := factory createCart.
	
	cart add: factory itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/9/2023 14:38:46'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := factory createCart.
	
	self 
		should: [cart add: 0 of: factory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/9/2023 14:38:55'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := factory createCart.
	
	self 
		should: [cart add: 2 of: factory itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/9/2023 14:39:10'!
test06CartRemembersAddedItems

	| cart |
	
	cart := factory createCart.
	
	cart add: factory itemSoldByTheStore.
	self assert: (cart includes: factory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/9/2023 14:39:18'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := factory createCart.
	
	self deny: (cart includes: factory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/9/2023 14:39:34'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := factory createCart.
	
	cart add: 2 of: factory itemSoldByTheStore.
	self assert: (cart occurrencesOf: factory itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'FGCL 6/9/2023 14:38:09'!
setUp
	factory := TusLibrosTestObjectFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'FGCL 6/11/2023 17:57:59'!
test01CashierCantCheckOutEmptyCart
	| cashier cart |
	
	cart := factory createCart.
	cashier := Cashier
				for: cart
				withCreditCard: factory createValidCreditCard
				withCatalog: factory defaultCatalog
				withMerchantProcessor: factory createMerchantProcessor.
	
	self should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: (Cashier emptyCartErrorMessage) equals: anError messageText ].! !

!CashierTest methodsFor: 'tests' stamp: 'FGCL 6/11/2023 18:20:11'!
test02CashierCanCheckOutCartWithOneItem
	| cashier cart |
	
	cart := factory createCart.
	cashier := Cashier
				for: cart
				withCreditCard: factory createValidCreditCard
				withCatalog: factory defaultCatalog
				withMerchantProcessor: factory createMerchantProcessor.
	
	cart add: factory itemSoldByTheStore.
	self assert: {cart items. 1} equals: cashier checkOut.! !

!CashierTest methodsFor: 'tests' stamp: 'FGCL 6/11/2023 18:20:56'!
test03CashierCanCheckOutCartWithManyItems
	| cashier cart |
	
	cart := factory createCart.
	cashier := Cashier
				for: cart
				withCreditCard: factory createValidCreditCard
				withCatalog: factory defaultCatalog
				withMerchantProcessor: factory createMerchantProcessor.
	
	cart add: 2 of: factory itemSoldByTheStore.
	self assert: {cart items. 2} equals: cashier checkOut.! !

!CashierTest methodsFor: 'tests' stamp: 'FGCL 6/11/2023 18:13:51'!
test04CashierCantCheckoutWithAnExpiredCreditCard
	| cashier cart |
	
	cart := factory createCart.
	cashier := Cashier
			for: cart
			withCreditCard: factory createExpiredCreditCard
			withCatalog: factory defaultCatalog
			withMerchantProcessor: (factory createMerchantProcessor).

	cart add: factory itemSoldByTheStore.

	self should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: (MerchantProcessor expiredCreditCardErrorMessage) equals: anError messageText ].! !

!CashierTest methodsFor: 'tests' stamp: 'FGCL 6/11/2023 18:14:06'!
test05CashierCantCheckoutWithAStolenCreditCard
	| cashier cart |
	
	cart := factory createCart.
	cashier := Cashier
			for: cart
			withCreditCard: factory createStolenCreditCard
			withCatalog: factory defaultCatalog
			withMerchantProcessor: factory createMerchantProcessor.
	
	cart add: factory itemSoldByTheStore.
	
	self should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: (MerchantProcessor stolenCreditCardErrorMessage) equals: anError messageText ].! !

!CashierTest methodsFor: 'tests' stamp: 'FGCL 6/11/2023 18:14:24'!
test06CashierCantCheckoutWithInsufficientFunds
	| cart cashier |
	
	cart := factory createCart.
	cashier :=	Cashier
				for: cart
				withCreditCard: factory createCreditCardWithoutFunds
				withCatalog: factory defaultCatalog
				withMerchantProcessor: factory createMerchantProcessor.

	cart add: factory itemSoldByTheStore.

	self should: [ 	cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: (MerchantProcessor insufficientFundsErrorMessage) equals: anError messageText ].! !

!CashierTest methodsFor: 'tests' stamp: 'FGCL 6/11/2023 18:20:47'!
test07SuccesfullCheckout
	" Este test es el mismo que el test02, pero en la consigna nos pidieron que lo hagamos. "
	| cart cashier |
	
	cart := factory createCart.
	cashier :=	Cashier
				for: cart
				withCreditCard: factory createValidCreditCard
				withCatalog: factory defaultCatalog
				withMerchantProcessor: factory createMerchantProcessor.

	cart add: factory itemSoldByTheStore.
	self assert: {cart items. 1} equals: cashier checkOut.! !


!CashierTest methodsFor: 'setup' stamp: 'FGCL 6/9/2023 14:40:11'!
setUp
	factory := TusLibrosTestObjectFactory new.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'FGCL 6/11/2023 17:52:46'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'FGCL 6/11/2023 17:52:35'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'getters' stamp: 'FGCL 6/9/2023 14:51:33'!
items
	^items copy.! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard merchantProcessor catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'FGCL 6/11/2023 18:21:11'!
checkOut
	self checkValidCheckOut.
	merchantProcessor charge: self totalPrice on: creditCard.
	
	^{cart items. self totalPrice}.! !


!Cashier methodsFor: 'checks' stamp: 'FGCL 6/9/2023 15:29:04'!
checkCartNotEmpty
	(cart isEmpty) ifTrue: [ self error: Cashier emptyCartErrorMessage ].! !

!Cashier methodsFor: 'checks' stamp: 'FGCL 6/11/2023 17:46:10'!
checkValidCheckOut
	self checkCartNotEmpty.! !


!Cashier methodsFor: 'price' stamp: 'FGCL 6/11/2023 17:55:22'!
totalPrice
	^(cart items collect: [ :anItem | catalog at: anItem ]) sum.! !


!Cashier methodsFor: 'initialization' stamp: 'FGCL 6/11/2023 18:07:47'!
initializeFor: aCart withCreditCard: aCreditCard withACatalog: aCatalog withMerchantProcessor: aMerchantProcessor
	cart := aCart.
	creditCard := aCreditCard.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'FGCL 6/9/2023 14:45:28'!
emptyCartErrorMessage
	^'Cant checkout an empty cart'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'FGCL 6/11/2023 17:54:10'!
for: aCart withCreditCard: aCreditCard withACatalog: aCatalog withMerchantProcessor: aMerchantProcessor
	^self new initializeFor: aCart withCreditCard: aCreditCard withACatalog: aCatalog withMerchantProcessor: aMerchantProcessor.! !

!Cashier class methodsFor: 'instance creation' stamp: 'FGCL 6/11/2023 17:56:51'!
for: aCart withCreditCard: aCreditCard withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor
	^self new initializeFor: aCart withCreditCard: aCreditCard withACatalog: aCatalog withMerchantProcessor: aMerchantProcessor.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiryYear expiryMonth owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FGCL 6/11/2023 17:25:17'!
initializeWithOwner: anOwner withExpiryYear: aYear andMonth: aMonth
	owner := anOwner.
	expiryYear := aYear.
	expiryMonth := aMonth.! !


!CreditCard methodsFor: 'equality' stamp: 'FGCL 6/11/2023 17:24:51'!
= aCreditCard
	^(owner = aCreditCard owner) and: (self expiryDate = aCreditCard expiryDate).! !


!CreditCard methodsFor: 'getters' stamp: 'FGCL 6/11/2023 17:25:06'!
owner
	^owner.! !


!CreditCard methodsFor: 'expiration' stamp: 'FGCL 6/9/2023 15:28:07'!
expiryDate
	^Date newDay: (self expiryDay) month: expiryMonth year: expiryYear.! !

!CreditCard methodsFor: 'expiration' stamp: 'FGCL 6/9/2023 15:28:14'!
expiryDay
	^Date daysInMonth: expiryMonth forYear: expiryYear.! !

!CreditCard methodsFor: 'expiration' stamp: 'FGCL 6/9/2023 15:26:53'!
ifExpired: aBlock
	(self isExpired) ifTrue: aBlock.! !

!CreditCard methodsFor: 'expiration' stamp: 'FGCL 6/9/2023 15:27:46'!
isExpired
	^(self expiryDate) < Date today.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FGCL 6/11/2023 17:25:36'!
withOwner: anOwner withExpiryYear: aYear andMonth: aMonth
	^self new initializeWithOwner: anOwner withExpiryYear: aYear andMonth: aMonth.! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'stolenCreditCards accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'initialization' stamp: 'FGCL 6/11/2023 17:40:12'!
initializeWithAccounts: aDictionaryOfUsersToAccountBalances WithStolenCreditCards: aListOfStolenCreditCards.
	accounts := aDictionaryOfUsersToAccountBalances.
	stolenCreditCards := aListOfStolenCreditCards.! !


!MerchantProcessor methodsFor: 'charge' stamp: 'FGCL 6/11/2023 18:05:59'!
charge: aCharge on: aCreditCard
	| balance |
	
	self checkCanCharge: aCharge on: aCreditCard.
	
	balance := accounts at: aCreditCard owner.
	accounts at: aCreditCard owner put: balance - aCharge.
	! !

!MerchantProcessor methodsFor: 'charge' stamp: 'FGCL 6/11/2023 18:06:57'!
check: anOwner hasEnoughFundsFor: aCharge.
	((accounts at: anOwner) >= aCharge) ifFalse: [ self error: MerchantProcessor insufficientFundsErrorMessage ].! !

!MerchantProcessor methodsFor: 'charge' stamp: 'FGCL 6/11/2023 18:06:45'!
checkCanCharge: aCharge on: aCreditCard.
	self checkValidCreditCard: aCreditCard.
	self check: aCreditCard owner hasEnoughFundsFor: aCharge.! !


!MerchantProcessor methodsFor: 'check credit card' stamp: 'FGCL 6/9/2023 15:50:08'!
checkCreditCardNotExpired: aCreditCard
	aCreditCard ifExpired: [ self error: MerchantProcessor expiredCreditCardErrorMessage ].! !

!MerchantProcessor methodsFor: 'check credit card' stamp: 'FGCL 6/11/2023 17:21:31'!
checkCreditCardNotStolen: aCreditCard
	(stolenCreditCards includes: aCreditCard) ifTrue: [ self error: MerchantProcessor stolenCreditCardErrorMessage ].! !

!MerchantProcessor methodsFor: 'check credit card' stamp: 'FGCL 6/9/2023 15:48:12'!
checkValidCreditCard: aCreditCard
	self checkCreditCardNotExpired: aCreditCard.
	self checkCreditCardNotStolen: aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'FGCL 6/11/2023 17:40:34'!
withAccounts: aDictionaryOfUsersToAccountBalances WithStolenCreditCards: aListOfStolenCreditCards.
	^self new initializeWithAccounts: aDictionaryOfUsersToAccountBalances WithStolenCreditCards: aListOfStolenCreditCards.! !


!MerchantProcessor class methodsFor: 'errors' stamp: 'FGCL 6/9/2023 15:50:01'!
expiredCreditCardErrorMessage
	^'Cant use an expired credit card'.! !

!MerchantProcessor class methodsFor: 'errors' stamp: 'FGCL 6/11/2023 18:04:55'!
insufficientFundsErrorMessage
	^'Insufficient funds'.! !

!MerchantProcessor class methodsFor: 'errors' stamp: 'FGCL 6/9/2023 15:51:33'!
stolenCreditCardErrorMessage
	^'Cant use a stolen credit card'.! !


!classDefinition: #TusLibrosTestObjectFactory category: 'TusLibros'!
Object subclass: #TusLibrosTestObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTestObjectFactory methodsFor: 'catalog' stamp: 'FGCL 6/11/2023 17:52:09'!
defaultCatalog
	| catalog |
	
	catalog := Dictionary new.
	catalog at: self itemSoldByTheStore put: self itemSoldByTheStorePrice.
	
	^catalog.! !

!TusLibrosTestObjectFactory methodsFor: 'catalog' stamp: 'FGCL 6/9/2023 14:37:48'!
itemNotSoldByTheStore
	^'invalidBook'.! !

!TusLibrosTestObjectFactory methodsFor: 'catalog' stamp: 'FGCL 6/9/2023 14:37:42'!
itemSoldByTheStore
	^'validBook'.! !

!TusLibrosTestObjectFactory methodsFor: 'catalog' stamp: 'FGCL 6/11/2023 18:10:45'!
itemSoldByTheStorePrice
	^1.! !


!TusLibrosTestObjectFactory methodsFor: 'creditCards' stamp: 'FGCL 6/11/2023 18:12:48'!
createCreditCardWithoutFunds
	^CreditCard withOwner: (self userWithoutFunds) withExpiryYear: (self nextYear) andMonth: #May.! !

!TusLibrosTestObjectFactory methodsFor: 'creditCards' stamp: 'FGCL 6/11/2023 17:43:42'!
createExpiredCreditCard
	^CreditCard withOwner: (self userWithFunds) withExpiryYear: (self lastYear) andMonth: #May.! !

!TusLibrosTestObjectFactory methodsFor: 'creditCards' stamp: 'FGCL 6/11/2023 17:25:28'!
createStolenCreditCard
	^CreditCard withOwner: (self invalidUser) withExpiryYear: (self nextYear) andMonth: #May.! !

!TusLibrosTestObjectFactory methodsFor: 'creditCards' stamp: 'FGCL 6/11/2023 17:43:42'!
createValidCreditCard
	^CreditCard withOwner: (self userWithFunds) withExpiryYear: (self nextYear) andMonth: #May.! !

!TusLibrosTestObjectFactory methodsFor: 'creditCards' stamp: 'FGCL 6/9/2023 15:40:39'!
lastYear
	^Date today yearNumber - 1.! !

!TusLibrosTestObjectFactory methodsFor: 'creditCards' stamp: 'FGCL 6/9/2023 15:40:45'!
nextYear
	^Date today yearNumber + 1.! !


!TusLibrosTestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FGCL 6/11/2023 17:41:29'!
createMerchantProcessor
	^MerchantProcessor withAccounts: self merchantProcessorAccounts WithStolenCreditCards: self merchantProcessorStolenCreditCards.! !

!TusLibrosTestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FGCL 6/11/2023 17:43:54'!
invalidUser
	^'Federico'.! !

!TusLibrosTestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FGCL 6/11/2023 18:16:21'!
merchantProcessorAccounts
	| accounts |
	
	accounts := Dictionary new.
	
	accounts at: self userWithFunds put: 100.
	accounts at: self userWithoutFunds put: 0.
	
	^accounts.! !

!TusLibrosTestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FGCL 6/11/2023 17:41:38'!
merchantProcessorStolenCreditCards.
	^OrderedCollection with: self createStolenCreditCard.! !

!TusLibrosTestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FGCL 6/11/2023 17:43:42'!
userWithFunds
	^'Martin'.! !

!TusLibrosTestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FGCL 6/11/2023 17:43:50'!
userWithoutFunds
	^'Galileo'.! !


!TusLibrosTestObjectFactory methodsFor: 'carts' stamp: 'FGCL 6/9/2023 14:37:05'!
createCart
	^Cart acceptingItemsOf: self defaultCatalog.! !

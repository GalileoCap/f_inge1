!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'emptyStockManager stockedStockManager book1Isbn book2Isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setup' stamp: 'FGCL 6/8/2023 00:10:12'!
setUp
	
	book1Isbn := '1,0321146530,2'.
	book2Isbn := '1,1933988274,1'.
	emptyStockManager := StockManager with: {}.
	stockedStockManager := StockManager with: { book1Isbn. book2Isbn }.! !


!CartTest methodsFor: 'tests' stamp: 'FGCL 6/8/2023 00:05:17'!
test01WhenCreatedCartIsEmpty
	| cart |
	
	cart := Cart withStockManager: emptyStockManager.
	
	self assert: Bag new equals: cart books.! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/8/2023 00:08:01'!
test02ABookInStockCanBeAddedToACart
	| cart |
	
	cart := Cart withStockManager: stockedStockManager.
	
	cart addBookWithIsbn: book1Isbn.
	self assert: (Bag with: book1Isbn) equals: cart books.! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/8/2023 00:05:45'!
test03CantAddABookNotInStock
	| cart |
	
	cart := Cart withStockManager: emptyStockManager.
	
	self should: [ cart addBookWithIsbn: 0 ]
		raise: Error
		withExceptionDo: [ :anError | self assert: (StockManager productNotInStockErrorMessage) equals: anError messageText ].! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/8/2023 00:08:09'!
test04ABookCanBeAddedToACartManyTimesSeparately
	| cart |
	
	cart := Cart withStockManager: stockedStockManager.
	
	cart addBookWithIsbn: book1Isbn.
	cart addBookWithIsbn: book1Isbn.
	self assert: (Bag with: book1Isbn with: book1Isbn) equals: cart books.! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/8/2023 00:08:16'!
test05ABookInStockCanBeAddedToACartManyTimesAtOnce
	| cart |
	
	cart := Cart withStockManager: stockedStockManager.
	
	cart addBookWithIsbn: book1Isbn withOccurrences: 2.
	self assert: (Bag with: book1Isbn with: book1Isbn) equals: cart books.! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/8/2023 00:07:48'!
test06DifferentBooksInStockCanBeAddedToACart
	| cart |
	
	cart := Cart withStockManager: stockedStockManager.
	
	cart addBookWithIsbn: book1Isbn.
	cart addBookWithIsbn: book2Isbn.
	self assert: (Bag with: book1Isbn with: book2Isbn) equals: cart books.! !

!CartTest methodsFor: 'tests' stamp: 'FGCL 6/8/2023 00:06:25'!
test07CantAddNegativeAmountOfBooksInStockToACart
	| cart |
	
	cart := Cart withStockManager: stockedStockManager.
	
	self should: [ cart addBookWithIsbn: 0 withOccurrences: -1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (Cart bookNegativeOccurrencesErrorMessage) equals: anError messageText.
		].! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'id books stockManager'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'getters' stamp: 'FGCL 6/6/2023 20:46:11'!
books
	^books.! !


!Cart methodsFor: 'managing' stamp: 'FGCL 6/6/2023 20:56:46'!
addBookWithIsbn: aBooksIsbn
	self addBookWithIsbn: aBooksIsbn withOccurrences: 1.! !

!Cart methodsFor: 'managing' stamp: 'FGCL 6/7/2023 23:57:56'!
addBookWithIsbn: aBooksIsbn withOccurrences: occurrences
	self checkCanAddBookWithIsbn: aBooksIsbn withOccurrences: occurrences.
		
	books add: aBooksIsbn withOccurrences: occurrences. " NOTA: Deberíamos de haber hecho add: 0 en la primera vez, porque todavía no estabamos testeando el genérico de múltiples isbn diferentes (test04), nos adelantamos. "! !

!Cart methodsFor: 'managing' stamp: 'FGCL 6/7/2023 23:58:04'!
checkCanAddBookWithIsbn: aBooksIsbn withOccurrences: occurrences.
	occurrences negative ifTrue: [ self error: Cart bookNegativeOccurrencesErrorMessage ].
	stockManager checkHasInStock: aBooksIsbn.! !


!Cart methodsFor: 'initialization' stamp: 'FGCL 6/7/2023 23:57:01'!
initializeWithStockManager: aStockManager
	stockManager := aStockManager.
	books := Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'FGCL 6/6/2023 21:04:45'!
bookNegativeOccurrencesErrorMessage
	^'Cant add a negative amount of books'.! !


!Cart class methodsFor: 'instance creation' stamp: 'FGCL 6/7/2023 23:56:12'!
withStockManager: aStockManager
	^self new initializeWithStockManager: aStockManager.! !


!classDefinition: #StockManager category: 'TusLibros'!
Object subclass: #StockManager
	instanceVariableNames: 'listing'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StockManager methodsFor: 'initialization' stamp: 'FGCL 6/8/2023 00:00:09'!
initializeWith: aListing
	listing := aListing.! !


!StockManager methodsFor: 'testing' stamp: 'FGCL 6/8/2023 00:01:21'!
checkHasInStock: aProduct
	(listing includes: aProduct) ifFalse: [ self error: StockManager productNotInStockErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StockManager class' category: 'TusLibros'!
StockManager class
	instanceVariableNames: ''!

!StockManager class methodsFor: 'errors' stamp: 'FGCL 6/8/2023 00:01:37'!
productNotInStockErrorMessage
	^'That product is not in stock'.! !


!StockManager class methodsFor: 'instance creation' stamp: 'FGCL 6/7/2023 23:59:17'!
with: aListing
	^self new initializeWith: aListing.! !

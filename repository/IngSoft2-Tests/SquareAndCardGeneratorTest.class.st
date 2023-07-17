Class {
	#name : #SquareAndCardGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
SquareAndCardGeneratorTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test001ASquareGeneratorCanGenerateANumberBetween1And100 [

	| randomSquareGenerator anAmountOfSquares squaresToUse distribution values aValue1 |
	anAmountOfSquares := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	squaresToUse := OrderedCollection new.
	squaresToUse add: AtomicBombSquare new.
	squaresToUse add: (HyperJumpSquare with: values).
	squaresToUse add: (MoonwalkSquare with: 3).
	squaresToUse add: SpeedUpSquare new.
	squaresToUse add: WormholeSquare new.
	squaresToUse add: NoEffectSquare new.
	distribution := #( 2 8 10 20 20 40 ) asOrderedCollection.
	randomSquareGenerator := SquareGenerator
		                         with: anAmountOfSquares 
		                         of: squaresToUse
		                         using: distribution.
	
	self assert: ((randomSquareGenerator generateNumber) between: 1 and: 100). 
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test002ASquareGeneratorCanGenerateSquaresBasedOnAGivenAmountOfSquares [

	| randomSquareGenerator anAmountOfSquares squaresToUse distribution values aValue1 |
	anAmountOfSquares := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	squaresToUse := OrderedCollection new.
	squaresToUse add: AtomicBombSquare new.
	squaresToUse add: (HyperJumpSquare with: values).
	squaresToUse add: (MoonwalkSquare with: 3).
	squaresToUse add: SpeedUpSquare new.
	squaresToUse add: WormholeSquare new.
	squaresToUse add: NoEffectSquare new.
	distribution := #( 2 8 10 20 20 40 ) asOrderedCollection.
	randomSquareGenerator := SquareGenerator
		                         with: anAmountOfSquares 
		                         of: squaresToUse
		                         using: distribution.
	
	self assert: ((randomSquareGenerator generateObjects) size) equals: 100. 
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test003ASquareGeneratorCannotGenerateZeroOrLowerAmountOfSquares [
	
	| randomSquareGenerator anAmountOfSquares squaresToUse distribution values aValue1 |
	anAmountOfSquares := -5.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	squaresToUse := OrderedCollection new.
	squaresToUse add: AtomicBombSquare new.
	squaresToUse add: (HyperJumpSquare with: values).
	squaresToUse add: (MoonwalkSquare with: 3).
	squaresToUse add: SpeedUpSquare new.
	squaresToUse add: WormholeSquare new.
	squaresToUse add: NoEffectSquare new.
	distribution := #( 2 8 10 20 20 40 ) asOrderedCollection.
	
	self
		should: [ randomSquareGenerator := SquareGenerator
		                         with: anAmountOfSquares 
		                         of: squaresToUse
		                         using: distribution. ]
		raise: Error
		withMessage: 'Amount of objects cannot be 0 or lower'
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test004ASquareGeneratorCannotGenerateWithInvalidDistribution [
	
	| randomSquareGenerator anAmountOfSquares squaresToUse distribution values aValue1 |
	anAmountOfSquares := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	squaresToUse := OrderedCollection new.
	squaresToUse add: AtomicBombSquare new.
	squaresToUse add: (HyperJumpSquare with: values).
	squaresToUse add: (MoonwalkSquare with: 3).
	squaresToUse add: SpeedUpSquare new.
	squaresToUse add: WormholeSquare new.
	squaresToUse add: NoEffectSquare new.
	distribution := #( 2 8 10 20 20 91 ) asOrderedCollection.
	
	self
		should: [ randomSquareGenerator := SquareGenerator
		                         with: anAmountOfSquares 
		                         of: squaresToUse
		                         using: distribution. ]
		raise: Error
		withMessage: 'Distribution must add up 100%'
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test005ASquareGeneratorCannotGenerateWithoutAnyTypeOfSquare [
	
	| randomSquareGenerator anAmountOfSquares squaresToUse distribution |
	anAmountOfSquares := 100.
	squaresToUse := OrderedCollection new.
	distribution := #( 2 8 10 20 20 40 ) asOrderedCollection.
	
	self
		should: [ randomSquareGenerator := SquareGenerator
		                         with: anAmountOfSquares 
		                         of: squaresToUse
		                         using: distribution. ]
		raise: Error
		withMessage: 'Cannot generate without any type of object'
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test006ASquareGeneratorCanFollowADistributionGiven [

	| randomSquareGenerator anAmountOfSquares randomSquares found squaresToUse distribution values aValue1 |
	anAmountOfSquares := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	squaresToUse := OrderedCollection new.
	squaresToUse add: AtomicBombSquare new.
	squaresToUse add: (HyperJumpSquare with: values).
	squaresToUse add: (MoonwalkSquare with: 3).
	squaresToUse add: SpeedUpSquare new.
	squaresToUse add: WormholeSquare new.
	squaresToUse add: NoEffectSquare new.
	distribution := #( 2 8 10 20 20 40 ) asOrderedCollection.
	randomSquareGenerator := SquareGenerator
		                         with: 100
		                         of: squaresToUse
		                         using: distribution.
	randomSquares := randomSquareGenerator generateObjects.
	found := OrderedCollection new.
	1000 timesRepeat: [ 
		randomSquares := randomSquareGenerator generateObjects.
		found addAll:
			(randomSquares select: [ :aSquare | 
				 aSquare isKindOf: HyperJumpSquare ]) ].
	self assert: (((found size) / 1000) between: 7 and: 9).
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test007ASquareGeneratorCanFollowADifferentDistributionGiven [

	| randomSquareGenerator anAmountOfSquares randomSquares found squaresToUse distribution values aValue1 |
	anAmountOfSquares := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	squaresToUse := OrderedCollection new.
	squaresToUse add: AtomicBombSquare new.
	squaresToUse add: (HyperJumpSquare with: values).
	squaresToUse add: (MoonwalkSquare with: 3).
	squaresToUse add: SpeedUpSquare new.
	squaresToUse add: WormholeSquare new.
	squaresToUse add: NoEffectSquare new.
	squaresToUse add: CardSquare new.
	distribution := #( 2 8 10 20 20 30 10 ) asOrderedCollection.
	randomSquareGenerator := SquareGenerator
		                         with: 100
		                         of: squaresToUse
		                         using: distribution.
	randomSquares := randomSquareGenerator generateObjects.
	found := OrderedCollection new.
	1000 timesRepeat: [ 
		randomSquares := randomSquareGenerator generateObjects.
		found addAll:
			(randomSquares select: [ :aSquare | 
				 aSquare isKindOf: HyperJumpSquare ]) ].
	self assert: (((found size) / 1000) between: 7 and: 9).
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test008ASquareGeneratorCannotGenerateOtherObjects [
	
	| randomSquareGenerator anAmountOfSquares squaresToUse distribution values aValue1 |
	anAmountOfSquares := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	squaresToUse := OrderedCollection new.
	squaresToUse add: AtomicBombSquare new.
	squaresToUse add: (HyperJumpSquare with: values).
	squaresToUse add: (MoonwalkSquare with: 3).
	squaresToUse add: SpeedUpSquare new.
	squaresToUse add: WormholeSquare new.
	squaresToUse add: NoEffectSquare new.
	squaresToUse add: SpeedCard new.
	distribution := #( 2 8 10 20 20 30 10 ) asOrderedCollection.
	
	self
		should: [ randomSquareGenerator := SquareGenerator
		                         with: anAmountOfSquares 
		                         of: squaresToUse
		                         using: distribution. ]
		raise: Error
		withMessage: 'Cannot Generate non square objects'
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test009ACardGeneratorCanGenerateANumberBetween1And100 [

	| randomCardGenerator anAmountOfCards cardsToUse distribution values aValue1 |
	anAmountOfCards := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	cardsToUse := OrderedCollection new.
	cardsToUse add: SpeedCard new.
	cardsToUse add: OverloadCard new.
	cardsToUse add: AccelerationCard new.
	cardsToUse add: CancellationCard new.
	cardsToUse add: RedoCard new.
	cardsToUse add: RepeatCard new.
	distribution := #( 20 20 10 10 20 20 ) asOrderedCollection.
	randomCardGenerator := CardGenerator
		                         with: anAmountOfCards 
		                         of: cardsToUse
		                         using: distribution.
	
	self assert: ((randomCardGenerator generateNumber) between: 1 and: 100). 
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test010ACardGeneratorCanGenerateCardsBasedOnAGivenAmountOfSquares [

	| randomCardGenerator anAmountOfCards cardsToUse distribution values aValue1 |
	anAmountOfCards := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	cardsToUse := OrderedCollection new.
	cardsToUse add: SpeedCard new.
	cardsToUse add: OverloadCard new.
	cardsToUse add: AccelerationCard new.
	cardsToUse add: CancellationCard new.
	cardsToUse add: RedoCard new.
	cardsToUse add: RepeatCard new.
	distribution := #( 20 20 10 10 20 20 ) asOrderedCollection.
	randomCardGenerator := CardGenerator
		                         with: anAmountOfCards 
		                         of: cardsToUse
		                         using: distribution.
	
	self assert: ((randomCardGenerator generateObjects) size) equals: 100. 
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test011ACardGeneratorCannotGenerateZeroOrLowerAmountOfCards [

	| randomCardGenerator anAmountOfCards cardsToUse distribution values aValue1 |
	anAmountOfCards := 0.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	cardsToUse := OrderedCollection new.
	cardsToUse add: SpeedCard new.
	cardsToUse add: OverloadCard new.
	cardsToUse add: AccelerationCard new.
	cardsToUse add: CancellationCard new.
	cardsToUse add: RedoCard new.
	cardsToUse add: RepeatCard new.
	distribution := #( 20 20 10 10 20 20 ) asOrderedCollection.
	self
		should: [ randomCardGenerator := CardGenerator
		                         with: anAmountOfCards 
		                         of: cardsToUse
		                         using: distribution. ]
		raise: Error
		withMessage: 'Amount of objects cannot be 0 or lower'
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test012ACardGeneratorCannotGenerateWithInvalidDistribution [

	| randomCardGenerator anAmountOfCards cardsToUse distribution values aValue1 |
	anAmountOfCards := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	cardsToUse := OrderedCollection new.
	cardsToUse add: SpeedCard new.
	cardsToUse add: OverloadCard new.
	cardsToUse add: AccelerationCard new.
	cardsToUse add: CancellationCard new.
	cardsToUse add: RedoCard new.
	cardsToUse add: RepeatCard new.
	distribution := #( 20 20 10 10 20 90 ) asOrderedCollection.
	self
		should: [ randomCardGenerator := CardGenerator
		                         with: anAmountOfCards 
		                         of: cardsToUse
		                         using: distribution. ]
		raise: Error
		withMessage: 'Distribution must add up 100%'
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test013ASquareGeneratorCannotGenerateWithoutAnyTypeOfCard [
	
	| randomCardGenerator anAmountOfCards cardsToUse distribution |
	anAmountOfCards := 100.
	cardsToUse := OrderedCollection new.
	distribution := #( 2 8 10 20 20 40 ) asOrderedCollection.
	
	self
		should: [ randomCardGenerator := CardGenerator
		                         with: anAmountOfCards 
		                         of: cardsToUse
		                         using: distribution. ]
		raise: Error
		withMessage: 'Cannot generate without any type of object'
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test014ACardGeneratorCanFollowADistributionGiven [

	| randomCardGenerator anAmountOfCards cardsToUse distribution values aValue1 randomCards found |
	anAmountOfCards := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	cardsToUse := OrderedCollection new.
	cardsToUse add: SpeedCard new.
	cardsToUse add: OverloadCard new.
	cardsToUse add: AccelerationCard new.
	cardsToUse add: CancellationCard new.
	cardsToUse add: RedoCard new.
	cardsToUse add: RepeatCard new.
	distribution := #( 20 20 10 10 20 20 ) asOrderedCollection.
	randomCardGenerator := CardGenerator
		                         with: 100
		                         of: cardsToUse
		                         using: distribution.
	randomCards := randomCardGenerator generateObjects.
	found := OrderedCollection new.
	1000 timesRepeat: [ 
		randomCards := randomCardGenerator generateObjects.
		found addAll:
			(randomCards select: [ :aCard | 
				 aCard isKindOf: SpeedCard ]) ].
	self assert: (((found size) / 1000) between: 19 and: 21).
	
	
	
]

{ #category : #tests }
SquareAndCardGeneratorTest >> test015ACardGeneratorCannotGenerateOtherObjects [

	| randomCardGenerator anAmountOfCards cardsToUse distribution values aValue1 |
	anAmountOfCards := 100.
	values := OrderedCollection new.
	aValue1 := Parsec with: 4.
	values add: aValue1.
	cardsToUse := OrderedCollection new.
	cardsToUse add: SpeedCard new.
	cardsToUse add: OverloadCard new.
	cardsToUse add: AccelerationCard new.
	cardsToUse add: CancellationCard new.
	cardsToUse add: RedoCard new.
	cardsToUse add: RepeatCard new.
	cardsToUse add: SpeedUpSquare new.
	distribution := #( 20 20 10 10 20 10 10 ) asOrderedCollection.
	self
		should: [ randomCardGenerator := CardGenerator
		                         with: anAmountOfCards 
		                         of: cardsToUse
		                         using: distribution. ]
		raise: Error
		withMessage: 'Cannot Generate non card objects'
	
	
	
]

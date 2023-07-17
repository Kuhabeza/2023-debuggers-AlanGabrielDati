Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #discarding }
Card >> discardInto: aGameEventManager [

	aGameEventManager discard: self.
]

{ #category : #comparing }
Card >> equals: anotherCard [

	^ anotherCard isKindOf: self class.
]

{ #category : #discarding }
Card >> isAbleToBeDiscarded [

	
]

{ #category : #discarding }
Card >> isUnableToBeDiscarded [

	
]

Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card >> discardInto: aGameEventManager [

	aGameEventManager discard: self.
]

{ #category : #comparing }
Card >> equals: anotherCard [

	^ anotherCard isKindOf: self class.
]

{ #category : #'as yet unclassified' }
Card >> isAbleToBeDiscarded [

	
]

{ #category : #'as yet unclassified' }
Card >> isUnableToBeDiscarded [

	
]

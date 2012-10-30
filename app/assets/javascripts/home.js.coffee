# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require jquery
//= require underscore.min
//= require backbone.min
//= require bootstrap.min

class SurveyApp
	
	constructor: -> 
		self = @
		@questions = []
		@tokens = []
		@tokenImpacts = []
		@tokenScores = []
		@outcomes = []
		@calls = [["/questions", "questions"], ["/tokens", "tokens"], ["/token_impacts", "tokenImpacts"], ["/outcomes", "outcomes"]]
		@callIndex = 0
		@$steps = [] 
		@nextCall() 
		
	nextCall:->
		# sequentially make db calls 
		if @callIndex is @calls.length
			@startSurvey()
		else
			@ajaxCall.apply(@, @calls[@callIndex++])
		
	ajaxCall:(callURL, setData)->
		$.ajax
			url: callURL
			dataType: "json"
			success: (data) => 
				@[setData] = data 
				@nextCall()
			error:=>
				console.log 'error'   

	startSurvey: ->
		self = @ 
		 
		$("#impress").css("visibility","visible")
		impress().init() 
		
		@$steps = $(".step")
		@createTokenScores()
 
		$('.affirm').click => 
			delay 1, => @checkResponses()
			
		$('.oppose').click => 
			delay 1, => @checkResponses()
			
	createTokenScores: -> 
		for token in @tokens
			tokenScore = new TokenScore()
			tokenScore.id = token.id
			tokenScore.title = token.title
			@tokenScores.push tokenScore

	checkResponses:-> 
		hasResponded = 0 
		
		impress().next() 
		
		# zero out all response scores
		for tokenScore in @tokenScores
			tokenScore.score = 0 
			
		#	check each question for response, apply response's impact on all tokens
		for step in @$steps
			qid = $(step).data('qid')
			
			if $(step).find('.affirm').hasClass('active')
				@recordAction(qid,'affirm')
				hasResponded++
			
			if $(step).find('.oppose').hasClass('active')
				@recordAction(qid,'oppose')
				hasResponded++
				
		if hasResponded is @questions.length then @displayOutcome()
		
	recordAction: (qid, affirmOppose)->
		# find all token impacts mapped to question
		for impact in @tokenImpacts 
			if impact.question_id is qid
				for score in @tokenScores
					# find token mapped to impact
					if score.id is impact.token_id
						score.score += if (affirmOppose is 'affirm') then impact.affirm_strength else impact.oppose_strength
						
	displayOutcome:->
		# when all questions are answered, determine the leading token
		sortedScores = sortByKey(@tokenScores, "score") 
		leadingToken = sortedScores[sortedScores.length-1]
		for outcome in @outcomes
			if outcome.token_id is leadingToken.id
				$("#outcome h1").html(outcome.description)
				break 

class TokenScore
	constructor: ->
		@id = ''
		@title = ''
		@score = 0
		
		
# Global functions
window.sortByKey = (array, key) ->
  array.sort (a, b) ->
    x = a[key]
    y = b[key]
    (if (x < y) then -1 else ((if (x > y) then 1 else 0)))
		
window.delay = (time, func)->
	setTimeout(func,time) 

# Init onload
window.surveyApp = new SurveyApp()
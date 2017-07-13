# AudioPlayer
audio = new Audio
audio.src = "mp3/" + 4 + ".mp3"
# UI
fontStyle01 =
	"text-align" : "center"
	"font-size" : "25px"
	"line-height" : "100px"


# textBox
textBox = new Layer # text box for speech string, hidden onload
	html: "Speak now"
	color: "#969696"
	backgroundColor: "none"
	width: 660
	height: 200
	opacity: 1
	html: "…"
	x: 50
	y: 200

textBox.style = # CSS for textbox
	"fontSize" : "48px"
	"fontWeight" : "300"
	"textAlign" : "center"
	"fontFamily": "Roboto" # imported in index.html
	"lineHeight" : "55px"
	
textBox.states =
	hidden: # hidden on start screen
		opacity: 0.0
	visible: # reveal
		opacity: 1.0
		
textBox.states.animationOptions =
	time: 0.1 # one-off animation timing

btnStart = new Layer
	html: "start"
	height: 100
	width: 100
	borderRadius: 100
	backgroundColor: "rgb(0, 224, 116)"
	style: fontStyle01
	
btnStart.center()

textBox.centerX()
textBox.y = btnStart.maxY + 100


# Speech API
# This API is currently prefixed in Chrome
SpeechRecognition = window.SpeechRecognition or window.webkitSpeechRecognition

SpeechGrammarList = window.SpeechGrammarList or window.webkitSpeechGrammarList

# Create a new recognizer
recognizer = new SpeechRecognition

# Start producing results before the person has finished speaking
recognizer.interimResults = true

# Set the language of the recognizer
recognizer.lang = 'en-US'

# Define a callback to process results
recognizer.onresult = (event) ->
  result = event.results[event.resultIndex]
  if result.isFinal
    handleSpeechResult(result[0].transcript)
    
    #print 'You said: ' + result[0].transcript
    textBox.html = result[0].transcript
    
  else
    #print 'Interim result', result[0].transcript
    textBox.html = result[0].transcript
  return


  
btnStart.onTap ->
	recognizer.start() 
	textBox.html = "speak now…" 

###
btnEnd.onTap ->
	recognizer.stop()  
	textBox.html = "" 
###  

# Define Words  
musicStartWords = ["play music", "start music", "music play", "music start"]

musicPauseWords = ["stop music", "pause music", "music pause", "music stop", "end music"]

handleSpeechResult = (_input) ->
	
	# Music Player
	for word in musicStartWords
		re = new RegExp("#{word}")		
		if re.test _input
			audio.play()
			
	for word in musicPauseWords
		re = new RegExp("#{word}")		
		if re.test _input
			audio.pause()		
	
	# Show Views
	if /hello/.test _input
		print "A"



textBox.html = "say play music" 
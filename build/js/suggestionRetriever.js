function SuggestionRetriever() {
	this.xmlHttp = new XMLHttpRequest(); // works for Firefox
}

// send Google suggest request based on user input
SuggestionRetriever.prototype.sendAjaxRequest = function (sInput, oAutoSuggestControl){
	var oThis = this;
	if (sInput == ""){
		oAutoSuggestControl.noInput();
	}
	else {
		var request = "suggest?q="+encodeURIComponent(sInput);
		oThis.xmlHttp.open("GET", request);
		oThis.xmlHttp.onreadystatechange = function () {
			oThis.getSuggestions(oAutoSuggestControl);
		};
		oThis.xmlHttp.send(null);
	}
}

// get response from Google suggest
SuggestionRetriever.prototype.getSuggestions = function (oAutoSuggestControl){
	var oThis = this;
	if (oThis.xmlHttp.readyState == 4){
		// get the CompleteSuggestion elements from the response
		var xmlResponse = oThis.xmlHttp.responseXML;
		if (xmlResponse){
			var s = xmlResponse.getElementsByTagName('CompleteSuggestion');
			if (s){
				// parse the suggestions
				var suggestions = []
				for (var i = 0; i < s.length; i++){
					var text = s[i].childNodes[0].getAttribute("data");
					suggestions.push(text);
				}
				oAutoSuggestControl.autoSuggest(suggestions);
			}
		}
	}
}
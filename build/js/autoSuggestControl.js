function AutoSuggestControl(oTextbox, oGhost, oDropDown, oProvider) {
	this.dropDown = oDropDown; // holds drop down div
    this.typeAhead = oGhost; // holds type ahead div
	this.userInput = "";
	this.provider = oProvider;
	this.textbox = oTextbox;
	this.highlighted = -1; // 0 if no suggestions are highlighted
    this.init();
}

AutoSuggestControl.prototype.init = function () {
	var oThis = this;

	this.textbox.onkeyup = function (oEvent) {
		oEvent = oEvent || window.event;
		oThis.onkeyupHandler(oEvent);
	}
    
    this.textbox.onkeydown = function (oEvent) {
        oEvent = oEvent || window.event;
        oThis.hideTypeAhead();
    }

	this.textbox.oninput = function() {
		oThis.getSuggestions();
	}

	this.textbox.onfocus = function(){
		oThis.getSuggestions();
	}
}

AutoSuggestControl.prototype.noInput = function (){
	this.hideTypeAhead();
    this.hideSuggestions();
	this.dropDown.innerHTML = "";
    this.userInput = "";
}

AutoSuggestControl.prototype.getSuggestions = function(){
	if (this.textbox.value == "")
		this.noInput();
	else{
		this.userInput = this.textbox.value;
		this.provider.sendAjaxRequest(this.userInput, this);
	}	
}

AutoSuggestControl.prototype.onkeyupHandler = function (oEvent){
	var key = oEvent.which || oEvent.keyCode;
	switch(key){
		// backspace: 8, delete: 46, enter: 13, control: 17,
		// shift: 16, tab: 9, capslock: 20, alt: 18
		// windows key: 19, esc: 27, home: 36, page up: 33
		// page down: 34, end: 35
		// up: 38, down: 40, left: 37, right: 39
		/* don't need because text box is filled with selection
		case 13:
		// enter
			if (this.highlighted != -1){
				var link = "";
				for (var i = 0; i < this.dropDown.childNodes.length; i++){
					oNode = this.dropDown.childNodes[i];
					if (oNode.className == "current");
						oNode.click();
				}
			}
			break;
		*/
		case 27:
		// esc
			this.hideSuggestions();
			this.textbox.blur();
			break;
		case 38:
		// up
			if (this.dropDown.childNodes.length == 0){
				this.clearHighlights();
				this.previewTextBox();
			}
			else if (this.highlighted - 1 == -1){
				this.clearHighlights();
				this.previewTextBox();
			}
			else if (this.highlighted -1 == -2){
				this.highlighted = this.dropDown.childNodes.length - 1;
				this.highlightSuggestion();
			} else {
				this.highlighted--;
				this.highlightSuggestion();
			}
			break;
		case 40:
		// down
			if (this.dropDown.childNodes.length == 0){
				this.clearHighlights();
				this.previewTextBox();
			}
			else if (this.highlighted + 1 == this.dropDown.childNodes.length){
				this.clearHighlights();
				this.previewTextBox();
			}
			else {
				this.highlighted++;
				this.highlightSuggestion();
			}
			break;
	}
}

AutoSuggestControl.prototype.autoSuggest = function (saSuggestions) {
    if (saSuggestions.length > 0) {
        this.updateTypeAhead(saSuggestions[0]);
        this.updateDropDown(saSuggestions);
    } else {
        this.hideSuggestions();
    }
}

AutoSuggestControl.prototype.previewTextBox = function(){
	if (this.highlighted == -1){
		this.textbox.value = this.userInput;
		if (this.dropDown.childNodes.length > 0)
			this.updateTypeAhead(this.dropDown.childNodes[0].textContent);
	}
	else if (this.dropDown.childNodes.length > 0){
		this.textbox.value = this.dropDown.childNodes[this.highlighted].textContent;
		this.hideTypeAhead();		
	}
	else {
		this.highlighted = -1;
		this.previewTextBox();
	}
}

AutoSuggestControl.prototype.updateTypeAhead = function(sSuggestion) {
    var suggested = sSuggestion.substring(0, this.textbox.value.length);
    if (suggested == this.textbox.value)
	    this.typeAhead.placeholder = sSuggestion;
	else
		this.hideTypeAhead();
}

AutoSuggestControl.prototype.updateDropDown = function(saSuggestions) {
	var oThis = this;
	var htmlCode = "";
	for (var i = 0; i < saSuggestions.length; i++){
		htmlCode += "<a class=\"list-group-item\">" + saSuggestions[i] + "</a>";
	}
	oThis.dropDown.innerHTML = htmlCode;

	for (var i = 0; i < oThis.dropDown.childNodes.length; i++) {
		var oNode = oThis.dropDown.childNodes[i];
		oNode.onmouseover = function (){
			oThis.clearHighlights();
			for (var j = 0; j < oThis.dropDown.childNodes.length; j++){
				if (oThis.dropDown.childNodes[j] == this){
					oThis.highlighted = j;
				}
			}
			this.className = "list-group-item current";
		}
		oNode.onmouseout = function (){
			oThis.highlighted = -1;
			oThis.clearHighlights();
		}

		oNode.onclick = function() {
			var action = "search?numResultsToSkip=0&numResultsToReturn=20&q=";
			var link = action + encodeURIComponent(this.textContent);
			window.location = link;
		}
	}

	this.dropDown.style.visibility = "visible";
}

AutoSuggestControl.prototype.hideSuggestions = function() {
	this.dropDown.style.visibility = "hidden";
	this.highlighted = -1;
}

AutoSuggestControl.prototype.hideTypeAhead = function() {
	this.typeAhead.placeholder = "";
}

AutoSuggestControl.prototype.highlightSuggestion = function () {
	var oThis = this;
	oThis.updateTypeAhead("");
	for (var i = 0; i < oThis.dropDown.childNodes.length; i++) {
		var oNode = oThis.dropDown.childNodes[i];
		if (i == oThis.highlighted){
			oNode.className = "list-group-item current";
		} else {
			oNode.className = "list-group-item";
		}
	}
	oThis.previewTextBox();
}

AutoSuggestControl.prototype.clearHighlights = function () {
	var oThis = this;
	oThis.highlighted = -1;
	for (var i = 0; i < oThis.dropDown.childNodes.length; i++) {
		var oNode = oThis.dropDown.childNodes[i];
		oNode.className = "list-group-item";
	}
}

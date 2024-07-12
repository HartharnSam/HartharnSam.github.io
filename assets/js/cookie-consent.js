window.cookieconsent.initialise({
  "palette": {
    "popup": {
      "background": "#000"
    },
    "button": {
      "background": "#f1d600"
    }
  },
  "type": "opt-in",
  "content": {
      "message": "This website uses cookies to ensure you get the best experience here.", 
      "href": "https://hartharnsam.github.io/privacy"
  },
  onInitialise: function (status) {
	console.log('Cookie consent initialised with status:', status);
    var type = this.options.type;
    var didConsent = this.hasConsented();
    if (type == 'opt-in' && didConsent) {
      // enable cookies
	  console.log('User consented. Enabling cookies');
      loadGAonConsent();
    }
    if (type == 'opt-out' && !didConsent) {
      // disable cookies
	  console.log('User did not consent. Disabling cookies');
    }
  },
  onStatusChange: function(status, chosenBefore) {
	console.log('Status changed to:', status);
    var type = this.options.type;
    var didConsent = this.hasConsented();
    if (type == 'opt-in' && didConsent) {
      // enable cookies
	  console.log('User consented. Enabling cookies.');
      loadGAonConsent();
    }
    if (type == 'opt-out' && !didConsent) {
      console.log('User did not consent. Disabling cookies.');
	  // disable cookies
    }
  },
  onRevokeChoice: function() {
	console.log('User revoked choice.');
    var type = this.options.type;
    if (type == 'opt-in') {
		console.log('Disabling cookies.');
      // disable cookies
    }
    if (type == 'opt-out') {
      // enable cookies
	  console.log('Enabling cookies');
      loadGAonConsent();
    }
  }
});

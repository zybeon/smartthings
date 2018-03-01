/**

 */
definition(
	name: "Router Wifi Presence",
	namespace: "zybeon",
	author: "zybeon",
	description: "Triggers Wifi Presence Status when HTTP GET Request is recieved",
	category: "My Apps",
	iconUrl: "http://icons.iconarchive.com/icons/icons8/windows-8/256/Network-Wifi-icon.png",
	iconX2Url: "http://icons.iconarchive.com/icons/icons8/windows-8/256/Network-Wifi-icon.png"
)

preferences {
	section(title: "Select Devices") {
		input "presence", "capability.presenceSensor", title: "Select Virtual Presence Sensor", required: true, multiple:false
		input "timeout", "number", title:"Number of Minutes WIFI says Away Before Actually Marked Away", defaultValue:1
	}
}

def installed() {
	createAccessToken()
	getToken()
}

def updated() {
}

mappings {
	path("/home") {
		action: [
			POST: "updatePresent"
		]
	}
	path("/away") {
		action: [
			POST:"updateNotPresentAfterTime"
		]
	}
}

def updatePresent() {
	if (presence.currentPresence == "present") {
		//cancel the pending depart
		log.debug "Arrived; sensor already present, unscheduling pending depart"
		unschedule();
	} else {
		log.debug "Arrived; Marking sensor present"
		presence.arrived();
	}
}

def updateNotPresentAfterTime() {
	if (timeout < 1) {
		updateNotPresent();
	} else {
		runIn(timeout * 60, updateNotPresent);
	}
}

def updateNotPresent() {
	log.debug "departed"
	presence.departed();
}

def getToken() {
	if (!state.accessToken) {
		getAccessToken()
		log.debug "Creating new Access Token: $state.accessToken"
	}
}

package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class UserPlantsMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( UserPlants ) { UserPlants it ->
            return [
            	id:it.serverId,
				userLogin:it.user?.login,
				plantName:it.user?.name,
				version     : it.version?:0,
			]
        }
    }
}
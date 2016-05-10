package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class ItemMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( Item ) { Item it ->
            return [
            	id:it.serverId,
				name:it.name,
				description:it.description,
			]
        }
    }
}

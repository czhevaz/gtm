package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class GallonMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( Gallon ) { Gallon it ->
            return [
            	id:it.serverId,
				code:it.code,
			    writeOff:it.writeOff,
			    reasonWriteOff:it.reasonWriteOff,
			    createdBy:it.createdBy,
				updatedBy:it.updatedBy,
				dateCreated:it.dateCreated,
				lastUpdated:it.lastUpdated,
			    itemName:it.item?.name,
			    receiveItem:it.receiveItem,

			]
        }
    }
}

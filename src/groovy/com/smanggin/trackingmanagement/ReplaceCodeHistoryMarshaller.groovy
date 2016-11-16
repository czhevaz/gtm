package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class ReplaceCodeHistoryMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( ReplaceCodeHistory ) { ReplaceCodeHistory it ->
            return [
            	id:it.serverId,
				code:it.gallon?.code,
			    oldNumber:it.oldNumber,
			    newNumber:it.newNumber,
			    createdBy:it.createdBy,
				updatedBy:it.updatedBy,
				dateCreated:it.dateCreated,
				lastUpdated:it.lastUpdated,
			    itemName:it.gallon?.item?.name,
			    plantName:it.plant?.name,
			    reason:it.reason
			    	

			]
        }
    }
}

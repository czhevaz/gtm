package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class QCOptionsMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( QCOptions ) { QCOptions it ->
            return [
            	id:it.serverId,
				name:it.description,
				
			]
        }
    }
}

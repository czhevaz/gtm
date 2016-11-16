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

			    receiveItemDate:it.receiveItem?.productionDate?:"",
			    receiveItemLine:it.receiveItem?.productionLine?:"",
			    receiveItemShift:it.receiveItem?.shift?:"",
			    receiveItemReffNo:it.receiveItem?.reffNo?:"",
			    supplierName:it.supplier?.name?:"",

			    year:it.yearExisting,
			    month:it.monthExisting,
			    groupShift:it.receiveItem?.groupShift?:"",


			]
        }
    }
}

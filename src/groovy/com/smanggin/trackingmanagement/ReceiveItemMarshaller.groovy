package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class ReceiveItemMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( ReceiveItem ) { ReceiveItem it ->
            return [
            	id:it.serverId,
				number:it.number,
			    plantName:it.plant?.name,
			    receivedDate:it.receivedDate,
			    createdBy:it.createdBy,
				updatedBy:it.updatedBy,
				dateCreated:it.dateCreated,
				lastUpdated:it.lastUpdated,
			    itemName:it.item?.name,
				transactionGroup:it.transactionGroup?.name,
				shift:it.shift,
				supplierName:it.supplier?.name,
				productionDate:it.productionDate,
				productionLine:it.productionLine,
				groupShift:it.groupShift,
				startNumber:it.startNumber,
				endNumber:it.endNumber


			]
        }
    }
}

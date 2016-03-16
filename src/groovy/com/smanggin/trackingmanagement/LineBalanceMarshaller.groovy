package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class LineBalanceMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( LineBalance ) { LineBalance it ->
            return [
            	serverId:it.serverId,
				plantName:it.plant?.name,
                plantServerId:it.plant?.serverId,
                lineName:it.line?.name,
                lineServerId:it.line?.serverId,
                date :it.date,
                beginQty:it.beginQty,
                inQty:it.inQty,
                outQty:it.outQty,
                endQty:it.endQty,


				version     : it.version?:0,
			]
        }
    }
}
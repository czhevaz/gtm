package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class QCQuestionsMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( QCQuestions ) { QCQuestions it ->
            return [
            	id:it.serverId,				
				parameterType:it.parameterType,
				sequenceNo : it.sequenceNo,
				qCOptions : it.qCOptions,
                qCDetails : it.qCDetails
			]
        }
    }





}



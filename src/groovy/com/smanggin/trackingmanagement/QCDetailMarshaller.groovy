package com.smanggin.trackingmanagement
import grails.converters.JSON


/*
ini class untuk modify output JSON 
ketika class ini dipanggil "as JSON"
*/

class QCDetailMarshaller {
 
    void register() {
        JSON.registerObjectMarshaller( QCDetail ) { QCDetail it ->
            return [
            	id:it.serverId,
				
				qcMasterName: it.qcMaster?.name,
				qcQuestionsName:it.qcQuestions?.parameterDesc,
   				qcOptionsId:it.qcOptions?.serverId,
				results : it.results,
    			reffDocClass : it.reffDocClass,
    			refDocId : it.refDocId,
	
			]
        }
    }
}

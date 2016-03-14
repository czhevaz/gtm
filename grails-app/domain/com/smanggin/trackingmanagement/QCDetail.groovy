package com.smanggin.trackingmanagement

class QCDetail {

	def globalService

	String serverId
	QCHeader qcHeader
	QCMaster qcMaster
	QCQuestions qcQuestions
	String   results

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated


	static	belongsTo	= [ QCHeader, QCMaster, QCQuestions]

	static	mapping = {

    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

        results type:'text'	

    	version true
    }


    static constraints = {
    	updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}

package com.smanggin.trackingmanagement

class QCDetail {

	def globalService

	String serverId
	QCHeader qcHeader
	QCMaster qcMaster
	QCQuestions qcQuestions
    QCOptions qcOptions

	String   results

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

    String reffDocClass
    String refDocId

    String toString() { return results+" - "+qcOptions?.description }

	static	belongsTo	= [QCHeader, QCMaster, QCQuestions]

	static	mapping = {

    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

        results type:'text'	

    	version true
    }

    static constraints = {
        qcHeader nullable:true
    	updatedBy nullable:true
        qcOptions nullable:true
        reffDocClass nullable:true
        refDocId nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}

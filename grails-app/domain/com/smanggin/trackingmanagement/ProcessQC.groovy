package com.smanggin.trackingmanagement

class ProcessQC {

	def globalService

	String serverId
	Process process
	QCMaster qcMaster
    Long sequenceNo
    Date date1
    Date date2

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static	belongsTo	= [ Process, QCMaster]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }

    static constraints = {

        sequenceNo nullable: true
        date1 nullable: true
        date2 nullable: true
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}

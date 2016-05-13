package com.smanggin.trackingmanagement

class QCOptions {

	def globalService

	String serverId
	
	QCQuestions qCQuestions
    String description

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated
    
    String toString() { return description }

	//static	belongsTo	= [QCMaster, QCQuestions]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

        description	 type:'text'

    	version true
    }

    static constraints = {
        description blank: true
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }


    def qcOptionsBy(question){
    	def qcOptions = QCOptions.createCriteria().list(){
    		eq('qCQuestions',question)
    	} 

    	return qcOptions
    }
}

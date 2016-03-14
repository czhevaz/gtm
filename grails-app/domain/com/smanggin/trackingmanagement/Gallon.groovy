package com.smanggin.trackingmanagement

class Gallon {
	
	def globalService

	String serverId
    String code
    Boolean writeOff

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static  hasMany = [productionInDetails:ProductionInDetail, qCHeaders:QCHeader]


	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }

    static constraints = {
        code blank: false
        writeOff nullable: false
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }

}

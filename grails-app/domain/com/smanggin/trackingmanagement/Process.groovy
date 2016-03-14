package com.smanggin.trackingmanagement

class Process {

	def globalService

    String serverId
    String code
    String name

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static  hasMany = [processQCs:ProcessQC, workCenters:WorkCenter]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }

    static constraints = {
        serverId blank: false
        code blank: false, unique: true, nullable: false
        name blank: false, nullable: false
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}

package com.smanggin.trackingmanagement

class Gallon {

	def globalService

	String serverId
    String code
    Boolean writeOff
    String reasonWriteOff

    String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated
    Item    item
    ReceiveItem receiveItem


	String toString() { return code } 

    static  belongsTo   = [Item]

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
        item nullable:true
        receiveItem nullable:true
        reasonWriteOff nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }

}

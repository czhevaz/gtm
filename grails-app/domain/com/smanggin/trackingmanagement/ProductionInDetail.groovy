package com.smanggin.trackingmanagement

class ProductionInDetail {

	def globalService
	
	String serverId
	ProductionInHeader productionInHeader
	TransactionGroup transactionGroup
    Gallon gallon
    String number
    Plant  plant
    Line   line
    Item   item


	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static	belongsTo	= [ ProductionInHeader, Gallon]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }

    static constraints = {
		
    	updatedBy nullable:true
        plant nullable:true
        productionInHeader nullable:true
        line nullable:true
        transactionGroup nullable:true
        gallon nullable:true
        item nullable:true
        number nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}

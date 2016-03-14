package com.smanggin.trackingmanagement

class TransactionGroup {

	def globalService

	String serverId
	String name
	Number transactionType /* 0 == production in & 1 == QC*/
	String prefix
	String numberingMethod
	String width
	Plant plant

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static  hasMany = [productionInHeaders:ProductionInHeader, qCHeaders:QCHeader]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

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

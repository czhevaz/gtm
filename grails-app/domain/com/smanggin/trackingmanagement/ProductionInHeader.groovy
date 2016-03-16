package com.smanggin.trackingmanagement

class ProductionInHeader {

	def globalService

	String serverId
	String number
	Plant  plant
	TransactionGroup transactionGroup
	Date date
	Float totalGallon

    WorkCenter workCenter

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	String toString() { return number }

	static	belongsTo	= [ Plant, TransactionGroup, WorkCenter]

	static  hasMany = [productionInDetails:ProductionInDetail]

	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }

    static constraints = {
        transactionGroup nullable: true
        workCenter nullable: true
    	updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
        Integer count = ProductionInHeader.countByTransactionGroup(transactionGroup)+1
        Integer width = transactionGroup.width
        String  prefix = transactionGroup.prefix

        String c = sprintf("%0${width}d",count)
        Date now = new Date()
        number = prefix+'/'+now.format(transactionGroup.numberingMethod)+'/'+c
    }

	def beforeInsert() {
		Integer count = ProductionInHeader.countByTransactionGroup(transactionGroup)+1
		Integer width = transactionGroup.width
		String  prefix = transactionGroup.prefix

		String c = sprintf("%0${width}d",count)
		Date now = new Date()
		number = prefix+'/'+now.format(transactionGroup.numberingMethod)+'/'+c
	}
}

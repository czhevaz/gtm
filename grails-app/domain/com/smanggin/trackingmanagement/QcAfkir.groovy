package com.smanggin.trackingmanagement

/**
 * QcAfkir
 * A domain class describes the data object and it's mapping to the database
 */
class QcAfkir {

	def globalService	
	/* Automatic timestamping of GORM */
	Date	dateCreated
	Date	lastUpdated
	String updatedBy
	String createdBy
	
	String serverId	
	String number
	Plant  plant
	TransactionGroup transactionGroup
	Date date

	WorkCenter workCenter
	QCQuestions qCQuestions

	Shift  shift
    Item   item

    String description

    String toString() { return number }


	static	belongsTo	= [QCQuestions, Plant, WorkCenter, TransactionGroup, Item]	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
	static	hasMany		= [qcAfkirDetails:QcAfkirDetail]	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static	mappedBy	= []	// specifies which property should be used in a mapping 
	
    static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }


    static constraints = {
    	
    	updatedBy nullable:true
        shift nullable:true
        item nullable:true
        description nullable:true
    }

    def beforeValidate(){
            
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }

    }

    def beforeInsert(){
		Integer count= QcAfkir.countByTransactionGroup(transactionGroup)+1
		Integer width= transactionGroup.width
		String  prefix = transactionGroup.prefix

		
		String c = sprintf("%0${width}d",count)
		Date now = new Date()
		number = prefix+'/'+now.format(transactionGroup.numberingMethod)+'/'+c
	}
}

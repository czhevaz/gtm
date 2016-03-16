package com.smanggin.trackingmanagement

class QCHeader {

	def globalService

	String serverId
	String number
	Plant  plant
	TransactionGroup transactionGroup
	Date date

	WorkCenter workCenter
	Gallon gallon
	QCActions qcActions

	String  createdBy
    String  updatedBy
    Date    dateCreated
    Date    lastUpdated


    String toString() { return number }

    static	belongsTo	= [ Plant, TransactionGroup, WorkCenter, Gallon, QCActions]

    static  hasMany = [qCDetails:QCDetail]

    static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }


    static constraints = {
    	qcActions nullable:true
    	updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }

    }

    def beforeInsert(){
		Integer count= QCHeader.countByTransactionGroup(transactionGroup)+1
		Integer width= transactionGroup.width
		String  prefix = transactionGroup.prefix

		
		String c = sprintf("%0${width}d",count)
		Date now = new Date()
		number = prefix+'/'+now.format(transactionGroup.numberingMethod)+'/'+c
	}

}

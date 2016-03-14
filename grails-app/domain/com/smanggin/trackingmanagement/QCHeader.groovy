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

    static	belongsTo	= [ Plant, TransactionGroup, WorkCenter, Gallon, QCActions]

    static  hasMany = [qCDetails:QCDetail]

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

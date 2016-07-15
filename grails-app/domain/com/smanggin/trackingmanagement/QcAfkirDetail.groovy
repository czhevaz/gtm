package com.smanggin.trackingmanagement

/**
 * QcAfkirDetail
 * A domain class describes the data object and it's mapping to the database
 */
class QcAfkirDetail {

	def globalService
	
	QcAfkir qcAfkir
	Gallon gallon
    String code
    
    String serverId
	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	static	belongsTo	= [ QcAfkir, Gallon]

	static	mapping = {
    	table 'qc_afkir_dtl'
        id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }

    static constraints = {
        code nullable:true
		gallon nullable:true
    	updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}

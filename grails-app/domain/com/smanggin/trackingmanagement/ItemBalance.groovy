package com.smanggin.trackingmanagement

/**
 * ItemBalance
 * A domain class describes the data object and it's mapping to the database
 */
class ItemBalance {

	def globalService

	String serverId
	WorkCenter workCenter
	Date date
	Float inQty
	Float outQty

	String  createdBy
	String  updatedBy
	Date	dateCreated
	Date	lastUpdated

	Shift shift
	String triggerId
	String triggerClass
	Item item
	
//	static	belongsTo	= []	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
//	static	hasMany		= []	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static	mappedBy	= []	// specifies which property should be used in a mapping 
	
    static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
    }
    
	static	constraints = {
		updatedBy nullable:true
    }
	
	def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}

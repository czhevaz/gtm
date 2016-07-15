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
    Integer year

    Supplier supplier
    String yearExisting
    String monthExisting
    Boolean type // 0 = new Item ,1 existing Item




	String toString() { return code } 

    static  belongsTo   = [Item,ReceiveItem]

	static  hasMany = [productionInDetails:ProductionInDetail, qCHeaders:QCHeader, replaceCodeHistory:ReplaceCodeHistory]


	static	mapping = {
    	id name : 'serverId',
        	type: 'string',
        	generator: 'assigned'

    	version true
        year formula: "date_part('year',date_created)"
    }

    static constraints = {
        code blank: false
        writeOff nullable: false
        updatedBy nullable:true
        item nullable:true
        receiveItem nullable:true
        reasonWriteOff nullable:true
        year nullable:true
        supplier nullable:true
        yearExisting nullable:true
        monthExisting nullable:true
        type nullable:true
    }

    static transients =['age']

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }

    Long getAge(){
        int year = Calendar.getInstance().get(Calendar.YEAR);
        def age = year - this.year
        return age
    }

}

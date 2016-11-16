package com.smanggin.trackingmanagement

/**
 * VrejectAnalysis
 * A domain class describes the data object and it's mapping to the database
 */
class VrejectAnalysis {

	String qcoptionId
	String qcoptionName
	String qcquestionsId
	String qcquestionsName
	String actualCondition
	String number
	String itemId
	String itemName
	String plantId
	String plantName
	String supplierId
	String supplierName
	Date   date
	String transactionType
	String qtyScanned

//	static	belongsTo	= []	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static	hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
//	static	hasMany		= []	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static	mappedBy	= []	// specifies which property should be used in a mapping 
	
    static	mapping = {
    	table "vrejectanalysis"
    	version false
    	qcoptionId column:'qc_options_id'
	    qcoptionName column:'qcoptions'
	    qcquestionsId column:'qcquestions_id'
	    qcquestionsName column:'qcquestions'
	    actualCondition column:'actual_condition'
	    number column:'number'
	    itemId column:'item_id'
	    itemName column:'itemname'
	    plantId column:'plant_id'
	    plantName column:'plant'
	    supplierId column:'supplierid'
	    supplierName column:'suppliername'
	    date column:'date'
	    transactionType column:'transaction_type'
	    qtyScanned column:'qtyscanned'
    }
    
	static	constraints = {
    }
	
	/*
	 * Methods of the Domain Class
	 */
//	@Override	// Override toString for a nicer / more descriptive UI 
//	public String toString() {
//		return "${name}";
//	}
}

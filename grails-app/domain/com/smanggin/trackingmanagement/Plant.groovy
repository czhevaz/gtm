package com.smanggin.trackingmanagement

class Plant {

    def globalService
    
    String serverId
    String code
    String name
    String address
    String city
    String postalCode
    String country
    String phone1
    String phone2
    String email

    String  createdBy
    String  updatedBy
    Date    dateCreated
    Date    lastUpdated


    static  hasMany = [lineBalances:LineBalance, productionInHeaders:ProductionInHeader, qCHeaders:QCHeader, userPlants:UserPlants, workCenters:WorkCenter]

    static  mapping = {
        id name : 'serverId',
            type: 'string',
            generator: 'assigned'

        address type: 'text'
        version true
    }

    static constraints = {
        
        code blank: false, nullable: false, unique: true
        name blank: false, nullable: false
        address blank: true
        city blank: true
        postalCode blank: true
        country blank: true
        phone1 blank: true
        phone2 blank: true
        email blank: true, email: true
        updatedBy nullable:true
    }
}

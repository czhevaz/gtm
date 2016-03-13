package com.smanggin.trackingmanagement

class User {
    def globalService

    String serverId
    String login
    String password
    String email
    String mobileNo1
    String mobileNo2
    Integer status

    String  createdBy
    String  updatedBy
    Date    dateCreated
    Date    lastUpdated

    static  hasMany = [userPlants:UserPlants]

    static  mapping = {
        id name : 'serverId',
            type: 'string',
            generator: 'assigned'

        version true
    }

    static constraints = {
        login blank: false, unique: true
        password size: 5..15, blank: false
        email email: true, blank: false
        mobileNo1 blank: true
        mobileNo2 blank: true
        updatedBy nullable:true
    }


    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }

}

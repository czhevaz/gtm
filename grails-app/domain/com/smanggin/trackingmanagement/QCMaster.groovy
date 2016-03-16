package com.smanggin.trackingmanagement

class QCMaster {

    def globalService

    String serverId
    String code
    String name
    Boolean active
    Date dateInActive
    User user /* user yg men incative kan*/

    String  createdBy
    String  updatedBy
    Date    dateCreated
    Date    lastUpdated

    String toString() { return name }

    static  hasMany = [processQCs:ProcessQC, qCDetails:QCDetail, qCQuestions:QCQuestions]

    static  mapping = {
        id name : 'serverId',
            type: 'string',
            generator: 'assigned'

        version true
    }

    static constraints = {
        serverId blank: false
        code blank: false, unique: true, nullable: false
        name blank: false, nullable: false
        dateInActive nullable:true
        user blank: true ,nullable:true
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }
}

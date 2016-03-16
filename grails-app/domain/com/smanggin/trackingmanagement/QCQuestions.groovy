package com.smanggin.trackingmanagement

class QCQuestions {

    def globalService

    String serverId
    QCMaster qCMaster
    Long sequenceNo
    Long parameterType 
    String parameterDesc
    String notes

    String  createdBy
    String  updatedBy
    Date    dateCreated
    Date    lastUpdated

    String toString() { return parameterDesc }

    static  belongsTo   = [QCMaster]

    static  hasMany = [qCDetails:QCDetail,qCOptions:QCOptions]

    static  mapping = {
        id name : 'serverId',
            type: 'string',
            generator: 'assigned'

        parameterDesc type: 'text'
        notes type: 'text'    

        version true
    }

    static constraints = {
        sequenceNo nullable: true
        parameterDesc blank: true
        notes blank: true
        updatedBy nullable:true
    }

    def beforeValidate(){
        
        if(!serverId || serverId ==null){
            
            serverId = globalService.UUIDGenerator()
        }
    }

    

    
}

package com.smanggin.trackingmanagement

class QCQuestions {

    Number qcSequence
    String qcParameterDesc
    String qcNotes

    static constraints = {
        qcSequence nullable: false, unique: true
        qcParameterDesc blank: true
        qcNotes blank: true
    }

    static mapping = {
        qcParameterDesc type: 'text'
        qcNotes type: 'text'
    }
}

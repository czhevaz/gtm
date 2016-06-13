package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QCQuestionsController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QCQuestionsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = QCQuestions.createCriteria().list(params){}
        [QCQuestionsInstanceList: results, QCQuestionsInstanceTotal: results.totalCount]
    }

    def create() {
        [QCQuestionsInstance: new QCQuestions(params)]
    }

    def save() {
        def QCQuestionsInstance = new QCQuestions(params)
        QCQuestionsInstance.createdBy = session.user
        QCQuestionsInstance.qCMaster = QCMaster.findByServerId(params.qCMaster?.serverId)
        if (!QCQuestionsInstance.save(flush: true)) {
            render(view: "create", model: [QCQuestionsInstance: QCQuestionsInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), QCQuestionsInstance.id])
        redirect(action: "show", id: QCQuestionsInstance.id)
    }

    def show() {
        def QCQuestionsInstance = QCQuestions.findByServerId(params.serverId)
        if (!QCQuestionsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), params.id])
            redirect(action: "list")
            return
        }

        [QCQuestionsInstance: QCQuestionsInstance]
    }

    def edit() {
        def QCQuestionsInstance = QCQuestions.findByServerId(params.serverId)
        if (!QCQuestionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), params.id])
            redirect(action: "list")
            return
        }

        [QCQuestionsInstance: QCQuestionsInstance]
    }

    def update() {
        def QCQuestionsInstance = QCQuestions.findByServerId(params.serverId)
        if (!QCQuestionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (QCQuestionsInstance.version > version) {
                QCQuestionsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'QCQuestions.label', default: 'QCQuestions')] as Object[],
                          "Another user has updated this QCQuestions while you were editing")
                render(view: "edit", model: [QCQuestionsInstance: QCQuestionsInstance])
                return
            }
        }

        QCQuestionsInstance.properties = params

        if (!QCQuestionsInstance.save(flush: true)) {
            render(view: "edit", model: [QCQuestionsInstance: QCQuestionsInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), QCQuestionsInstance.id])
        redirect(action: "show", id: QCQuestionsInstance.id)
    }

    def delete() {
        def QCQuestionsInstance = QCQuestions.get(params.id)
        if (!QCQuestionsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), params.id])
            redirect(action: "list")
            return
        }

        try {
            QCQuestionsInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def QCQuestionsInstance = (params.id) ? QCQuestions.get(params.id) : new QCQuestions()
        
        if (!QCQuestionsInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'QCQuestions.label', default: 'QCQuestions'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (QCQuestionsInstance.version > version) {
                    QCQuestionsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'QCQuestions.label', default: 'QCQuestions')] as Object[],
                              "Another user has updated this QCQuestions while you were editing")
                    render([success: false, messages: QCQuestionsInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        QCQuestionsInstance.properties = params
                       
        if (!QCQuestionsInstance.save(flush: true)) {
            render([success: false, messages: QCQuestionsInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QCQuestions.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QCQuestions.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def QCQuestionsInstance = QCQuestions.findByServerId(id)
        if (!QCQuestionsInstance)
            render([success: false] as JSON)
        else {
            try {
                QCQuestionsInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def QCQuestionsInstance = QCQuestions.findByServerId(params.id)
        if (!QCQuestionsInstance) {
            render(
                message : "QCQuestions.not.found",
            ) as JSON

        }
        else {
            render([QCQuestionsInstance : QCQuestionsInstance ] as JSON)
        }
    }
}

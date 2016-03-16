package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QCActionsController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QCActionsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = QCActions.createCriteria().list(params){}
        [QCActionsInstanceList: results, QCActionsInstanceTotal: results.totalCount]
    }

    def create() {
        [QCActionsInstance: new QCActions(params)]
    }

    def save() {
        def QCActionsInstance = new QCActions(params)
        QCActionsInstance.createdBy = session.user
        if (!QCActionsInstance.save(flush: true)) {
            render(view: "create", model: [QCActionsInstance: QCActionsInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'QCActions.label', default: 'QCActions'), QCActionsInstance.id])
        redirect(action: "show", id: QCActionsInstance.id)
    }

    def show() {
        def QCActionsInstance = QCActions.get(params.id)
        if (!QCActionsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCActions.label', default: 'QCActions'), params.id])
            redirect(action: "list")
            return
        }

        [QCActionsInstance: QCActionsInstance]
    }

    def edit() {
        def QCActionsInstance = QCActions.get(params.id)
        if (!QCActionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCActions.label', default: 'QCActions'), params.id])
            redirect(action: "list")
            return
        }

        [QCActionsInstance: QCActionsInstance]
    }

    def update() {
        def QCActionsInstance = QCActions.get(params.id)
        if (!QCActionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCActions.label', default: 'QCActions'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (QCActionsInstance.version > version) {
                QCActionsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'QCActions.label', default: 'QCActions')] as Object[],
                          "Another user has updated this QCActions while you were editing")
                render(view: "edit", model: [QCActionsInstance: QCActionsInstance])
                return
            }
        }

        QCActionsInstance.properties = params

        if (!QCActionsInstance.save(flush: true)) {
            render(view: "edit", model: [QCActionsInstance: QCActionsInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'QCActions.label', default: 'QCActions'), QCActionsInstance.id])
        redirect(action: "show", id: QCActionsInstance.id)
    }

    def delete() {
        def QCActionsInstance = QCActions.get(params.id)
        if (!QCActionsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCActions.label', default: 'QCActions'), params.id])
            redirect(action: "list")
            return
        }

        try {
            QCActionsInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'QCActions.label', default: 'QCActions'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'QCActions.label', default: 'QCActions'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def QCActionsInstance = (params.id) ? QCActions.get(params.id) : new QCActions()
        
        if (!QCActionsInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'QCActions.label', default: 'QCActions'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (QCActionsInstance.version > version) {
                    QCActionsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'QCActions.label', default: 'QCActions')] as Object[],
                              "Another user has updated this QCActions while you were editing")
                    render([success: false, messages: QCActionsInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        QCActionsInstance.properties = params
                       
        if (!QCActionsInstance.save(flush: true)) {
            render([success: false, messages: QCActionsInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QCActions.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QCActions.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def QCActionsInstance = QCActions.get(id)
        if (!QCActionsInstance)
            render([success: false] as JSON)
        else {
            try {
                QCActionsInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        println "jshow >>>>>>>>>>>>>>>> " +params 
        def QCActionsInstance = QCActions.findByServerId(params.serverId)
        if (!QCActionsInstance) {
            render(
                message : "QCActions.not.found",
            ) as JSON

        }
        else {
            render([QCActionsInstance : QCActionsInstance ] as JSON)
        }
    }
}

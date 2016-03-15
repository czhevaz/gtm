package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QCOptionsController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QCOptionsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = QCOptions.createCriteria().list(params){}
        [QCOptionsInstanceList: results, QCOptionsInstanceTotal: results.totalCount]
    }

    def create() {
        [QCOptionsInstance: new QCOptions(params)]
    }

    def save() {
        def QCOptionsInstance = new QCOptions(params)
        if (!QCOptionsInstance.save(flush: true)) {
            render(view: "create", model: [QCOptionsInstance: QCOptionsInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), QCOptionsInstance.id])
        redirect(action: "show", id: QCOptionsInstance.id)
    }

    def show() {
        def QCOptionsInstance = QCOptions.get(params.id)
        if (!QCOptionsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), params.id])
            redirect(action: "list")
            return
        }

        [QCOptionsInstance: QCOptionsInstance]
    }

    def edit() {
        def QCOptionsInstance = QCOptions.get(params.id)
        if (!QCOptionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), params.id])
            redirect(action: "list")
            return
        }

        [QCOptionsInstance: QCOptionsInstance]
    }

    def update() {
        def QCOptionsInstance = QCOptions.get(params.id)
        if (!QCOptionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (QCOptionsInstance.version > version) {
                QCOptionsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'QCOptions.label', default: 'QCOptions')] as Object[],
                          "Another user has updated this QCOptions while you were editing")
                render(view: "edit", model: [QCOptionsInstance: QCOptionsInstance])
                return
            }
        }

        QCOptionsInstance.properties = params

        if (!QCOptionsInstance.save(flush: true)) {
            render(view: "edit", model: [QCOptionsInstance: QCOptionsInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), QCOptionsInstance.id])
        redirect(action: "show", id: QCOptionsInstance.id)
    }

    def delete() {
        def QCOptionsInstance = QCOptions.get(params.id)
        if (!QCOptionsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), params.id])
            redirect(action: "list")
            return
        }

        try {
            QCOptionsInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def QCOptionsInstance = (params.id) ? QCOptions.get(params.id) : new QCOptions()
        
        if (!QCOptionsInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'QCOptions.label', default: 'QCOptions'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (QCOptionsInstance.version > version) {
                    QCOptionsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'QCOptions.label', default: 'QCOptions')] as Object[],
                              "Another user has updated this QCOptions while you were editing")
                    render([success: false, messages: QCOptionsInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        QCOptionsInstance.properties = params
                       
        if (!QCOptionsInstance.save(flush: true)) {
            render([success: false, messages: QCOptionsInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QCOptions.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QCOptions.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def QCOptionsInstance = QCOptions.get(id)
        if (!QCOptionsInstance)
            render([success: false] as JSON)
        else {
            try {
                QCOptionsInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def QCOptionsInstance = QCOptions.get(params.id)
        if (!QCOptionsInstance) {
            render(
                message : "QCOptions.not.found",
            ) as JSON

        }
        else {
            render([QCOptionsInstance : QCOptionsInstance ] as JSON)
        }
    }
}

package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QCHeaderController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QCHeaderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = QCHeader.createCriteria().list(params){}
        [QCHeaderInstanceList: results, QCHeaderInstanceTotal: results.totalCount]
    }

    def create() {
        [QCHeaderInstance: new QCHeader(params)]
    }

    def save() {
        def QCHeaderInstance = new QCHeader(params)
        if (!QCHeaderInstance.save(flush: true)) {
            render(view: "create", model: [QCHeaderInstance: QCHeaderInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), QCHeaderInstance.id])
        redirect(action: "show", id: QCHeaderInstance.id)
    }

    def show() {
        def QCHeaderInstance = QCHeader.get(params.id)
        if (!QCHeaderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
            return
        }

        [QCHeaderInstance: QCHeaderInstance]
    }

    def edit() {
        def QCHeaderInstance = QCHeader.get(params.id)
        if (!QCHeaderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
            return
        }

        [QCHeaderInstance: QCHeaderInstance]
    }

    def update() {
        def QCHeaderInstance = QCHeader.get(params.id)
        if (!QCHeaderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (QCHeaderInstance.version > version) {
                QCHeaderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'QCHeader.label', default: 'QCHeader')] as Object[],
                          "Another user has updated this QCHeader while you were editing")
                render(view: "edit", model: [QCHeaderInstance: QCHeaderInstance])
                return
            }
        }

        QCHeaderInstance.properties = params

        if (!QCHeaderInstance.save(flush: true)) {
            render(view: "edit", model: [QCHeaderInstance: QCHeaderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), QCHeaderInstance.id])
        redirect(action: "show", id: QCHeaderInstance.id)
    }

    def delete() {
        def QCHeaderInstance = QCHeader.get(params.id)
        if (!QCHeaderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
            return
        }

        try {
            QCHeaderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def QCHeaderInstance = (params.id) ? QCHeader.get(params.id) : new QCHeader()
        
        if (!QCHeaderInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'QCHeader.label', default: 'QCHeader'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (QCHeaderInstance.version > version) {
                    QCHeaderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'QCHeader.label', default: 'QCHeader')] as Object[],
                              "Another user has updated this QCHeader while you were editing")
                    render([success: false, messages: QCHeaderInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        QCHeaderInstance.properties = params
                       
        if (!QCHeaderInstance.save(flush: true)) {
            render([success: false, messages: QCHeaderInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QCHeader.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QCHeader.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def QCHeaderInstance = QCHeader.get(id)
        if (!QCHeaderInstance)
            render([success: false] as JSON)
        else {
            try {
                QCHeaderInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def QCHeaderInstance = QCHeader.get(params.id)
        if (!QCHeaderInstance) {
            render(
                message : "QCHeader.not.found",
            ) as JSON

        }
        else {
            render([QCHeaderInstance : QCHeaderInstance ] as JSON)
        }
    }
}

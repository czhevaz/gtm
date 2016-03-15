package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QCMasterController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QCMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = QCMaster.createCriteria().list(params){}
        [QCMasterInstanceList: results, QCMasterInstanceTotal: results.totalCount]
    }

    def create() {
        [QCMasterInstance: new QCMaster(params)]
    }

    def save() {
        def QCMasterInstance = new QCMaster(params)
        QCMasterInstance.createdBy = session.user
        if (!QCMasterInstance.save(flush: true)) {
            render(view: "create", model: [QCMasterInstance: QCMasterInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), QCMasterInstance.id])
        redirect(action: "show", id: QCMasterInstance.id)
    }

    def show() {
        def QCMasterInstance = QCMaster.get(params.id)
        if (!QCMasterInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), params.id])
            redirect(action: "list")
            return
        }

        [QCMasterInstance: QCMasterInstance]
    }

    def edit() {
        def QCMasterInstance = QCMaster.get(params.id)
        if (!QCMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), params.id])
            redirect(action: "list")
            return
        }

        [QCMasterInstance: QCMasterInstance]
    }

    def update() {
        def QCMasterInstance = QCMaster.get(params.id)
        if (!QCMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (QCMasterInstance.version > version) {
                QCMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'QCMaster.label', default: 'QCMaster')] as Object[],
                          "Another user has updated this QCMaster while you were editing")
                render(view: "edit", model: [QCMasterInstance: QCMasterInstance])
                return
            }
        }

        QCMasterInstance.properties = params

        if (!QCMasterInstance.save(flush: true)) {
            render(view: "edit", model: [QCMasterInstance: QCMasterInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), QCMasterInstance.id])
        redirect(action: "show", id: QCMasterInstance.id)
    }

    def delete() {
        def QCMasterInstance = QCMaster.get(params.id)
        if (!QCMasterInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), params.id])
            redirect(action: "list")
            return
        }

        try {
            QCMasterInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def QCMasterInstance = (params.id) ? QCMaster.get(params.id) : new QCMaster()
        
        if (!QCMasterInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'QCMaster.label', default: 'QCMaster'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (QCMasterInstance.version > version) {
                    QCMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'QCMaster.label', default: 'QCMaster')] as Object[],
                              "Another user has updated this QCMaster while you were editing")
                    render([success: false, messages: QCMasterInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        QCMasterInstance.properties = params
                       
        if (!QCMasterInstance.save(flush: true)) {
            render([success: false, messages: QCMasterInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QCMaster.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QCMaster.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def QCMasterInstance = QCMaster.get(id)
        if (!QCMasterInstance)
            render([success: false] as JSON)
        else {
            try {
                QCMasterInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def QCMasterInstance = QCMaster.get(params.id)
        if (!QCMasterInstance) {
            render(
                message : "QCMaster.not.found",
            ) as JSON

        }
        else {
            render([QCMasterInstance : QCMasterInstance ] as JSON)
        }
    }
}

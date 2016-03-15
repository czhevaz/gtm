package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * QCDetailController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class QCDetailController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = QCDetail.createCriteria().list(params){}
        [QCDetailInstanceList: results, QCDetailInstanceTotal: results.totalCount]
    }

    def create() {
        [QCDetailInstance: new QCDetail(params)]
    }

    def save() {
        def QCDetailInstance = new QCDetail(params)
        if (!QCDetailInstance.save(flush: true)) {
            render(view: "create", model: [QCDetailInstance: QCDetailInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), QCDetailInstance.id])
        redirect(action: "show", id: QCDetailInstance.id)
    }

    def show() {
        def QCDetailInstance = QCDetail.get(params.id)
        if (!QCDetailInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), params.id])
            redirect(action: "list")
            return
        }

        [QCDetailInstance: QCDetailInstance]
    }

    def edit() {
        def QCDetailInstance = QCDetail.get(params.id)
        if (!QCDetailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), params.id])
            redirect(action: "list")
            return
        }

        [QCDetailInstance: QCDetailInstance]
    }

    def update() {
        def QCDetailInstance = QCDetail.get(params.id)
        if (!QCDetailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (QCDetailInstance.version > version) {
                QCDetailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'QCDetail.label', default: 'QCDetail')] as Object[],
                          "Another user has updated this QCDetail while you were editing")
                render(view: "edit", model: [QCDetailInstance: QCDetailInstance])
                return
            }
        }

        QCDetailInstance.properties = params

        if (!QCDetailInstance.save(flush: true)) {
            render(view: "edit", model: [QCDetailInstance: QCDetailInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), QCDetailInstance.id])
        redirect(action: "show", id: QCDetailInstance.id)
    }

    def delete() {
        def QCDetailInstance = QCDetail.get(params.id)
        if (!QCDetailInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), params.id])
            redirect(action: "list")
            return
        }

        try {
            QCDetailInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def QCDetailInstance = (params.id) ? QCDetail.get(params.id) : new QCDetail()
        
        if (!QCDetailInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'QCDetail.label', default: 'QCDetail'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (QCDetailInstance.version > version) {
                    QCDetailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'QCDetail.label', default: 'QCDetail')] as Object[],
                              "Another user has updated this QCDetail while you were editing")
                    render([success: false, messages: QCDetailInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        QCDetailInstance.properties = params
                       
        if (!QCDetailInstance.save(flush: true)) {
            render([success: false, messages: QCDetailInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = QCDetail.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render QCDetail.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def QCDetailInstance = QCDetail.get(id)
        if (!QCDetailInstance)
            render([success: false] as JSON)
        else {
            try {
                QCDetailInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def QCDetailInstance = QCDetail.get(params.id)
        if (!QCDetailInstance) {
            render(
                message : "QCDetail.not.found",
            ) as JSON

        }
        else {
            render([QCDetailInstance : QCDetailInstance ] as JSON)
        }
    }
}

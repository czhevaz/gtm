package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ProductionInHeaderController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ProductionInHeaderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = ProductionInHeader.createCriteria().list(params){}
        [productionInHeaderInstanceList: results, productionInHeaderInstanceTotal: results.totalCount]
    }

    def create() {
        [productionInHeaderInstance: new ProductionInHeader(params)]
    }

    def save() {
        def productionInHeaderInstance = new ProductionInHeader(params)
        if (!productionInHeaderInstance.save(flush: true)) {
            render(view: "create", model: [productionInHeaderInstance: productionInHeaderInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), productionInHeaderInstance.id])
        redirect(action: "show", id: productionInHeaderInstance.id)
    }

    def show() {
        def productionInHeaderInstance = ProductionInHeader.get(params.id)
        if (!productionInHeaderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), params.id])
            redirect(action: "list")
            return
        }

        [productionInHeaderInstance: productionInHeaderInstance]
    }

    def edit() {
        def productionInHeaderInstance = ProductionInHeader.get(params.id)
        if (!productionInHeaderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), params.id])
            redirect(action: "list")
            return
        }

        [productionInHeaderInstance: productionInHeaderInstance]
    }

    def update() {
        def productionInHeaderInstance = ProductionInHeader.get(params.id)
        if (!productionInHeaderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (productionInHeaderInstance.version > version) {
                productionInHeaderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'productionInHeader.label', default: 'ProductionInHeader')] as Object[],
                          "Another user has updated this ProductionInHeader while you were editing")
                render(view: "edit", model: [productionInHeaderInstance: productionInHeaderInstance])
                return
            }
        }

        productionInHeaderInstance.properties = params

        if (!productionInHeaderInstance.save(flush: true)) {
            render(view: "edit", model: [productionInHeaderInstance: productionInHeaderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), productionInHeaderInstance.id])
        redirect(action: "show", id: productionInHeaderInstance.id)
    }

    def delete() {
        def productionInHeaderInstance = ProductionInHeader.get(params.id)
        if (!productionInHeaderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), params.id])
            redirect(action: "list")
            return
        }

        try {
            productionInHeaderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def productionInHeaderInstance = (params.id) ? ProductionInHeader.get(params.id) : new ProductionInHeader()
        
        if (!productionInHeaderInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'productionInHeader.label', default: 'ProductionInHeader'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (productionInHeaderInstance.version > version) {
                    productionInHeaderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'productionInHeader.label', default: 'ProductionInHeader')] as Object[],
                              "Another user has updated this ProductionInHeader while you were editing")
                    render([success: false, messages: productionInHeaderInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        productionInHeaderInstance.properties = params
                       
        if (!productionInHeaderInstance.save(flush: true)) {
            render([success: false, messages: productionInHeaderInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = ProductionInHeader.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render ProductionInHeader.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def productionInHeaderInstance = ProductionInHeader.get(id)
        if (!productionInHeaderInstance)
            render([success: false] as JSON)
        else {
            try {
                productionInHeaderInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def productionInHeaderInstance = ProductionInHeader.get(params.id)
        if (!productionInHeaderInstance) {
            render(
                message : "productionInHeader.not.found",
            ) as JSON

        }
        else {
            render([productionInHeaderInstance : productionInHeaderInstance ] as JSON)
        }
    }
}

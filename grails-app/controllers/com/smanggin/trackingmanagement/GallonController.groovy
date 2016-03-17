package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * GallonController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class GallonController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = Gallon.createCriteria().list(params){}
        [gallonInstanceList: results, gallonInstanceTotal: results.totalCount]
    }

    def create() {
        [gallonInstance: new Gallon(params)]
    }

    def save() {
        def gallonInstance = new Gallon(params)
        if (!gallonInstance.save(flush: true)) {
            render(view: "create", model: [gallonInstance: gallonInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'gallon.label', default: 'Gallon'), gallonInstance.id])
        redirect(action: "show", id: gallonInstance.id)
    }

    def show() {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
            return
        }

        [gallonInstance: gallonInstance]
    }

    def edit() {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
            return
        }

        [gallonInstance: gallonInstance]
    }

    def update() {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (gallonInstance.version > version) {
                gallonInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'gallon.label', default: 'Gallon')] as Object[],
                          "Another user has updated this Gallon while you were editing")
                render(view: "edit", model: [gallonInstance: gallonInstance])
                return
            }
        }

        gallonInstance.properties = params

        if (!gallonInstance.save(flush: true)) {
            render(view: "edit", model: [gallonInstance: gallonInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'gallon.label', default: 'Gallon'), gallonInstance.id])
        redirect(action: "show", id: gallonInstance.id)
    }

    def delete() {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
            return
        }

        try {
            gallonInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def gallonInstance = (params.id) ? Gallon.get(params.id) : new Gallon()
        
        if (!gallonInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'gallon.label', default: 'Gallon'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (gallonInstance.version > version) {
                    gallonInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'gallon.label', default: 'Gallon')] as Object[],
                              "Another user has updated this Gallon while you were editing")
                    render([success: false, messages: gallonInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        gallonInstance.properties = params
                       
        if (!gallonInstance.save(flush: true)) {
            render([success: false, messages: gallonInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = Gallon.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render Gallon.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def gallonInstance = Gallon.get(id)
        if (!gallonInstance)
            render([success: false] as JSON)
        else {
            try {
                gallonInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def gallonInstance = Gallon.get(params.id)
        if (!gallonInstance) {
            render(
                message : "gallon.not.found",
            ) as JSON

        }
        else {
            render([gallonInstance : gallonInstance ] as JSON)
        }
    }

    def report(){
        def view

        if(params.newGallon){
            view = "newGallon"
            render(view: "${view}")
        } else if(params.gallonHistory) {
            view = "gallonHistory"
            render(view: "${view}")
        } else if (params.lineBalance) {
            view = "lineBalance"
            render(view: "${view}")
        }
    }

    def newGallon() {
        return ''
    }
}

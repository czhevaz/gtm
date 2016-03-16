package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * PlantController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class PlantController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = Plant.createCriteria().list(params){}
        [plantInstanceList: results, plantInstanceTotal: results.totalCount]
    }

    def create() {
        [plantInstance: new Plant(params)]
    }

    def save() {
        def plantInstance = new Plant(params)
        if (!plantInstance.save(flush: true)) {
            render(view: "create", model: [plantInstance: plantInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'plant.label', default: 'Plant'), plantInstance.id])
        redirect(action: "show", id: plantInstance.id)
    }

    def show() {
        def plantInstance = Plant.findByServerId(params.serverId)
        if (!plantInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'plant.label', default: 'Plant'), params.id])
            redirect(action: "list")
            return
        }

        [plantInstance: plantInstance]
    }

    def edit() {
        def plantInstance = Plant.findByServerId(params.serverId)
        if (!plantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'plant.label', default: 'Plant'), params.id])
            redirect(action: "list")
            return
        }

        [plantInstance: plantInstance]
    }

    def update() {
        def plantInstance = Plant.findByServerId(params.serverId)
        if (!plantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'plant.label', default: 'Plant'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (plantInstance.version > version) {
                plantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'plant.label', default: 'Plant')] as Object[],
                          "Another user has updated this Plant while you were editing")
                render(view: "edit", model: [plantInstance: plantInstance])
                return
            }
        }

        plantInstance.properties = params

        if (!plantInstance.save(flush: true)) {
            render(view: "edit", model: [plantInstance: plantInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'plant.label', default: 'Plant'), plantInstance.id])
        redirect(action: "show", id: plantInstance.id)
    }

    def delete() {
        def plantInstance = Plant.get(params.id)
        if (!plantInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'plant.label', default: 'Plant'), params.id])
            redirect(action: "list")
            return
        }

        try {
            plantInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'plant.label', default: 'Plant'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'plant.label', default: 'Plant'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def plantInstance = (params.id) ? Plant.get(params.id) : new Plant()
        
        if (!plantInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'plant.label', default: 'Plant'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (plantInstance.version > version) {
                    plantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'plant.label', default: 'Plant')] as Object[],
                              "Another user has updated this Plant while you were editing")
                    render([success: false, messages: plantInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        plantInstance.properties = params
                       
        if (!plantInstance.save(flush: true)) {
            render([success: false, messages: plantInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = Plant.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render Plant.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def plantInstance = Plant.get(id)
        if (!plantInstance)
            render([success: false] as JSON)
        else {
            try {
                plantInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def plantInstance = Plant.get(params.id)
        if (!plantInstance) {
            render(
                message : "plant.not.found",
            ) as JSON

        }
        else {
            render([plantInstance : plantInstance ] as JSON)
        }
    }
}

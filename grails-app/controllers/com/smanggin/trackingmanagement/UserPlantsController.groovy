package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * UserPlantsController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class UserPlantsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = UserPlants.createCriteria().list(params){}
        [userPlantsInstanceList: results, userPlantsInstanceTotal: results.totalCount]
    }

    def create() {
        [userPlantsInstance: new UserPlants(params)]
    }

    def save() {
        def userPlantsInstance = new UserPlants(params)
        if (!userPlantsInstance.save(flush: true)) {
            render(view: "create", model: [userPlantsInstance: userPlantsInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), userPlantsInstance.id])
        redirect(action: "show", id: userPlantsInstance.id)
    }

    def show() {
        def userPlantsInstance = UserPlants.get(params.id)
        if (!userPlantsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), params.id])
            redirect(action: "list")
            return
        }

        [userPlantsInstance: userPlantsInstance]
    }

    def edit() {
        def userPlantsInstance = UserPlants.get(params.id)
        if (!userPlantsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), params.id])
            redirect(action: "list")
            return
        }

        [userPlantsInstance: userPlantsInstance]
    }

    def update() {
        def userPlantsInstance = UserPlants.get(params.id)
        if (!userPlantsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userPlantsInstance.version > version) {
                userPlantsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'userPlants.label', default: 'UserPlants')] as Object[],
                          "Another user has updated this UserPlants while you were editing")
                render(view: "edit", model: [userPlantsInstance: userPlantsInstance])
                return
            }
        }

        userPlantsInstance.properties = params

        if (!userPlantsInstance.save(flush: true)) {
            render(view: "edit", model: [userPlantsInstance: userPlantsInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), userPlantsInstance.id])
        redirect(action: "show", id: userPlantsInstance.id)
    }

    def delete() {
        def userPlantsInstance = UserPlants.get(params.id)
        if (!userPlantsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), params.id])
            redirect(action: "list")
            return
        }

        try {
            userPlantsInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def userPlantsInstance = (params.id) ? UserPlants.get(params.id) : new UserPlants()
        
        if (!userPlantsInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'userPlants.label', default: 'UserPlants'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (userPlantsInstance.version > version) {
                    userPlantsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'userPlants.label', default: 'UserPlants')] as Object[],
                              "Another user has updated this UserPlants while you were editing")
                    render([success: false, messages: userPlantsInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        userPlantsInstance.properties = params
                       
        if (!userPlantsInstance.save(flush: true)) {
            render([success: false, messages: userPlantsInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = UserPlants.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render UserPlants.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def userPlantsInstance = UserPlants.get(id)
        if (!userPlantsInstance)
            render([success: false] as JSON)
        else {
            try {
                userPlantsInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def userPlantsInstance = UserPlants.get(params.id)
        if (!userPlantsInstance) {
            render(
                message : "userPlants.not.found",
            ) as JSON

        }
        else {
            render([userPlantsInstance : userPlantsInstance ] as JSON)
        }
    }
}

package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * AppSettingController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class AppSettingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = AppSetting.createCriteria().list(params){}
        [appSettingInstanceList: results, appSettingInstanceTotal: results.totalCount]
    }

    def create() {
        [appSettingInstance: new AppSetting(params)]
    }

    def save() {
        def appSettingInstance = new AppSetting(params)
        if (!appSettingInstance.save(flush: true)) {
            render(view: "create", model: [appSettingInstance: appSettingInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), appSettingInstance.id])
        redirect(action: "show", id: appSettingInstance.id)
    }

    def show() {
        def appSettingInstance = AppSetting.get(params.id)
        if (!appSettingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), params.id])
            redirect(action: "list")
            return
        }

        [appSettingInstance: appSettingInstance]
    }

    def edit() {
        def appSettingInstance = AppSetting.get(params.id)
        if (!appSettingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), params.id])
            redirect(action: "list")
            return
        }

        [appSettingInstance: appSettingInstance]
    }

    def update() {
        def appSettingInstance = AppSetting.get(params.id)
        if (!appSettingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (appSettingInstance.version > version) {
                appSettingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'appSetting.label', default: 'AppSetting')] as Object[],
                          "Another user has updated this AppSetting while you were editing")
                render(view: "edit", model: [appSettingInstance: appSettingInstance])
                return
            }
        }

        appSettingInstance.properties = params

        if (!appSettingInstance.save(flush: true)) {
            render(view: "edit", model: [appSettingInstance: appSettingInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), appSettingInstance.id])
        redirect(action: "show", id: appSettingInstance.id)
    }

    def delete() {
        def appSettingInstance = AppSetting.get(params.id)
        if (!appSettingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), params.id])
            redirect(action: "list")
            return
        }

        try {
            appSettingInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def appSettingInstance = (params.id) ? AppSetting.get(params.id) : new AppSetting()
        
        if (!appSettingInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'appSetting.label', default: 'AppSetting'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (appSettingInstance.version > version) {
                    appSettingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'appSetting.label', default: 'AppSetting')] as Object[],
                              "Another user has updated this AppSetting while you were editing")
                    render([success: false, messages: appSettingInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        appSettingInstance.properties = params
                       
        if (!appSettingInstance.save(flush: true)) {
            render([success: false, messages: appSettingInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = AppSetting.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render AppSetting.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def appSettingInstance = AppSetting.get(id)
        if (!appSettingInstance)
            render([success: false] as JSON)
        else {
            try {
                appSettingInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def appSettingInstance = AppSetting.get(params.id)
        if (!appSettingInstance) {
            render(
                message : "appSetting.not.found",
            ) as JSON

        }
        else {
            render([appSettingInstance : appSettingInstance ] as JSON)
        }
    }
}

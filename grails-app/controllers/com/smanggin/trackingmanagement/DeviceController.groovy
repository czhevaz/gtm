package com.smanggin.trackingmanagement



import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * DeviceController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class DeviceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = Device.createCriteria().list(params){}
        [deviceInstanceList: results, deviceInstanceTotal: results.totalCount]
    }

    def create() {
        [deviceInstance: new Device(params)]
    }

    def save() {
        def deviceInstance = new Device()
        

        deviceInstance.plant = Plant.findByServerId(params.plant?.serverId) 
        deviceInstance.line = Line.findByServerId(params.line?.serverId)
        deviceInstance.item = Item.findByServerId(params.item?.serverId)
        deviceInstance.ipAddress = params.ipAddress

        if (!deviceInstance.save(flush: true)) {
            render(view: "create", model: [deviceInstance: deviceInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'device.label', default: 'Device'), deviceInstance.id])
        redirect(action: "show", id: deviceInstance.id)
    }

    def show() {
        def deviceInstance = Device.get(params.id)
        if (!deviceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])
            redirect(action: "list")
            return
        }

        [deviceInstance: deviceInstance]
    }

    def edit() {
        def deviceInstance = Device.get(params.id)
        if (!deviceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])
            redirect(action: "list")
            return
        }

        [deviceInstance: deviceInstance]
    }

    def update() {
        def deviceInstance = Device.get(params.id)
        if (!deviceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (deviceInstance.version > version) {
                deviceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'device.label', default: 'Device')] as Object[],
                          "Another user has updated this Device while you were editing")
                render(view: "edit", model: [deviceInstance: deviceInstance])
                return
            }
        }

        deviceInstance.properties = params

        if (!deviceInstance.save(flush: true)) {
            render(view: "edit", model: [deviceInstance: deviceInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'device.label', default: 'Device'), deviceInstance.id])
        redirect(action: "show", id: deviceInstance.id)
    }

    def delete() {
        def deviceInstance = Device.get(params.id)
        if (!deviceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])
            redirect(action: "list")
            return
        }

        try {
            deviceInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'device.label', default: 'Device'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'device.label', default: 'Device'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def deviceInstance = (params.id) ? Device.get(params.id) : new Device()
        
        if (!deviceInstance) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (deviceInstance.version > version) {
                    deviceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'device.label', default: 'Device')] as Object[],
                              "Another user has updated this Device while you were editing")
                    render([success: false, messages: deviceInstance.errors] as JSON)
                    return
                }
            }            
        }
        
        deviceInstance.properties = params
                       
        if (!deviceInstance.save(flush: true)) {
            render([success: false, messages: deviceInstance.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = Device.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render Device.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def deviceInstance = Device.get(id)
        if (!deviceInstance)
            render([success: false] as JSON)
        else {
            try {
                deviceInstance.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def deviceInstance = Device.get(params.id)
        if (!deviceInstance) {
            render(
                message : "device.not.found",
            ) as JSON

        }
        else {
            render([deviceInstance : deviceInstance ] as JSON)
        }
    }
}

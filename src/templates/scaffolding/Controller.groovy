<%=packageName ? "package ${packageName}\n\n" : ''%>

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

/**
 * ${className}Controller
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */

class ${className}Controller {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def results = ${className}.createCriteria().list(params){}
        [${propertyName}List: results, ${propertyName}Total: results.totalCount]
    }

    def create() {
        [${propertyName}: new ${className}(params)]
    }

    def save() {
        def ${propertyName} = new ${className}(params)
        if (!${propertyName}.save(flush: true)) {
            render(view: "create", model: [${propertyName}: ${propertyName}])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        redirect(action: "show", id: ${propertyName}.id)
    }

    def show() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "list")
            return
        }

        [${propertyName}: ${propertyName}]
    }

    def edit() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "list")
            return
        }

        [${propertyName}: ${propertyName}]
    }

    def update() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (${propertyName}.version > version) {<% def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className) %>
                ${propertyName}.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: '${domainClass.propertyName}.label', default: '${className}')] as Object[],
                          "Another user has updated this ${className} while you were editing")
                render(view: "edit", model: [${propertyName}: ${propertyName}])
                return
            }
        }

        ${propertyName}.properties = params

        if (!${propertyName}.save(flush: true)) {
            render(view: "edit", model: [${propertyName}: ${propertyName}])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        redirect(action: "show", id: ${propertyName}.id)
    }

    def delete() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "list")
            return
        }

        try {
            ${propertyName}.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def jsave() {
        def ${propertyName} = (params.id) ? ${className}.get(params.id) : new ${className}()
        
        if (!${propertyName}) {                     
            def error = [message: message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])]
            render([success: false, messages: [errors:[error]] ] as JSON)       
            return
        }
        
        if (params.version)
        {
            def version = params.version.toLong()
            if (version != null) {
                if (${propertyName}.version > version) {
                    ${propertyName}.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: '${domainClass.propertyName}.label', default: '${className}')] as Object[],
                              "Another user has updated this ${className} while you were editing")
                    render([success: false, messages: ${propertyName}.errors] as JSON)
                    return
                }
            }            
        }
        
        ${propertyName}.properties = params
                       
        if (!${propertyName}.save(flush: true)) {
            render([success: false, messages: ${propertyName}.errors] as JSON)
            return
        }
                        
        render([success: true] as JSON)
    }

    def jlist() {
        if(params.masterField){
            def c = ${className}.createCriteria()
            def results = c.list {
                eq(params.masterField.name+'.id',params.masterField.id.toLong())    
            }
            render results as JSON

        }
        else
        {
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            render ${className}.list(params) as JSON           
        }
        
    }   

    def jdelete(Long id) {
        def ${propertyName} = ${className}.get(id)
        if (!${propertyName})
            render([success: false] as JSON)
        else {
            try {
                ${propertyName}.delete(flush: true)             
                render([success: true] as JSON)
            }catch (DataIntegrityViolationException e) {
                render([success: false, error: e.message] as JSON)
            }
        }
    }

    def jshow = {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            render(
                message : "${domainClass.propertyName}.not.found",
            ) as JSON

        }
        else {
            render([${propertyName} : ${propertyName} ] as JSON)
        }
    }
}

package com.smanggin.trackingmanagement

import org.springframework.dao.DataIntegrityViolationException

/**
 * UserController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
class UserController {
    def authenticationService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create() {
        [userInstance: new User(params)]
    }

    def save() {
        def userInstance = new User(params)
        userInstance.createdBy = session.user
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.serverId])
        redirect(action: "show", id: userInstance.serverId)
    }

    def show() {
        def userInstance = User.findByServerId(params.serverId)
        if (!userInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def edit() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params
        userInstance.updatedBy = session.user

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.serverId])
        redirect(action: "show", id: userInstance.serverId)
    }

    def delete() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    /**
     * Show the login page.
     */
    def auth = {

        if (authenticationService.isLoggedIn(request)) {
            redirect uri:'/home'
        }
        
        /*def config = SpringSecurityUtils.securityConfig
        println "springSecurityService.isLoggedIn(): " + springSecurityService.isLoggedIn()
        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.targetUrlParameter
            return
        }

        String view = 'auth'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl,
                                   rememberMeParameter: config.rememberMe.parameter]*/


    }

    def postLogin() {
        
            def user = User.findByLogin(authenticationService.getSessionUser().login)
            def appSetting = AppSetting.findByCode('itemDefault')
            session['user'] = user?.login 
            session['email'] = user?.email

            def userplants = UserPlants.findByUserAndIsDefault(user,true)
            session['defaultPlantId'] = userplants.plant?.serverId
            

            session['defaultItemId'] = appSetting?.val
            
            //session['domainPPP'] = Country.findByName(user?.country).domainPPP    
            
            redirect(action: "index", controller:"home",params: params)   
        
    }

    def tcp(){
        
        try
        {
            Socket socket = new Socket('192.168.52.71', 80)
            DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
            BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            outToServer.writeBytes(content + '\n');
            clientSocket.setSoTimeout(timeout);
            modifiedSentence = inFromServer.readLine();
            clientSocket.close()
            outToServer.close()
            inFromServer.close()
        }
        catch (Exception exc)
        {
            modifiedSentence = "";
        }
        return modifiedSentence;
    }
}

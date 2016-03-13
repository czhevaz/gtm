
import com.smanggin.trackingmanagement.*
import grails.converters.JSON
import org.springframework.web.context.support.WebApplicationContextUtils
import com.grailsrocks.authentication.*

class BootStrap {

    def init = { servletContext ->
    	/* set authentication user*/
        def appCtx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext)
        appCtx.authenticationService.events.onLoggedIn = { AuthenticatedUser login ->
            def user = User.findByLogin(login.login)
            return true
        }

    }
    def destroy = {
    }
}

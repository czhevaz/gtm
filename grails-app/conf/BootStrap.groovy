
import com.smanggin.trackingmanagement.*
import grails.converters.JSON
import org.springframework.web.context.support.WebApplicationContextUtils
import com.grailsrocks.authentication.*

class BootStrap {
    def socketService
    
    def init = { servletContext ->
    	socketService.run()
        
        /* Custom marshalling */
        def springContext = WebApplicationContextUtils.getWebApplicationContext( servletContext )
		
		springContext.getBean( "customObjectMarshallers" ).register()

    	JSON.registerObjectMarshaller(Date) {
            return it?.format("yyyy-MM-dd HH:mm:ss")
        }


    	/* set authentication user*/
        def appCtx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext)
        appCtx.authenticationService.events.onLoggedIn = { AuthenticatedUser login ->
            def user = User.findByLogin(login.login)
            return true
        }

        /* Set Time Zone Server */
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Jakarta")) 

        /* tcp listening*/
        
    }
    def destroy = {
    }
}

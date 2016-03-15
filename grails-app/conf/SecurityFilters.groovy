class SecurityFilters {
    static nonAuthenticatedActions = [
        [controller:'authentication', action:'*'],
        
        [controller:'user', action:'auth']
        //[controller:'purchaseORder', action:'printPdf']   
    ]

    def filters = {
        accessFilter(controller:'*', action:'*') {
            
            before = {
                boolean needsAuth = !nonAuthenticatedActions.find { 
                    (it.controller == controllerName) && ((it.action == '*') 
                    || (it.action == actionName))
                }
                //println request
                if (needsAuth) {
                    return applicationContext.authenticationService.filterRequest(
                        request, response, 
                        "${request.contextPath}/user/auth" )
                } else 
                    return true
            }
            
        }
    }
}
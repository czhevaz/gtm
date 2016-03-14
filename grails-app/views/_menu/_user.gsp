<%--<ul class="nav pull-right">--%>
	<li class="dropdown">
	
<auth:ifNotLoggedIn>

		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			<!-- TODO: integrate Springsource Security etc. and show User's name ... -->
    		<i class="icon-user"></i>
    		<g:message code="security.signin.label"/><b class="caret"></b>
		</a>

		<ul class="dropdown-menu" role="menu">
			<li class="form-container">
				<form action="/${meta(name:'app.name')}/j_spring_security_check" method="post" accept-charset="UTF-8">
<%--				<form action="login" method="post" accept-charset="UTF-8">--%>
					<input class="form-control" style="margin-bottom: 15px;" type="text"		placeholder="Username" id="username" name="username">
					<input class="form-control" style="margin-bottom: 15px;" type="password"	placeholder="Password" id="password" name="password">
					<input style="float: left; margin-right: 10px;" type="checkbox" name="remember-me" id="remember-me" value="1">
					<label class="string optional" for="user_remember_me"> Remember me</label>
					<input class="btn btn-primary btn-block" type="submit" id="sign-in" value="Sign In">
				</form>
			</li>
			<li class="divider"></li>
			<li class="button-container">
				<!-- NOTE: the renderDialog MUST be placed outside the NavBar (at least for Bootstrap 2.1.1): see bottom of main.gsp -->
				<g:render template="/_common/modals/registerTextLink"/>
			</li>
		</ul>

</auth:ifNotLoggedIn>

<auth:ifLoggedIn>
		
		<a class="dropdown-toggle" role="button" data-toggle="dropdown" data-target="#" href="#">
			<!-- TODO: Only show menu items based on permissions (e.g., Guest has no account page) -->
			<i class="icon-user icon-white"></i>
			${auth.user()}
			<!-- <g:message code="default.user.unknown.label" default="Guest"/> <b class="caret"></b> -->
		</a>
		<ul class="dropdown-menu" role="menu">
			<!-- TODO: Only show menu items based on permissions 
			<li class=""><a href="${createLink(uri: '/')}">
				<i class="icon-user"></i>
				<g:message code="user.show.label"/>
			</a></li>
			<li class=""><a href="${createLink(uri: '/')}">
				<i class="icon-cogs"></i>
				<g:message code="user.settings.change.label"/>
			</a></li>
			
			<li class="divider"></li>-->
			<li class="">

			<auth:logoutLink success="[controller:'user', action:'auth']"
    error="[controller:'home', action:'index']">
    		<i class="icon-off"></i> 
			Log out
			</auth:logoutLink>
					
			</li>
		</ul>

</auth:ifLoggedIn>

	</li>
<%--</ul>--%>

<noscript>
<ul class="nav pull-right">
	
	<li class="">
		<g:link controller="user" action="show"><g:message code="default.user.unknown.label"/></g:link>
	</li>
</ul>
</noscript>



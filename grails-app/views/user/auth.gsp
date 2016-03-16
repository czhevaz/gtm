<html>
<head>
	<meta name='layout' content='main'/>
	<title><g:message code="springSecurity.login.title"/></title>
	<style type='text/css' media='screen'>
	#login {
		margin: 15px 0px;
		padding: 0px;
		text-align: center;
	}

	#login .inner {
		width: 340px;
		padding-bottom: 6px;
		margin: 60px auto;
		text-align: left;
		border: 1px solid #aab;
		background-color: #f0f0fa;
		-moz-box-shadow: 2px 2px 2px #eee;
		-webkit-box-shadow: 2px 2px 2px #eee;
		-khtml-box-shadow: 2px 2px 2px #eee;
		box-shadow: 2px 2px 2px #eee;
	}

	#login .inner .fheader {
		padding: 18px 26px 14px 26px;
		background-color: #f7f7ff;
		margin: 0px 0 14px 0;
		color: #2e3741;
		font-size: 18px;
		font-weight: bold;
	}

	#login .inner .cssform p {
		clear: left;
		margin: 0;
		padding: 4px 0 3px 0;
		padding-left: 105px;
		margin-bottom: 20px;
		height: 1%;
	}

	#login .inner .cssform input[type='text'] {
		width: 120px;
	}

	#login .inner .cssform label {
		font-weight: bold;
		float: left;
		text-align: right;
		margin-left: -105px;
		width: 110px;
		padding-top: 3px;
		padding-right: 10px;
	}

	#login #remember_me_holder {
		padding-left: 120px;
	}

	#login #submit {
		margin-left: 15px;
	}

	#login #remember_me_holder label {
		float: none;
		margin-left: 0;
		text-align: left;
		width: 200px
	}

	#login .inner .login_message {
		padding: 6px 25px 20px 25px;
		color: #c33;
	}

	#login .inner .text_ {
		width: 120px;
	}

	#login .inner .chk {
		height: 12px;
	}
	</style>
</head>

<body>
<div id='login'>
<div style="margin:0px !important"><h3>QC Management</h3></div>
	<div class='inner'>

		<div class='fheader'><g:message code="springSecurity.login.header"/></div>

		<g:if test="${flash.authenticationFailure}">
			<div class='login_message'>
				Sorry, we were not able to find a user with that username and password.<br/>
			</div>
		</g:if>
			<div class='login_message'>
				<g:hasErrors bean="${flash.loginFormErrors}" field="login">
					<g:renderErrors bean="${flash.loginFormErrors}" as="list" field="login"/>
				</g:hasErrors>
				<g:hasErrors bean="${flash.loginFormErrors}" field="password">
					<g:renderErrors bean="${flash.loginFormErrors}" as="list" field="password"/>
				</g:hasErrors>
			</div>
		<auth:ifUnconfirmed>
			<div class='login_message'>
				You've registered but we're still waiting to confirm your account. <g:link action="reconfirm">Click here to send a new confirmation request</g:link> if you missed it the first time.
			</div>
		</auth:ifUnconfirmed>

		<auth:form authAction="login" success="[controller:'user', action:'postLogin']"
			error="[controller:'user', action:'auth']" class="form-horizontal"  target="_parent" id='loginForm' class='cssform'>

			<p>
				<label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
				<input type='text' class='text_' name='login' id='username'/>

			</p>

			<p>
				<label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='text_' name='password' id='password'/>

			</p>

			<p>
				<input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}'/>
			</p>
		</auth:form>

	</div>
</div>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['login'].focus();
	})();
	// -->
</script>
</body>
</html>

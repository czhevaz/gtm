<!DOCTYPE html>
<%-- <html lang="${org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).toString().replace('_', '-')}"> --%>
<html lang="${session.'org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'}">

<head>
	<title><g:layoutTitle default="${meta(name:'app.name')}" /></title>
	
    <meta charset="utf-8">
    <meta name="viewport"		content="width=device-width, initial-scale=1.0">
    <meta name="description"	content="">
    <meta name="author"			content="">
    
	<link rel="shortcut icon"		href="${resource(plugin: 'kickstart-with-bootstrap', dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	
	<link rel="apple-touch-icon"	href="assets/ico/apple-touch-icon.png">
    <link rel="apple-touch-icon"	href="assets/ico/apple-touch-icon-72x72.png"	sizes="72x72">
    <link rel="apple-touch-icon"	href="assets/ico/apple-touch-icon-114x114.png"	sizes="114x114">
	
	<%-- Manual switch for the skin can be found in /view/_menu/_config.gsp --%>
	<r:require modules="bootstrap"/>
	<r:require modules="bootstrap_utils"/>
	<r:require modules="font-awesome-css"/>

	<r:require modules="jquery"/>
	<r:require modules="jquery-ui"/>
	<r:require modules="application"/>	
	<r:require modules="fileUpload"/>	
	<r:require modules="datatables"/>
	<r:require modules="easyui_core"/>	
	
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'my.css')}" type="text/css">

	
  	<link rel="stylesheet" href="${resource(dir: 'js/chosen/docsupport', file: 'prism.css')} ">
  	<link rel="stylesheet" href="${resource(dir: 'js/chosen', file: 'chosen.css')} ">

	

	<r:layoutResources />
	<g:layoutHead />

	<!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
	<!--[if lt IE 9]>
		<script src="https://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<%-- For Javascript see end of body --%>
</head>

<body style="background-color:#ECEFF1">
	<auth:ifLoggedIn>
	<g:render template="/_menu/navbar"/>														
	</auth:ifLoggedIn>
	<!-- Enable to overwrite Header by individual page -->
	<div id="wrapper">
		
		
			<g:if test="${ pageProperty(name:'page.header') }">
		   		<g:pageProperty name="page.header" />
			</g:if>
			<g:else>
				<g:render template="/layouts/header"/>														
			</g:else>
		

		<g:render template="/layouts/content"/>														

		<g:if test="${ pageProperty(name:'page.footer') }">
		    <g:pageProperty name="page.footer" />
		</g:if>
		<g:else>
			<g:render template="/layouts/footer"/>														
		</g:else>

		<%-- <!-- Enable to overwrite Footer by individual page -->
		
		<!-- Enable to insert additional components (e.g., modals, javascript, etc.) by any individual page -->
		<g:if test="${ pageProperty(name:'page.include.bottom') }">
	   		<g:pageProperty name="page.include.bottom" />
		</g:if>
		<g:else>
			<!-- Insert a modal dialog for registering (for an open site registering is possible on any page) -->
			<g:render template="/_common/modals/registerDialog" model="[item: item]"/>
		</g:else> --%>

		
	</div>
	<!-- Included Javascript files and other resources -->
	
	<r:layoutResources />
	
</body>

</html>
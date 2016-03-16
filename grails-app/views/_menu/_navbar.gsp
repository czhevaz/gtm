<nav id="Navbar" class="navbar navbar-fixed-top navbar-default" role="navigation">
	<div class="container-fluid">
	    <div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
        		<span class="sr-only">Toggle navigation</span>
        		<span class="icon-bar"></span>
	           	<span class="icon-bar"></span>
	           	<span class="icon-bar"></span>
			</button>
	
			<a class="navbar-brand" href="${createLink(uri: '/')}">
				<i class="icon-dashboard"></i>
				
				<!--<img class="logo" src="${resource(plugin: 'kickstart-with-bootstrap', dir:'kickstart/img', file:'grails.png')}" alt="${meta(name:'app.name')}" width="16px" height="16px"/> -->
				Amatra QC Management
				<small> v ${meta(name:'app.version')}</small>
			</a>
		</div>

		<div class="collapse navbar-collapse navbar-ex1-collapse" role="navigation">
		
		<ul class='nav navbar-nav' style='margin-left:100px'>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Transaction<b class="caret"></b></a>
				<ul class="dropdown-menu">
					
					<li class="controller">
						<g:link controller="ProductionInHeader">
							Production In
						</g:link>
					</li>
					<li class="controller">
						<g:link controller="QCHeader" params="[trType: 'qc']">
							QC
						</g:link>
					</li>
					
              
				</ul>	
			</li>
			
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Master Data<b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li class="controller">
						<g:link controller="User">
							User
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="Plant">
							Plant
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="Line">
							Line
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="Process">
							Process
						</g:link>
					</li>
					
					<li class="controller">
						<g:link controller="ProcessQC">
							Process Qc
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="WorkCenter">
							WorkCenter
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="Gallon">
							Gallon
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="QCMaster">
							QC Master
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="QCQuestions">
							Qc Questions
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="QCOptions">
							QC Options
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="QCActions">
							Qc Actions
						</g:link>
					</li>

					<li class="controller">
						<g:link controller="TransactionGroup">
							Transaction Group
						</g:link>
					</li>
				
					
					
				</ul>
			</li>

			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Report<b class="caret"></b></a>
				<ul class="dropdown-menu">
					
					<li class="dropdown-submenu">
						<a tabindex="-1" href="#">General</a>
						<ul class="dropdown-menu">
	                  		
			                  	<li>
			                  		<g:link controller="${country?.domainPPP}">
										New Gallon
									</g:link>
								</li>
								<li>
			                  		<g:link controller="${country?.domainPPP}">
										Line Balance
									</g:link>
								</li>
								<li>
			                  		<g:link controller="${country?.domainPPP}">
										Gallon History
									</g:link>
								</li>
			                 
		                </ul>
					
					</li>
					<li class="dropdown-submenu">
						<a tabindex="-1" href="#">Production In</a>
						<ul class="dropdown-menu">
	                  		
			                  	<li>
			                  		<g:link controller="${country?.domainPPP}">
										Production Report
									</g:link>
								</li>
			                 
		                </ul>
					
					</li>
					<li class="dropdown-submenu">
						<a tabindex="-1" href="#">QC</a>
						<ul class="dropdown-menu">
	                  		
			                  	<li>
			                  		<g:link controller="QCHeader" action="report" params="[report:'qcSummary']">
										QC Summary
									</g:link>
								</li>
								<li>
			                  		<g:link controller="${country?.domainPPP}">
										QC Analysis
									</g:link>
								</li>   
		                </ul>
					
					</li>
              
				</ul>	
			</li>
			

		</ul>
		<!-- <ul class="nav navbar-nav">
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Browse <b class="caret"></b></a>
				<ul class="dropdown-menu">
                    <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                    <li class="controller">
                    	<g:link controller="${c.logicalPropertyName}">
							<g:if test="${c.fullName.contains('HomeController')}">
					    		<i class="icon-home"></i>
							</g:if>
							<g:elseif test="${c.fullName.contains('DemoPageController')}">
					    		<i class="icon-beaker"></i>
							</g:elseif>
							<g:elseif test="${c.fullName.contains('DbdocController')}">
					    		<i class="icon-sitemap"></i>
							</g:elseif>
                    		${c.fullName.substring(c.fullName.lastIndexOf('.')+1)}
                    	</g:link>
                    </li>
                    </g:each>
				</ul>
			</li>
		</ul>
		-->

	    	<ul class="nav navbar-nav navbar-right">
    		
	 			<!-- <g:render template="/_menu/search"/> -->
				<!-- <g:render template="/_menu/admin"/>														
				<g:render template="/_menu/info"/> -->														
				<g:render template="/_menu/user"/><!-- NOTE: the renderDialog for the "Register" modal dialog MUST be placed outside the NavBar (at least for Bootstrap 2.1.1): see bottom of main.gsp -->
																		
		    </ul>			

		</div>
	</div>
</nav>


<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
	<title>EdExchange Document Transfer</title>
	<meta http-equiv="Content-Type" charset="utf-8" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/png" href="resources/images/edex-favicon-16.png" sizes="16x16" />
    <link rel="shortcut icon" type="image/png" href="resources/images/edex-favicon-24.png" sizes="24x24" />
    <link rel="shortcut icon" type="image/png" href="resources/images/edex-favicon-32.png" sizes="32x32" />
    <link rel="shortcut icon" type="image/png" href="resources/images/edex-favicon-48.png" sizes="48x48" />
    <link rel="shortcut icon" type="image/png" href="resources/images/edex-favicon-64.png" sizes="64x64" />
    <link rel="stylesheet" href="resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="resources/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="resources/css/dataTables.bootstrap.css" />
    <link rel="stylesheet" href="resources/css/datepicker.css" />
    <link rel="stylesheet" href="resources/css/datepicker3.css" />
    <link rel="stylesheet" href="resources/css/fuelux.min.css" />
    <link rel="stylesheet" href="resources/css/typeahead-ext.css" />
    <style>
	body { padding-top: 50px; }
	</style>
</head>
<body>
	<div class="container-fluid">
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	        <div class="container-fluid">
	            <div class="collapse navbar-collapse" id="bs-navbar-collapse">
	                <ul class="nav navbar-nav">
	                    <li><a href="home">Home</a></li>
	                </ul>
	                <ul class="nav navbar-nav navbar-right">
	                    <li><a href="documentation">Documentation</a></li>
	                </ul>
	            </div>
	        </div>
	    </nav>
		
		<h2>Transfer</h2>
		<div id="transferForm">
			<form action="sendFile" method="post" enctype="multipart/form-data" accept-charset="utf-8">
	            <div class="form-horizontal row">
	            	<div class="form-group">
	                	<label class="control-label col-lg-2 col-md-2 col-sm-4 col-xs-4">Recipient</label>
	                    <div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
	                        <input type="text" name="recipientId" class="form-control" placeholder="Where is this file going?" />
	                    </div>
	                    
	                    <label class="control-label col-lg-2 col-md-2 col-sm-4 col-xs-4">Network Server</label>
	                    <div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
	                        <input type="text" name="networkServerId" class="form-control" placeholder="This should be assigned by the web application" />
	                    </div>
	                </div>
	            </div>
	            <div class="form-horizontal row">
	            	<div class="form-group">
	                	<label class="control-label col-lg-2 col-md-2 col-sm-4 col-xs-4">Sender</label>
	                    <div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
	                    	<input type="text" name="senderId" class="form-control" placeholder="This might be different than this network server" />
	                    </div>
	                    
	                    <label class="control-label col-lg-2 col-md-2 col-sm-4 col-xs-4">Transcript File</label>
	                    <div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
	                    	<input type="file" name="file" />
	                    </div>
	                </div>
	            </div>
	            <div class="form-horizontal row">
	            	<div class="form-group">
	                	<label class="control-label col-lg-2 col-lg-offset-6 col-md-4 col-md-offset-4 col-sm-4 col-xs-4">File Format</label>
	                    <div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
	                    	<input type="text" name="fileFormat" class="form-control" placeholder="What type of file to transfer" />
	                    </div>
	                </div>
	            </div>
	            <div class="form-horizontal row">
	            	<div class="form-group text-center">
	            		<input type="hidden" name="webServiceUrl" value="" />
	                	<button type="submit" class="btn btn-default">SEND</button>
	                </div>
	            </div>
	        </form>
        </div>
	</div>
	
	<script src="resources/js/jquery-2.1.1.min.js"></script>
	<script src="resources/js/underscore-min.js"></script>
    <script src="resources/js/backbone-min.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
    <script src="resources/js/moment.min.js"></script>
    <script src="resources/js/typeahead.bundle.js"></script>
    <script src="resources/js/jquery.dataTables.min.js"></script>
    <script src="resources/js/dataTables.bootstrap.js"></script>
    <script src="resources/js/bootstrap-datepicker.js"></script>
    <script src="resources/js/spinbox.js"></script>
    <script src="resources/js/transferPageAssets.js"></script>
    <script>
	//  dev: http://localhost:8080
	//   ci: http://local.pesc.dev
	// prod: http://pesc.cccnext.net
	var directoryServer = "<fmt:message key="directoryserver.host"/>";
    </script>
    
</body>
</html>
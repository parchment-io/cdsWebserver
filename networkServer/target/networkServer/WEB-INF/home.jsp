<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
	<title>EdExchange Network Server Home</title>
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
	                    <li><a href="transfer">Transfer</a></li>
	                </ul>
	                <ul class="nav navbar-nav navbar-right">
	                    <li><a href="documentation">Documentation</a></li>
	                </ul>
	            </div>
	        </div>
	    </nav>
		
        <h2>Transaction History</h2>
        <div class="form-horizontal">
        	<div class="form-group">
        		<label class="control-label col-sm-2">Status</label>
        		<div class="btn-group col-sm-10" data-toggle="buttons">
        			<label class="btn btn-primary active">
        				<input type="radio" name="tx-history-status" autocomplete="off" value="0" checked /> incomplete
        			</label>
        			<label class="btn btn-primary">
        				<input type="radio" name="tx-history-status" autocomplete="off" value="1" /> complete
        			</label>
        		</div>
        	</div>
        	<div class="form-group">
        		<label class="control-label col-sm-2">From / To</label>
        		<div class="input-daterange input-group date">
        			<input type="text" class="form-control" name="tx-history-from" />
        			<span class="input-group-addon">to</span>
        			<input type="text" class="form-control" name="tx-history-to" />
        		</div>
        	</div>
        	<div class="form-group">
        		<label class="control-label col-sm-2">Fetch Size</label>
        		<div class="col-sm-3">
        			<input type="number" class="form-control tx-history-fetchSize" min="1" max="1000" size="4" />
        		</div>
        	</div>
        </div>
        <div class="row">
        	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
        		<button type="button" class="btn btn-default getHistoryButton">Get Transactions</button>
        	</div>
        </div>
        <table class="table table-striped table-bordered table-condensed table-hover xaction-history-table" width="99%"></table>
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
    <script src="resources/js/homePageAssets.js"></script>
	<script>
	//  dev: http://localhost:8080
	//   ci: http://local.pesc.dev
	// prod: http://pesc.cccnext.net
	var directoryServer = "<fmt:message key="directoryserver.host"/>";
	</script>
</body>
</html>
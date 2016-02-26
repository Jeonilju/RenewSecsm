<%   
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=utf-8"); 
	response.setHeader("Cache-Control","no-store");   
	response.setHeader("Pragma","no-cache");   
	response.setDateHeader("Expires",0);   
	if (request.getProtocol().equals("HTTP/1.1")) 
        response.setHeader("Cache-Control", "no-cache"); 
%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="">

<!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
<link href="/Secsm/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/Secsm/resources/css/bootstrap.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/Secsm/resources/css/freelancer.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/Secsm/resources/css/simple-sidebar.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/Secsm/resources/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

<!-- Custrom CSS -->
<link rel="stylesheet" href="/Secsm/resources/css/bootstrap-select.css">
  
<!-- jQuery -->
<script src="/Secsm/resources/js/jquery.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<!-- Select js -->
<script src="/Secsm/resources/js/bootstrap-select.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/metisMenu/1.1.0/metisMenu.js"></script>

<!-- Plugin JavaScript -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>


<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>eBay Search</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/starter-template.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/autosuggest.css">
      <link rel="stylesheet" type="text/css" href="css/searchresults.css">



    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="bootstrap/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">eBay Search</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="index.html">Home</a></li>
            <li class="active"><a href="keywordSearch.html">Search</a></li>
            <li><a href="getItem.html">Lookup</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container">
      <div class="starter-template">

            <form class="form-horizontal" action="search" accept-charset="utf-8">
              <div class="form-group">
                <div class="col-sm-11">
                    <div class="search-bar">
                        <input type="text" id="searchInput" class="form-control" name="q"  autocomplete="off">
                        <input type="text" id="ghostAhead" class="form-control" autocomplete="off" tabIndex="-1">
                    </div>
                </div>
                    <div class="col-sm-11">
                        <div class="drop-down-container">
                            <div class="list-group text-left" id="dropDown">
                            </div>
                        </div>
                  </div>

                <div class="col-sm-offset-11">
                  <button type="submit" class="btn btn-default">Search</button>
                </div>
            </div>
                <input type="hidden" name="numResultsToSkip" value="0" />
                <input type="hidden" name="numResultsToReturn" value="20" />
            </form>          
          
          <c:if test="${fn:length(results) eq '0'}">
                <div class="alert alert-info" role="alert">Your search - <strong><c:out value="${param.q}"></c:out></strong> - did not match any auctions.</div>              
          </c:if>
          
            <table class="table table-hover">
                <c:forEach items="${results}" var="result">
                    <tr>
                        <td><a href="item?id=${result.itemId}">${result.name} (${result.itemId})</a></td>
                    </tr>
                </c:forEach>
            </table>

          <nav>
              <ul class="pager">
                <c:choose>
                    <c:when test="${param.numResultsToSkip eq '0'}">
                        <li class="previous disabled"><a>Previous</a></li>                        
                    </c:when>
                    <c:when test="${param.numResultsToSkip - param.numResultsToReturn <'0'}">
                        <li class="previous"><a href="search?q=${queryURL}&numResultsToSkip=0&numResultsToReturn=${param.numResultsToReturn}">Previous</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="previous"><a href="search?q=${queryURL}&numResultsToSkip=${param.numResultsToSkip-param.numResultsToReturn}&numResultsToReturn=${param.numResultsToReturn}">Previous</a></li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${fn:length(results) eq param.numResultsToReturn}">
                        <li class="next"><a href="search?q=${queryURL}&numResultsToSkip=${param.numResultsToSkip+param.numResultsToReturn}&numResultsToReturn=${param.numResultsToReturn}">Next</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="next disabled"><a>Next</a></li>
                    </c:otherwise>
                </c:choose>

              </ul>
            </nav>

          
        </div>
    </div><!-- /.container -->

      
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="bootstrap/assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="bootstrap/assets/js/ie10-viewport-bug-workaround.js"></script>
  
    <script type="text/javascript" src="js/suggestionRetriever.js"></script>
	<script type="text/javascript" src="js/autoSuggestControl.js"></script>
	<script type="text/javascript">
    function getSuggestions(){
		oAutoSuggestControl = new AutoSuggestControl(document.getElementById("searchInput"), document.getElementById("ghostAhead"), document.getElementById("dropDown"),new SuggestionRetriever());
	}
	window.addEventListener('DOMContentLoaded', getSuggestions, false);
	</script>

  </body>
</html>

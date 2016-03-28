<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
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
    <link href="css/jumbotron.css" rel="stylesheet">
    <link href="css/starter-template.css" rel="stylesheet">
      <link rel="stylesheet" type="text/css" href="css/itemdetail.css">


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
            <li><a href="keywordSearch.html">Search</a></li>
            <li class="active"><a href="getItem.html">Lookup</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

      <div class="container">
          <div class="starter-template">
            <form class="form-horizontal" action="item" accept-charset="utf-8">
            <div class="form-group">
            <div class="col-sm-11">
                <div class="search-bar">
                    <input type="text" class="form-control" name="id" placeholder="Item Id">
                </div>
            </div>
            <div class="col-sm-offset-11">
              <button type="submit" class="btn btn-default">Lookup</button>
            </div>
            </div>
            </form>          
          </div>
      </div>
            
  <!-- Main jumbotron for a primary marketing message or call to action -->
    <c:choose>
     <c:when test="${not empty item}"> 
         <script src="js/map.js" type="text/javascript"></script>

    <div class="jumbotron">
      <div class="container">
          <div class="col-md-7">
              <h1>${item.name}</h1>
          </div>
          <div class="col-md-5">
              <div class="panel panel-default">
                  <div class="panel-heading">
                    <h3 class="panel-title">Seller</h3>
                  </div>
                  <div class="panel-body">
                    ${item.seller} (${item.sellerRating})
                  </div>
                </div>
              <div class="panel panel-default">
              <div class="panel-body">     
                  
                <c:if test="${not empty item.buyPrice}">
                    <p><small>Buy price: </small>${item.buyPrice}</p>
                    <a class="btn btn-primary" href="payment">Pay now</a>
                    <hr>
                </c:if>
                <c:choose>
                    <c:when test="${item.numberOfBids eq '0'}">
                        <p><small>Starting bid: </small><mark>${item.currently}</mark></p>
                    </c:when>
                    <c:otherwise>
                        <p><small>Current bid: </small><mark>${item.currently}</mark></p>
                    </c:otherwise>
                </c:choose>                  
              <!-- Single button -->
              <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                ${item.numberOfBids} bids <span class="caret"></span>
                </button>
                <table class="table table-hover table-condensed dropdown-menu bid-table">
                    <thead>
                        <tr>
                            <th>Time</th>
                            <th>Amount</th>
                            <th>Bidder</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${item.bids}" var="bid">
                      <tr>
                          <td>${bid.time}</td>
                          <td class="text-right">${bid.amount}</td>
                          <td>${bid.bidderUID} (${bid.rating})</td>
                      </tr>
                        </c:forEach>
                    </tbody>
                </table>
              </div>

              </div>
            </div>
          </div>
      </div>
    </div>

      
    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-2">
            <dl>
                <dt>Item Id</dt>
                <dd>${item.itemID}</dd>
                <dt>Started</dt>
                <dd>${item.started}</dd>
                <dt>Ends</dt>
                <dd>${item.ends}</dd>
                <dt>Location</dt>
                <dd>${item.location}</dd>
                <dt>Country</dt>
                <dd>${item.country}</dd>
                <dt>Categories</dt>
                    <c:forEach items="${item.categories}" var="category">
                        <dd>${category}</dd>
                    </c:forEach>            
            </dl>
        </div>
        <div class="col-md-5">
          <dl>
              <dt>Description</dt>
              <dd>${item.description}</dd>
          </dl>
        </div>
        <div class="col-md-5 map-container">
            <div id="map_canvas"></div>
            <c:choose>
            <c:when test="${not empty item.latitude}">
            <script type="text/javascript">
            function initMap() {
              var latlng = new google.maps.LatLng(${item.latitude}, ${item.longitude});        
              coordinatesMap(latlng);
            }
            </script>
            </c:when>
            <c:when test="${not empty item.location}">
            <script type="text/javascript">
            function initMap() {
              geocodeMap('${item.location}');
            }
            </script>          
            </c:when>
            <c:otherwise>
            <script type="text/javascript">
            function initMap() {
              globalMap();
            }
            </script>
            </c:otherwise>
            </c:choose>

        </div>
      </div>

    </div> <!-- /container -->
    <!-- Google Maps Geocoding -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyArvuHqnPMDjkudXglPHe0w3Ff1oA1Af7M&callback=initMap"
  type="text/javascript"></script>

        </c:when>
        <c:otherwise>
            <div class="container">
                <div class="starter-template">
                    <div class="alert alert-info" role="alert">Your id - <strong><c:out value="${param.id}"></c:out></strong> - did not match any items.</div>
                </div>
            </div>
        </c:otherwise>
      </c:choose>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="bootstrap/assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="bootstrap/assets/js/ie10-viewport-bug-workaround.js"></script>
 
  </body>
</html>

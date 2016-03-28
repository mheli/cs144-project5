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
    <link href="css/starter-template.css" rel="stylesheet">
      <link rel="stylesheet" type="text/css" href="css/payment.css">


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
          <a class="navbar-brand" href="#">Payment</a>
        </div>
      </div>
    </nav>

    <c:choose>
      <c:when test="${not empty item}">
        <div class="container">
          <div class="starter-template">
            <form action="https://${server}:${upshift}${path}/confirm" accept-charset="utf-8" method="post">
              <div class="form-group">
                <input type="text" class="form-control" name="creditcard" placeholder="Credit card number"
                pattern="[0-9 -]*" title="Numbers (0-9), spaces, and dashes only" autocomplete="off" required>
              </div>
              <button type="submit" class="btn btn-default float-left">Purchase</button>
            </form>
          </div>
        </div> <!-- /container -->
        <div class="container">
          <div class="starter-template">
            <table class="table">
              <thead>
                  <tr>
                      <th>Item Id</th>
                      <th>Item</th>
                      <th class="text-right">Price</th>
                  </tr>
              </thead>
              <tbody>
                <tr>
                    <td class="text-left">${item.itemID}</td>
                    <td class="text-left"><strong>${item.name}</strong></td>
                    <td class="text-right">${item.buyPrice}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div> <!-- /container -->
      </c:when>
      <c:otherwise>
          <div class="container">
              <div class="starter-template">
                  <div class="alert alert-danger" role="alert">Your request could not be processed at this time.</div>
              </div>
              <div class="starter-template">
                  <div class="text-left">
                    <strong>What would you like to do now?</strong>
                    <ul>
                      <li><a href="redirect?target=keywordSearch.html">Keyword search</a></li>
                      <li><a href="redirect?target=getItem.html">Item id lookup</a></li>
                    </ul>
                  </div>
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

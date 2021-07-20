<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
<title>Bootstrap Simple Registration Form</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<link rel="stylesheet" href="css/signup.css">
</head>
<body>
<div class="signup-form">
    <form action="./UserServlet?action=register" method="post" id="register-form">
		<h2>Register</h2>
		<p class="hint-text">Create your account. It's free and only takes a minute.</p>
     
        <div class="form-group">
        	<input type="text" class="form-control" name="userName" id="user-name" placeholder="User Name" required="required">
        </div>
		<div class="form-group">
            <input type="password" class="form-control" name="password" id="password" placeholder="Password" required="required">
        </div>      
        <div class="form-group">
			<label class="checkbox-inline"><input type="checkbox" required="required"> I accept the <a href="#">Terms of Use</a> &amp; <a href="#">Privacy Policy</a></label>
		</div>
		<div class="form-group">
            <button type="submit" class="btn btn-success btn-lg btn-block">Register Now</button>
        </div>
    </form>
	<div class="text-center">Already have an account? <a href="login.jsp">Sign in</a></div>
</div>


<script type="text/javascript">

$(document).ready(function(){

	$("#register-form").on("submit", function(event){
		event.preventDefault();
		 
        var formValues= $(this).serialize();
        console.log(formValues);

        var user = {
                "userName":$("#user-name").val(),
                "password":$("#password").val()
                }

        console.log(user);

        $.ajax({
            url: 'http://localhost:8080/bookStore/mytestapi/user/register',
            type: "POST",
            data:JSON.stringify(user),
            headers: {
		      	"content-type": "application/json;charset=UTF-8" // Or add this line
		    },
		    success:function(data){
			    window.location = "home.jsp";
			    },
			error:function(data){
				alert("Something went wrong...");
				}
        });
        
		});
});

</script>
</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bootstrap Table with Add and Delete Row Feature</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round|Open+Sans">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<style>
body {
	color: #404E67;
	background: #F5F7FA;
	font-family: 'Open Sans', sans-serif;
}

.table-wrapper {
	width: 700px;
	margin: 30px auto;
	background: #fff;
	padding: 20px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}

.table-title {
	padding-bottom: 10px;
	margin: 0 0 10px;
}

.table-title h2 {
	margin: 6px 0 0;
	font-size: 22px;
}

.table-title .add-new {
	float: right;
	height: 30px;
	font-weight: bold;
	font-size: 12px;
	text-shadow: none;
	min-width: 100px;
	border-radius: 50px;
	line-height: 13px;
}

.table-title .add-new i {
	margin-right: 4px;
}

table.table {
	table-layout: fixed;
}

table.table tr th, table.table tr td {
	border-color: #e9e9e9;
}

table.table th i {
	font-size: 13px;
	margin: 0 5px;
	cursor: pointer;
}

table.table th:last-child {
	width: 100px;
}

table.table td a {
	cursor: pointer;
	display: inline-block;
	margin: 0 5px;
	min-width: 24px;
}

table.table td a.add {
	color: #27C46B;
}

table.table td a.edit {
	color: #FFC107;
}

table.table td a.delete {
	color: #E34724;
}

table.table td i {
	font-size: 19px;
}

table.table td a.add i {
	font-size: 24px;
	margin-right: -1px;
	position: relative;
	top: 3px;
}

table.table .form-control {
	height: 32px;
	line-height: 32px;
	box-shadow: none;
	border-radius: 2px;
}

table.table .form-control.error {
	border-color: #f50000;
}

table.table td .add {
	display: none;
}
</style>
<script>
	$(document)
			.ready(
					function() {

						$('#updateBtn').hide();

						$.ajax({

									url : 'http://localhost:8080/bookStore/mytestapi/author/getAll',
									type : 'GET',
									success : function(data) {
										for (var i = 0; i < data.length; i++) {
											$('#authorTable').append('<tr id='+data[i].id+'><td data-target=name>'+ data[i].name+'</td><td data-target=publications>'+data[i].noOfPublications+ '</td><td> <a class="edit" data-id='+data[i].id+' title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a><a class="delete" data-id='+data[i].id+' title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>');
										}

									}

								});

						

						$('#closeBtn').on('click', function(){
							$('#author_form')[0].reset();
							
						});

					$('#addBtn').on('click', function(){
						var name = $('#author_name').val();
						var publications = $('#publications').val();

						var author = {
								"name":name,
								"noOfPublications":publications
								}
						$.ajax({
							url:'http://localhost:8080/bookStore/mytestapi/author/create',
							type: "POST",
							data: JSON.stringify(author),
							headers: {
						      	"content-type": "application/json;charset=UTF-8" // Or add this line
						    },
							success:function(data){

								$('#exampleModal').modal('hide');
								
								$('#authorTable').append('<tr id='+data.id+'><td data-target=name>'+ data.name+'</td><td data-target=publications>'+data.noOfPublications+ '</td><td> <a class="edit" data-id='+data.id+' title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a><a class="delete" data-id='+data.id+' title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a></td>');

										
										
										
										
								},

							});
					});

						
						$(document).on("click",".edit",function() {

							$('#addBtn').hide();
							$('#updateBtn').show();
							
									var currentRow = $(this).closest("tr");
									

									var id = $(this).data('id'); // get current row 1st TD value
									var name = currentRow.find("td:eq(0)")
											.text(); // get current row 2nd TD
									var publications = currentRow.find(
											"td:eq(1)").text(); // get current row 3rd TD
									console.log(id);
									console.log(name);
									console.log(publications);

									$('#author_name').val(name);
									$('#publications').val(publications);
									
									
									$('#exampleModal').modal('show');

									$('#updateBtn').on('click', function(){
										name = $('#author_name').val();
										publications = $('#publications').val();

										var author = {
												"id":id,
												"name":name,
												"noOfPublications":publications
												}
										
										$.ajax({
											url:'http://localhost:8080/bookStore/mytestapi/author/update',
											type: "POST",
											data: JSON.stringify(author),
											headers: {
										      	"content-type": "application/json;charset=UTF-8" // Or add this line
										    },
											success:function(data){

												$('#exampleModal').modal('hide');
												$('#author_form')[0].reset();
												
														$('#'+id).children('td[data-target=name]').text(data.name);
														$('#'+id).children('td[data-target=publications]').text(data.noOfPublications);


														
														
														
														
												},

											});
									});

									
								});
					



			

						
						// Delete row on delete button click
						$(document).on("click", ".delete", function() {

							var id = $(this).data('id');
							
							if (confirm('Are you sure you want to delete this record?')) {
								$.ajax({

									url: 'http://localhost:8080/bookStore/mytestapi/author/delete/'+id,
									type: 'GET',
									headers: {
								      	"content-type": "application/json;charset=UTF-8" // Or add this line
								    },
								    success: function (data){
								    	$("#"+id).remove();
								    },
								   

									});
								
							}
							
							
						});
					});
</script>
</head>
<body>
	<div class="container-lg">
		<div class="table-responsive">
			<div class="table-wrapper">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-8">
							<h2>
								Author <b>Details</b>
							</h2>
						</div>
						<div class="col-sm-4">

							<button style="width: 100px" type="button"
								class="btn btn-info add-new" data-toggle="modal"
								data-target="#exampleModal">
								<i class="fa fa-plus"></i>Add
							</button>
						</div>
					</div>
				</div>
				<table id="authorTable" class="table table-bordered">
					<thead>
						<tr>
							<th>Name</th>
							<th>Department</th>

							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						


					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>

<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Add New Author</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form method="post" id="author_form">
				<div class="modal-body">


					<div class="form-group">
						<label for="recipient-name" class="col-form-label">Author
							Name</label> <input type="text" class="form-control" id="author_name">
					</div>
					<div class="form-group">
						<label for="recipient-name" class="col-form-label"
							data-toggle="tooltip" data-placement="top"
							title="No of publications">Publications</label> <input
							type="number" class="form-control" id="publications">
					</div>



				</div>
			</form>
			<div class="modal-footer">
				<button type="button" id="closeBtn" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" id="addBtn" class="btn btn-primary">Save</button>
				<button type="button" id="updateBtn" class="btn btn-primary">Update</button>
			</div>

		</div>
	</div>
</div>
<!DOCTYPE html>
<html>
<head>
    <title>Create Trip</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">Create Trip</div>
                <div class="card-body">
                    <form action="/trips" method="post">
                        <div class="form-group">
                            <label for="text">Text</label>
                            <input type="text" id="text" name="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="routeNumber">Route Number</label>
                            <input type="text" id="routeNumber" name="routeNumber" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="trainId">Train</label>
                            <select id="trainId" name="trainId" class="form-control" required>
                                <#list trains as train>
                                    <option value="${train.id}">${train.name}</option>
                                </#list>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="author">Author</label>
                            <select id="author" name="author.id" class="form-control" required>
                                <#list authors as author>
                                    <option value="${author.id}">${author.name}</option>
                                </#list>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Create</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

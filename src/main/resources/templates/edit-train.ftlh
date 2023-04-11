<#import "parts/common.ftlh" as c>

<@c.page>
    <body>
<div class="container">
    <h1>Edit Train</h1>

    <form method="post" action="/trains/${train.id}/update">
        <div class="form-group">
            <label for="trainNumber">Train Number</label>
            <input type="text" class="form-control" id="trainNumber" name="trainNumber" value="${train.trainNumber}">
        </div>

        <div class="form-group">
            <label for="trainName">Train Name</label>
            <input type="text" class="form-control" id="trainName" name="trainName" value="${train.trainName}">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary">Save</button>
        <a href="/trains" class="btn btn-secondary">Cancel</a>
    </form>
</div>

</@c.page>
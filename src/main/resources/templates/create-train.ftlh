<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <h1>Create Train</h1>

        <form action="/trains/create" method="POST">
            <div class="form-group">
                <label for="trainNumber">Train Number</label>
                <input type="number" class="form-control" id="trainNumber" name="trainNumber" required>
            </div>

            <div class="form-group">
                <label for="trainName">Train Name</label>
                <input type="text" class="form-control" id="trainName" name="trainName" required>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type="submit" class="btn btn-primary">Create</button>
        </form>
    </div>
</@c.page>
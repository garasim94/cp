<#import "parts/common.ftlh" as c>

<@c.page>
<div class="container">
    <h1>Trains</h1>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Train Number</th>
            <th>Train Name</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <#if trains?size == 0>
            <tr>
                <td colspan="5">There are no trains.</td>
            </tr>
        <#else>
            <#list trains as train>
                <tr>
                    <td>${train.id}</td>
                    <td>${train.trainNumber}</td>
                    <td>${train.trainName}</td>
                    <td>
                        <a href="/trains/${train.id}/edit" class="btn btn-primary btn-sm">Edit</a>
                        <form action="/trains/${train.id}/delete" method="post" style="display: inline-block">
                            <button class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
            </#list>
        </#if>
        </tbody>
    </table>
    <a href="/trains/create" class="btn btn-success">Create Train</a>
</div>
</@c.page>
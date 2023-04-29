<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <div class="d-flex justify-content-start align-items-center">
            <h1 class="mr-2">Trains</h1>
            <a title="Add train" data-toggle="collapse" href="#collapseForm" role="button" aria-expanded="false" aria-controls="collapseExample">
                <i class="mr-2 fa-solid fa-plus fa-2x"></i>
            </a>
            <style>
                .rotate-45 {
                    transform: rotate(45deg);
                    color: red;
                    display: inline-block;
                    position: relative;
                }
            </style>
            <script>
                $(document).ready(function() {
                    $('a[data-toggle="collapse"]').click(function() {
                        $(this).find('i').toggleClass('rotate-45');
                    });
                });
            </script>
            <a href="/trains/export" title="Export to excel file"><i class="mr-2 fa-solid fa-file-excel fa-2x" style="color: rgb(30, 168, 125);"></i></a>
        </div>
        <div class="mr-2">
            <div class="collapse" id="collapseForm">
                <h3 class="mr-2">Create new train:</h3>
                <div class="form-group mt-3">
                    <form method="post" action="/trains/create">
                        <div class="form-group">
                            <label for="trainNumber">Train Number</label>
                            <input type="number" class="form-control" id="trainNumber" name="trainNumber" required>
                        </div>
                        <div class="form-group">
                            <label for="trainName">Train Name</label>
                            <input type="text" class="form-control" id="trainName" name="trainName" required>
                        </div>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Add</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <@c.search moduleUrl="/trains"></@c.search>
        <div class="container mt-4">
            <div id="trains-table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <@c.sortColumn columnId="id" columnName="ID" moduleUrl="/trains"></@c.sortColumn>
                        <@c.sortColumn columnId="trainNumber" columnName="Train Number" moduleUrl="/trains"></@c.sortColumn>
                        <@c.sortColumn columnId="trainName" columnName="Train Name" moduleUrl="/trains"></@c.sortColumn>
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
                            <#if !train.isIssuesEmpty()>
                                <tr class="table-danger">
                                    <td>${train.id}</td>
                                    <td>${train.trainNumber}</td>
                                    <td>${train.trainName}</td>
                                    <td>
                                        <a href="/trains/${train.id}/edit" class="btn btn-primary btn-sm">Edit</a>
                                        <#if train.hasTrip()>
                                            <form action="/trains/${train.id}/delete" method="post" style="display: inline-block">
                                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                                <button class="btn btn-danger btn-sm">Delete</button>
                                            </form>
                                        </#if>
                                        <a href="/trains/issue/${train.id}" ><i class="fa-solid fa-triangle-exclamation fa-xl" style="color: #ffff00;"></i></a>
                                    </td>
                                </tr>
                            </#if>
                        </#list>
                        <#list trains as train>
                            <#if train.isIssuesEmpty()>
                                <tr>
                                    <td>${train.id}</td>
                                    <td>${train.trainNumber}</td>
                                    <td>${train.trainName}</td>
                                    <td>
                                        <a href="/trains/${train.id}/edit" class="btn btn-primary btn-sm">Edit</a>
                                        <#if train.hasTrip()>
                                            <form action="/trains/${train.id}/delete" method="post" style="display: inline-block">
                                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                                <button class="btn btn-danger btn-sm">Delete</button>
                                            </form>
                                        </#if>
                                    </td>
                                </tr>
                            </#if>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
        </div>
        <@c.pagination moduleUrl="/trains"></@c.pagination>
    </div>
</@c.page>



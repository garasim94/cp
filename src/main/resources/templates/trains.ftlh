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
                    <form method="post" action="/trains/create" onsubmit="return checkTrainNumberUnique(this);">
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
        <div class="modal fade text-center" id="modalDialog" role="alertdialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="modalTitle">Attention</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <span id="modalBody">A user with this username is already registered</span>
                    </div>

                    <div class="modal-footer">
                        <button class="close btn btn-danger" data-dismiss="modal" aria-label="Close">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
        <@c.pagination moduleUrl="/trains"></@c.pagination>
        <script>
            function checkTrainNumberUnique(form){
                url="/trains/check_train_number";
                trainNumber=$("#trainNumber").val();
                trainId=$("#id").val();
                csrfValue=$("input[name='_csrf']").val();
                params={id:trainId, trainNumber: trainNumber,_csrf:csrfValue};
                const modal = new bootstrap.Modal(document.getElementById('modalDialog'));
                $.post(url,params,function (response){
                    if(response =="OK"){
                        form.submit();
                    }else if(response=="Duplicated"){
                        modal.show();
                    } else {
                        alert("Unknown server response");
                    }
                }).fail(function () {
                    alert("Can't connect to server");
                });
                return false;
            }
        </script>
    </div>
</@c.page>



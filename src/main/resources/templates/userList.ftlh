<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <div class="d-flex justify-content-start align-items-center">
            <h1 class="mr-2">List of users</h1>
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
            <a href="/users/export" title="Export to excel file"><i class="mr-2 fa-solid fa-file-excel fa-2x" style="color: rgb(30, 168, 125);"></i></a>
        </div>
        <div class="mr-2">
            <div class="collapse" id="collapseForm">
                <h3 class="mr-2">Create new user:</h3>
                <div class="form-group mt-3">
                    <form method="post" action="/users/create" onsubmit="return checkUsernameUnique(this);">
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="text" class="form-control" id="password" name="password" required minlength="8" maxlength="64">
                        </div>
                        <#list roles as role>
                            <div>
                                <label><input type="checkbox" name="${role}">${role}</label>
                            </div>
                        </#list>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Add</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <@c.search moduleUrl="/users"></@c.search>
        <div class="container mt-4">
            <div id="users-table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <@c.sortColumn columnId="id" columnName="ID" moduleUrl="/users"></@c.sortColumn>
                        <@c.sortColumn columnId="username" columnName="Username" moduleUrl="/users"></@c.sortColumn>
                        <th>Roles</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if users?size == 0>
                        <tr>
                            <td colspan="5">There are no users.</td>
                        </tr>
                    <#else>
                        <#list users as user>
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td><#list user.roles as role>${role}<#sep>, </#list></td>
                                <td>
                                    <a href="/users/${user.id}/edit" class="btn btn-primary btn-sm">Edit</a>
                                    <#if user.hasTrip()>
                                        <form action="/users/${user.id}/delete" method="post" style="display: inline-block">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                            <button class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </#if>
                                </td>
                            </tr>
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
        <script>
            function checkUsernameUnique(form){
                url="/users/check_username";
                username=$("#username").val();
                userId=$("#id").val();
                csrfValue=$("input[name='_csrf']").val();
                params={id:userId, username: username,_csrf:csrfValue};
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
        <@c.pagination moduleUrl="/users"></@c.pagination>
    </div>
</@c.page>
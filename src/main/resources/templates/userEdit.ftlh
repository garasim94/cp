<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <h1>User editor</h1>

        <form action="/users/save" method="post" onsubmit="return checkUsernameUnique(this);">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" name="username" value="${user.username}" required>
            </div>
            <div class="form-group">
                <label for="roles">Roles:</label>
                <div class="form-check">
                    <#list roles as role>
                        <label class="form-check-inline">
                            <input class="form-check-input" type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                            <span class="form-check-label">${role}</span>
                        </label>
                    </#list>
                </div>
            </div>
            <input type="hidden" value="${user.id}" name="userId">
            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/users" class="btn btn-secondary">Cancel</a>
        </form>
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
</@c.page>
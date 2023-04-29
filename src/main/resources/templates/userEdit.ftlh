<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <h1>User editor</h1>

        <form action="/users/save" method="post">
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
</@c.page>
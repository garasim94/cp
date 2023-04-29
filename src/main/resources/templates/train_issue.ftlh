<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <div class="d-flex justify-content-start align-items-center">
            <h1 class="mr-2">Train: ${train.trainName} issues</h1>
        </div>
        <div class="mt-4">
            <div>
                <table class="table">
                    <thead>
                    <tr>
                        <th>Issue description:</th>
                        <th>Action:</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if issues?size == 0>
                        <tr>
                            <td colspan="5">There are no issues.</td>
                        </tr>
                    <#else>
                        <#list issues as issue>
                            <#if issue.status=='DENIED'|| issue.status=='UNREAD'>
                                <tr class="${(issue.status == 'DENIED')?then ('table-danger', 'table-secondary')}">
                                    <td>${issue.message}</td>
                                    <td>
                                        <a class="btn btn-success btn-sm" href="/trains/issue/${train.id}/change_status/${issue.id}/accept">ACCEPT</a>
                                        <a class="btn btn-danger btn-sm" href="/trains/issue/${train.id}/change_status/${issue.id}/deny">DENY</a>
                                    </td>
                                </tr>
                            </#if>
                        </#list>
                        <#list issues as issue>
                            <#if issue.status=='ACCEPT'>
                                <tr class="table-success">
                                    <td>${issue.message}</td>
                                    <td>
                                        <a class="btn btn-success btn-sm" href="/trains/issue/${train.id}/change_status/${issue.id}/accept">ACCEPT</a>
                                        <a class="btn btn-danger btn-sm" href="/trains/issue/${train.id}/change_status/${issue.id}/deny">DENY</a>
                                    </td>
                                </tr>
                            </#if>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
        </div>
        <a href="/trains/${train.id}/edit" class="btn btn-primary btn">Edit Train</a>
    </div>
</@c.page>
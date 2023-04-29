
<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<#include "parts/security.ftlh">

<@c.page>
    <div class="container">
        <div class="mb-1">Add new user</div>
        ${trip!}
        <@l.login "/registration" true />
    </div>
</@c.page>
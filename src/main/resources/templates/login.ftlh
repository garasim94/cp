<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<#include "parts/security.ftlh">
<@c.page>
    <div class="container">
        Login page
        <@l.login "/login" false/>
    </div>
</@c.page>

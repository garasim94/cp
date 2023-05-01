<#assign
known = Session.SPRING_SECURITY_CONTEXT??
>
<#if known>
    <#assign
    user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
    name = user.getUsername()
    isAdmin = user.isAdmin()
    isDispatcher = user.isDispatcher()
    isDriver = user.isDriver()
    isDepotmanager = user.isDepotmanager()
    hasRole=true

    >
<#else>
    <#assign
    name = "unknown"
    isAdmin = false
    isDispatcher= false
    isDriver = false
    isDepotmanager=false
    hasRole=false
    >
</#if>

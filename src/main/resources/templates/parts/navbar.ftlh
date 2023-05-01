<#include "security.ftlh">
<#import "login.ftlh" as l>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">Course project</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <#if hasRole>
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/">Home</a>
                </li>
                <#if isDispatcher>
                    <li class="nav-item">
                        <a class="nav-link" href="/trips">Trip</a>
                    </li>
                </#if>
                <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" href="/users">User list</a>
                    </li>
                </#if>
                <#if isDepotmanager>
                    <li class="nav-item">
                        <a class="nav-link" href="/trains">Trains</a>
                    </li>
                </#if>
                <#if isDriver>
                    <li class="nav-item">
                        <a class="nav-link" href="/driver_trips">Trips</a>
                    </li>
                </#if>
                <li class="nav-item">
                    <a class="nav-link" href="/account">Profile</a>
                </li>
            </ul>
        </#if>
        <div class="navbar-text mr-3 justify-content-end" >${name}</div>
        <@l.logout/>
    </div>
</nav>
<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="form-row">
        <div class="form-group col-md-6">
            <form method="get" action="/main" class="form-inline">
                <input type="text" name="filter" class="form-control" value="${filter?ifExists}" placeholder="Search by tag">
                <button type="submit" class="btn btn-primary ml-2">Search</button>
            </form>
        </div>
    </div>

    <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        Add new Trip
    </a>
    <div class="collapse" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data" action="/main/save">
                <div class="form-group">
                    <input type="text" class="form-control" name="text" placeholder="Enter message" />
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="tag" placeholder="Tag">
                </div>

                <select class="form-control" id="userSelect" name="id">
                    <option selected disabled>-- Select a driver --</option>
                    <#list drivers as user>
                        <option value="${user.id}">${user.username}</option>
                    </#list>
                </select>

<#--                <div class="form-group">-->
<#--                    <div class="custom-file">-->
<#--                        <input type="file" name="file" id="customFile">-->
<#--                        <label class="custom-file-label" for="customFile">Choose file</label>-->
<#--                    </div>-->
<#--                </div>-->
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card-columns">
        <#list trips as trip>
            <div class="card my-3">
                <#if trip.filename??>
                    <img src="/img/${trip.filename}" class="card-img-top">
                </#if>
                <div class="m-2">
                    <span>${trip.text}</span>
                    <i>${trip.routeNumber}</i>
                </div>
                <div class="card-footer text-muted">
                    ${trip.authorName}
                </div>
            </div>
        <#else>
            No trip
        </#list>
    </div>
</@c.page>

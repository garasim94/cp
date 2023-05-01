<#macro page>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Course project</title>
        <link rel="stylesheet" href="/static/style.css">
        <script src="https://kit.fontawesome.com/529d14ae16.js" crossorigin="anonymous"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    </head>
    <body>
    <#include "navbar.ftlh">
    <div class="">
        <#if (message??)>
            <div class="alert alert-success alert-dismissible fade show justify-content-centre" role="alert">
                <span>${message}</span>
            </div>
        </#if>
        <#nested>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    </body>
    </html>
</#macro>
<#macro sortColumn columnId columnName moduleUrl>
    <th>
        <#if sort == columnId>
            <#if order == 'asc'>
                <a href="${moduleUrl}/page/${currentPage}?query=${query}&sort=${columnId}&order=desc">${columnName}▲</a>
            <#else>
                <a href="${moduleUrl}/page/${currentPage}?query=${query}&sort=${columnId}&order=asc">${columnName}▼</a>
            </#if>
        <#else>
            <a href="${moduleUrl}/page/${currentPage}?query=${query}&sort=${columnId}&order=asc">${columnName}</a>
        </#if>
    </th>
</#macro>


<#macro search moduleUrl>
    <form class="form-inline" id="searchForm" method="get" action="${moduleUrl}/page/1">
        <div class="form-group mr-2">
            <input type="text" class="form-control" id="query" name="query" placeholder="Search..." value="${query?default('')}">
        </div>
        <button type="submit" class="btn btn-primary mr-2">Search</button>
        <button type="button" class="btn btn-secondary mr-2" onclick="resetForm()">Reset</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <input type="hidden" name="sort" value="${sort}">
        <input type="hidden" name="order" value="${order}">
    </form>
    <script>
        function resetForm() {
            document.getElementById("query").value = '';
            document.getElementsByName("sort").forEach((element) => {
                element.value = 'id';
            });
            document.getElementsByName("order").forEach((element) => {
                element.value = 'asc';
            });
            document.getElementById("searchForm").submit();
        }
    </script>
</#macro>
<#macro pageLink moduleUrl pageNum label>
    <a class="page-link" href="${moduleUrl}/page/${pageNum}?query=${query}&sort=${sort}&order=${order}">${label}</a>
</#macro>
<#macro pagination moduleUrl>
    <#if totalPages gt 0>
        <nav>
            <ul class="pagination justify-content-center">
                <li class="page-item<#if currentPage == 1> disabled</#if>">
                    <@pageLink moduleUrl="${moduleUrl}" pageNum="1" label="First"></@pageLink>
                </li>

                <li class="page-item<#if currentPage == 1> disabled</#if>">
                    <@pageLink moduleUrl="${moduleUrl}" pageNum="${currentPage - 1}" label="Previuos"></@pageLink>
                </li>

                <#list 1..totalPages as i>
                    <li class="page-item<#if currentPage == i> active</#if>">
                        <@pageLink moduleUrl="${moduleUrl}" pageNum="${i}" label="${i}"></@pageLink>
                    </li>
                </#list>

                <li class="page-item<#if currentPage == totalPages> disabled</#if>">
                    <@pageLink moduleUrl="${moduleUrl}" pageNum="${currentPage + 1}" label="Next"></@pageLink>
                </li>

                <li class="page-item<#if currentPage == totalPages> disabled</#if>">
                    <@pageLink moduleUrl="${moduleUrl}" pageNum="${totalPages}" label="Last"></@pageLink>
                </li>
            </ul>
        </nav>
    </#if>
</#macro>
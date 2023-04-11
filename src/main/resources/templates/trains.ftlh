<#import "parts/common.ftlh" as c>

<@c.page>
<div class="container">
    <h1>Trains</h1>

    <form class="form-inline" id="search-form">
        <div class="form-group mr-2">
            <input type="text" class="form-control" id="query" name="query" placeholder="Search for trains...">
        </div>
        <button type="submit" class="btn btn-primary mr-2">Search</button>
        <a href="/trains/create" class="btn btn-success mr-2">Create Train</a>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
    <div class="container mt-4">
        <div id="trains-table-container">
            <table class="table" id="trains-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Train Number</th>
                    <th>Train Name</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <#if trains?size == 0>
                    <tr>
                        <td colspan="5">There are no trains.</td>
                    </tr>
                <#else>
                    <#list trains as train>
                        <tr>
                            <td>${train.id}</td>
                            <td>${train.trainNumber}</td>
                            <td>${train.trainName}</td>
                            <td>
                                <a href="/trains/${train.id}/edit" class="btn btn-primary btn-sm">Edit</a>
                                <form action="/trains/${train.id}/delete" method="post" style="display: inline-block">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <button class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </#list>
                </#if>
                </tbody>
            </table>
        </div>
<#--        <a href="/trains/create" class="btn btn-success">Create Train</a>-->
    </div>

    <script>
        $(function() {
            $('#search-form').submit(function(event) {
                event.preventDefault(); // prevent the form from submitting
                var query = $('input[name="query"]').val();
                $.ajax({
                    type: 'GET',
                    url: '/trains/search',
                    data: {
                        query: query
                    },
                    success: function(result) {
                        $('#trains-table-container').html(result); // replace the table with the search results
                    },
                    error: function() {
                        alert('Error searching for trains');
                    }
                });
            });
        });
    </script>

</@c.page>
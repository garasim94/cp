<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="mx-5">
        <div class="d-flex justify-content-start align-items-center">
            <h1 class="mr-2">Trips</h1>
            <a title="Add trip" data-toggle="collapse" href="#collapseForm" role="button" aria-expanded="false" aria-controls="collapseExample">
                <i class="mr-2 fa-solid fa-plus fa-2x"></i>
            </a>
            <style>
                .rotate-45 {
                    transform: rotate(45deg);
                    color: red;
                    display: inline-block;
                    position: relative;
                }
            </style>
            <script>
                $(document).ready(function() {
                    $('a[data-toggle="collapse"]').click(function() {
                        $(this).find('i').toggleClass('rotate-45');
                    });
                });
            </script>
            <a href="/trips/export" title="Export to excel file"><i class="mr-2 fa-solid fa-file-excel fa-2x" style="color: rgb(30, 168, 125);"></i></a>
        </div>
        <div class="mr-2" style="width: 50%;">
            <div class="collapse" id="collapseForm">
                <h3 class="mr-2">Create new train:</h3>
                <div class="form-group mt-3">
                    <form method="POST" action="/trips/save">
                        <!-- Поле дата -->
                        <div class="form-group">
                            <label for="departureDate">Departure date:</label>
                            <input type="date" class="form-control" id="departureDate" name="departureDate" required>
                        </div>
                        <!-- Поле время отправления -->
                        <div class="form-group">
                            <label for="departureTime">Departure time:</label>
                            <input type="time" class="form-control" id="departureTime" name="departureTime" required>
                        </div>
                        <div class="form-group">
                            <label for="arrivalDate">Arrival date:</label>
                            <input type="date" class="form-control" id="arrivalDate" name="arrivalDate" required>
                        </div>
                        <!-- Поле время прибытия -->
                        <div class="form-group">
                            <label for="arrivalTime">Arrival time:</label>
                            <input type="time" class="form-control" id="arrivalTime" name="arrivalTime" required>
                        </div>

                        <!-- Остальные поля формы -->
                        <div class="form-group">
                            <label for="startPoint">Point of departure:</label>
                            <input type="text" class="form-control" id="startPoint" name="startPoint" required>
                        </div>

                        <div class="form-group">
                            <label for="endPoint">Point of arrival:</label>
                            <input type="text" class="form-control" id="endPoint" name="endPoint" required>
                        </div>

                        <div class="form-group">
                            <label for="routeNumber">Route number:</label>
                            <input type="number" class="form-control" id="routeNumber" name="routeNumber" required>
                        </div>

                        <div class="form-group">
                            <label for="driverId">Driver:</label>
                            <select id="driverId" name="driverId" class="form-control" required>
                                <option selected disabled>-- Select a driver --</option>
                                <#list driverList as driver>
                                    <option value="${driver.id}">${driver.username}</option>
                                </#list>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="trainId">Train:</label>
                            <select class="form-control" id="trainId" name="trainId" required>
                                <option selected disabled>-- Select a train --</option>
                                <#list trainList as train>
                                    <option value="${train.id}">${train.trainName}</option>
                                </#list>
                            </select>
                        </div>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <button type="submit" class="btn btn-primary">Save</button>
                    </form>
                </div>
            </div>
        </div>
        <@c.search moduleUrl="/trips"></@c.search>
        <div id="trips-table-container mt-2">
            <table class="table ">
                <thead>
                <tr>
                    <@c.sortColumn columnId="id" columnName="ID" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="routeNumber" columnName="Route Number" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="departureDate" columnName="Departure date" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="arrivalDate" columnName="Arrival date" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="departureTime" columnName="Departure time" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="arrivalTime" columnName="Arrival time" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="startPoint" columnName="Point of departure" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="endPoint" columnName="Point of arrival" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="driver" columnName="Driver" moduleUrl="/trips"></@c.sortColumn>
                    <@c.sortColumn columnId="trainTrips.train.trainName" columnName="Train" moduleUrl="/trips"></@c.sortColumn>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <#if tripList?size == 0>
                    <tr>
                        <td colspan="5">There are no trains.</td>
                    </tr>
                <#else>
                    <#list tripList as trip>
                        <tr>
                            <td>${trip.id}</td>
                            <td>${trip.routeNumber}</td>
                            <td>${trip.departureDate}</td>
                            <td>${trip.arrivalDate}</td>
                            <td>${trip.departureTime}</td>
                            <td>${trip.arrivalTime}</td>
                            <td>${trip.startPoint}</td>
                            <td>${trip.endPoint}</td>
                            <td>${trip.driver.username}</td>
                            <td>${trip.trainTrips.train.trainName}</td>
                            <td>
                                <a href="/trips/${trip.id}/edit" class="btn btn-primary btn-sm">Edit</a>
                                <form action="/trips/${trip.id}/delete" method="post" style="display: inline-block">
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
        <@c.pagination moduleUrl="/trips"></@c.pagination>
    </div>
</@c.page>
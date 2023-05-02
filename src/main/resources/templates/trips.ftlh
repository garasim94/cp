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
                    <form method="POST" action="/trips/save" >
                        <div class="form-group">
                            <label for="departureDate">Departure date:</label>
                            <input type="date" class="form-control" id="departureDate" name="departureDate" oninput="checkDepartureDate()" required>
                        </div>

                        <div class="form-group">
                            <label for="departureTime">Departure time:</label>
                            <input type="time" class="form-control" id="departureTime" name="departureTime" required>
                        </div>
                        <div class="form-group">
                            <label for="arrivalDate">Arrival date:</label>
                            <input type="date" class="form-control" id="arrivalDate" name="arrivalDate" required oninput="checkArrivalDate()">
                        </div>

                        <div class="form-group">
                            <label for="arrivalTime">Arrival time:</label>
                            <input type="time" class="form-control" id="arrivalTime" name="arrivalTime" required oninput="checkArrivalTime()">
                        </div>


                        <div class="form-group">
                            <label for="startPoint">Point of departure:</label>
                            <input type="text" class="form-control" id="startPoint" name="startPoint" required>
                        </div>

                        <div class="form-group">
                            <label for="endPoint">Point of arrival:</label>
                            <input type="text" class="form-control" id="endPoint" name="endPoint" required oninput="checkEndPoint()">
                        </div>

                        <div class="form-group">
                            <label for="routeNumber">Route number:</label>
                            <input type="number" class="form-control" id="routeNumber" name="routeNumber" required oninput="checkTripNumberUnique()">
                        </div>

                        <div class="form-group">
                            <label for="driverId">Driver:</label>
                            <select id="driverId" name="driverId" class="form-control" required oninput="checkDriverIsFree()">
                                <option selected disabled>-- Select a driver --</option>
                                <#list driverList as driver>
                                    <option value="${driver.id}">${driver.username}</option>
                                </#list>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="trainId">Train:</label>
                            <select class="form-control" id="trainId" name="trainId" required oninput="checkTrainIsFree()">
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
        <div id="container" class="mt-3">
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
                        <td colspan="5">There are no trips.</td>
                    </tr>
                <#else>
                    <#list tripList as trip>
                        <tr class="${(trip.status == 'ACCEPT')?then('table-success',((trip.status == 'DENIED')?then ('table-danger', 'table-secondary')))}">
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
                                <#if !trip.isIssuesEmpty()>
                                    <a href="/trips/issue/${trip.id}" ><i class="fa-solid fa-triangle-exclamation fa-xl" style="color: #ffff00;"></i></a>
                                </#if>
                            </td>
                        </tr>
                    </#list>
                </#if>
                </tbody>
            </table>
        </div>
        <@c.pagination moduleUrl="/trips"></@c.pagination>
        <script type="text/javascript">
            function checkDepartureDate(){
                var currentDate = new Date();
                var departureDate = new Date($('#departureDate').val());
                if (departureDate < currentDate) {
                    document.getElementById("departureDate").setCustomValidity("Departure date should be greater or equal to current date");
                } else {
                    document.getElementById("departureDate").setCustomValidity("");
                }
            }
            function checkArrivalDate(){
                var arrivalDate = new Date($('#arrivalDate').val());
                var departureDate = new Date($('#departureDate').val());
                if (arrivalDate < departureDate) {
                    document.getElementById("arrivalDate").setCustomValidity("Arrival date should be greater or equal to departure date");
                } else {
                    document.getElementById("arrivalDate").setCustomValidity("");
                }
            }
            function checkArrivalTime(){
                var arrivalTime = $('#arrivalTime').val();
                var departureTime = $('#departureTime').val();
                var arrivalDate = new Date($('#arrivalDate').val());
                var departureDate = new Date($('#departureDate').val());

                if ((departureDate.getTime()===arrivalDate.getTime())&&(departureTime >= arrivalTime)) {
                    alert("Arrival time should be greater than departure time on the same date");
                    document.getElementById("arrivalTime").setCustomValidity("Arrival time should be greater than departure time on the same date");
                } else {
                    document.getElementById("arrivalTime").setCustomValidity("");
                }
            }
            function checkEndPoint(){
                var startPoint = $('#startPoint').val();
                var endPoint = $('#endPoint').val();
                if (startPoint === endPoint) {
                    document.getElementById("endPoint").setCustomValidity("Point of departure and point of arrival should not be the same");
                } else {
                    document.getElementById("endPoint").setCustomValidity("");
                }
            }
            function checkTripNumberUnique(){
                url="/trips/check_trip_number";
                routeNumber=$("#routeNumber").val();
                tripId=$("#id").val();
                csrfValue=$("input[name='_csrf']").val();
                params={id:tripId, routeNumber: routeNumber,_csrf:csrfValue};
                $.post(url,params,function (response){
                    if(response ==="OK"){
                        document.getElementById("routeNumber").setCustomValidity("");
                    }else if(response==="Duplicated"){
                        alert("Trip with this number is already exist");
                        document.getElementById("routeNumber").setCustomValidity("Trip with this number is already exist");
                    } else {
                        alert("Unknown server response");
                    }

                }).fail(function () {
                    alert("Can't connect to server");
                });
                return false;
            }
            function checkDriverIsFree(){
                url="/trips/check_is_driver_free";
                driverId=$("#driverId").val();
                departureDate=$("#departureDate").val();
                arrivalDate=$("#arrivalDate").val();
                departureTime=$("#departureTime").val();
                arrivalTime=$("#arrivalTime").val();
                csrfValue=$("input[name='_csrf']").val();
                params={id:driverId, departureDate: departureDate,arrivalDate: arrivalDate,departureTime: departureTime,arrivalTime: arrivalTime,_csrf:csrfValue};
                $.post(url,params,function (response){
                    if(response ==="OK"){
                        document.getElementById("driverId").setCustomValidity("");
                    }else if(response==="Duplicated"){
                        document.getElementById("driverId").setCustomValidity("This driver is busy at that time");
                    } else {
                        alert("Unknown server response");
                    }

                }).fail(function () {
                    alert("Can't connect to server");
                });
                return false;
            }
            function checkTrainIsFree(){
                url="/trips/check_is_train_free";
                trainId=$("#trainId").val();
                departureDate=$("#departureDate").val();
                arrivalDate=$("#arrivalDate").val();
                departureTime=$("#departureTime").val();
                arrivalTime=$("#arrivalTime").val();
                csrfValue=$("input[name='_csrf']").val();
                params={id:trainId, departureDate: departureDate,arrivalDate: arrivalDate,departureTime: departureTime,arrivalTime: arrivalTime,_csrf:csrfValue};
                $.post(url,params,function (response){
                    if(response ==="OK"){
                        document.getElementById("trainId").setCustomValidity("");
                    }else if(response==="Duplicated"){
                        document.getElementById("trainId").setCustomValidity("This train is reserved at that time");
                    } else {
                        alert("Unknown server response");
                    }

                }).fail(function () {
                    alert("Can't connect to server");
                });
                return false;
            }
        </script>
    </div>
</@c.page>
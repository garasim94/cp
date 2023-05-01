<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <h1>Edit Trip</h1>
        <form method="POST" action="/trips/${trip.id}/update">

            <div class="form-group">
                <label for="departureDate">Departure date:</label>
                <input type="date" class="form-control" id="departureDate" name="departureDate" value="${trip.departureDate}" oninput="checkDepartureDate()" required>
            </div>

            <div class="form-group">
                <label for="departureTime">Departure time:</label>
                <input type="time" class="form-control" id="departureTime" name="departureTime" value="${trip.departureTime}" required>
            </div>
            <div class="form-group">
                <label for="arrivalDate">Arrival date:</label>
                <input type="date" class="form-control" id="arrivalDate" name="arrivalDate" value="${trip.arrivalDate}" oninput="checkArrivalDate()" required>
            </div>

            <div class="form-group">
                <label for="arrivalTime">Arrival time:</label>
                <input type="time" class="form-control" id="arrivalTime" name="arrivalTime" oninput="checkArrivalTime()" value="${trip.arrivalTime}"  required>
            </div>

            <div class="form-group">
                <label for="startPoint">Point of departure:</label>
                <input type="text" class="form-control" id="startPoint" name="startPoint" value="${trip.startPoint}" required>
            </div>

            <div class="form-group">
                <label for="endPoint">Point of arrival:</label>
                <input type="text" class="form-control" id="endPoint" name="endPoint" value="${trip.departureTime}" required oninput="checkEndPoint()">
            </div>

            <div class="form-group">
                <label for="routeNumber">Route number:</label>
                <input type="number" class="form-control" id="routeNumber" name="routeNumber" value="${trip.routeNumber}" required oninput="checkTripNumberUnique()">
            </div>

            <div class="form-group">
                <label for="driverId">Driver:</label>
                <select id="driverId" name="driverId" class="form-control"  oninput="checkDriverIsFree()" required>
                    <option selected value="${trip.driver.id}">${trip.driver.username}</option>
                    <#list driverList as driver>
                        <option value="${driver.id}">${driver.username}</option>
                    </#list>
                </select>
            </div>
            <div class="form-group">
                <label for="trainId">Train:</label>
                <select class="form-control" id="trainId" name="trainId" oninput="checkTrainIsFree()"  required>
                    <option value="${trip.trainTrips.train.id}" selected>${trip.trainTrips.train.trainName}</option>
                    <#list trainList as train>
                        <option value="${train.id}">${train.trainName}</option>
                    </#list>
                </select>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/trips" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
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
            if ((departureDate=== arrivalDate) && (departureTime >= arrivalTime)) {
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
</@c.page>
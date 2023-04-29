<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <h1>Edit Trip</h1>
        <form method="POST" action="/trips/${trip.id}/update">

            <div class="form-group">
                <label for="departureDate">Departure date:</label>
                <input type="date" class="form-control" id="departureDate" name="departureDate" value="${trip.departureDate}">
            </div>

            <div class="form-group">
                <label for="departureTime">Departure time:</label>
                <input type="time" class="form-control" id="departureTime" name="departureTime" value="${trip.departureTime}" required>
            </div>
            <div class="form-group">
                <label for="arrivalDate">Arrival date:</label>
                <input type="date" class="form-control" id="arrivalDate" name="arrivalDate" value="${trip.arrivalDate}" required>
            </div>

            <div class="form-group">
                <label for="arrivalTime">Arrival time:</label>
                <input type="time" class="form-control" id="arrivalTime" name="arrivalTime"value="${trip.arrivalTime}"  required>
            </div>

            <div class="form-group">
                <label for="startPoint">Point of departure:</label>
                <input type="text" class="form-control" id="startPoint" name="startPoint" value="${trip.startPoint}" required>
            </div>

            <div class="form-group">
                <label for="endPoint">Point of arrival:</label>
                <input type="text" class="form-control" id="endPoint" name="endPoint" value="${trip.departureTime}" required>
            </div>

            <div class="form-group">
                <label for="routeNumber">Route number:</label>
                <input type="number" class="form-control" id="routeNumber" name="routeNumber" value="${trip.routeNumber}" required>
            </div>

            <div class="form-group">
                <label for="driverId">Driver:</label>
                <select id="driverId" name="driverId" class="form-control"   required>
                    <option selected value="${trip.driver.id}">${trip.driver.username}</option>
                    <#list driverList as driver>
                        <option value="${driver.id}">${driver.username}</option>
                    </#list>
                </select>
            </div>
            <div class="form-group">
                <label for="trainId">Train:</label>
                <select class="form-control" id="trainId" name="trainId"   required>
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
</@c.page>
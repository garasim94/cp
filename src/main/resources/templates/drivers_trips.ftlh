<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="mx-5">
        <div class="d-flex justify-content-start align-items-center">
            <h1 class="mr-2">Trips</h1>
            <a href="/driver_trips/export" title="Export to excel file"><i class="mr-2 fa-solid fa-file-excel fa-2x" style="color: rgb(30, 168, 125);"></i></a>
        </div>
        <@c.search moduleUrl="/driver_trips"></@c.search>
        <div class="mt-4">
            <div id="trains-table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <@c.sortColumn columnId="routeNumber" columnName="Route Number" moduleUrl="/driver_trips"></@c.sortColumn>
                        <@c.sortColumn columnId="departureDate" columnName="Departure date" moduleUrl="/driver_trips"></@c.sortColumn>
                        <@c.sortColumn columnId="arrivalDate" columnName="Arrival date" moduleUrl="/driver_trips"></@c.sortColumn>
                        <@c.sortColumn columnId="departureTime" columnName="Departure time" moduleUrl="/driver_trips"></@c.sortColumn>
                        <@c.sortColumn columnId="arrivalTime" columnName="Arrival time" moduleUrl="/driver_trips"></@c.sortColumn>
                        <@c.sortColumn columnId="startPoint" columnName="Point of departure" moduleUrl="/driver_trips"></@c.sortColumn>
                        <@c.sortColumn columnId="endPoint" columnName="Point of arrival" moduleUrl="/driver_trips"></@c.sortColumn>
                        <@c.sortColumn columnId="trainTrips.train.trainName" columnName="Train" moduleUrl="/driver_trips"></@c.sortColumn>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if trips?size == 0>
                        <tr>
                            <td colspan="5">There are no trips.</td>
                        </tr>
                    <#else>
                        <#list trips as trip>
                            <#if trip.status=="UNREAD">
                                <tr class="table-secondary">
                                    <td>${trip.routeNumber}</td>
                                    <td>${trip.departureDate.toString()}</td>
                                    <td>${trip.arrivalDate}</td>
                                    <td>${trip.departureTime}</td>
                                    <td>${trip.arrivalTime}</td>
                                    <td>${trip.startPoint}</td>
                                    <td>${trip.endPoint}</td>
                                    <td>${trip.trainTrips.train.trainName}</td>
                                    <td>
                                        <a class="btn btn-success btn-sm" href="/driver_trips/change_status/${trip.id}/accept">ACCEPT</a>
                                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal" data-trip-id="${trip.id}">
                                            DENY
                                        </button>
                                    </td>
                                </tr>
                            </#if>
                        </#list>
                        <#list trips as trip>
                            <#if trip.status=="ACCEPT">
                                <tr class="table-success">
                                    <td>${trip.routeNumber}</td>
                                    <td>${trip.departureDate}</td>
                                    <td>${trip.arrivalDate}</td>
                                    <td>${trip.departureTime}</td>
                                    <td>${trip.arrivalTime}</td>
                                    <td>${trip.startPoint}</td>
                                    <td>${trip.endPoint}</td>
                                    <td>${trip.trainTrips.train.trainName}</td>
                                    <td></td>
                                </tr>
                            </#if>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Report Issue</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="/issue/save" id="myForm">
                            <div class="form-group">
                                <label for="type">Select what is causing the problem</label>
                                <select class="form-control" id="type" name="type" required>
                                    <option selected disabled>-- Select --</option>
                                    <option value="trip">Trip</option>
                                    <option value="train">Train</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="message">Message:</label>
                                <textarea class="form-control" id="message" name="message" placeholder="Write down problem here..." required></textarea>
                            </div>
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <input type="hidden" name="tripId" value="" id="tripIdInput">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <a href="/drivers_trips" class="btn btn-secondary" data-dismiss="modal">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
<#--        <div>-->
<#--            <form method="post" action="/issue/save">-->
<#--                <div class="form-group">-->
<#--                    <label for="type">Select what is causing the problem </label>-->
<#--                    <select class="form-control" id="type" name="type"   required>-->
<#--                        <option selected disabled>-- Select --</option>-->
<#--                        <option value="trip" selected>Trip</option>-->
<#--                        <option value="train" selected>Train</option>-->
<#--                    </select>-->
<#--                </div>-->
<#--                <div class="form-group">-->
<#--                    <label for="message">Message:</label>-->
<#--                    <input type="text" class="form-control" id="message" name="message" placeholder="Write down problem here..." required>-->
<#--                </div>-->
<#--                <input type="hidden" name="_csrf" value="${_csrf.token}" />-->
<#--                <input type="hidden" name="tripId" value="${trip.id}" />-->
<#--                <button type="submit" class="btn btn-primary">Save</button>-->
<#--                <a href="/drivers_trips" class="btn btn-secondary">Cancel</a>-->
<#--            </form>-->
<#--        </div>-->
        <script>
            $(document).ready(function(){
                $("#myModal").on("show.bs.modal", function(event) {
                    var button = $(event.relatedTarget);
                    var tripId = button.data("trip-id");
                    var modal = $(this);
                    modal.find("#tripIdInput").val(tripId);
                });

                $("#myForm").submit(function(event){
                    event.preventDefault();
                    var formData = $(this).serialize();
                    $.ajax({
                        url: $(this).attr("action"),
                        type: $(this).attr("method"),
                        data: formData,
                        success: function(response){
                            $("#myModal").modal("hide");
                            alert("Issue has been reported successfully!");
                            location.reload();
                        },
                        error: function(xhr, status, error){
                            alert("Error while reporting issue: " + error);
                        }

                    });
                });
            });
        </script>
        <@c.pagination moduleUrl="/driver_trips"></@c.pagination>
    </div>
</@c.page>
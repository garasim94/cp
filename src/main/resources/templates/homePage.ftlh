<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="mx-5">
        <h1 class="mr-2">Actual trips</h1>
        <@c.search moduleUrl="/home"></@c.search>
        <div class="mt-3">
            <table class="table ">
                <thead>
                <tr>
                    <@c.sortColumn columnId="routeNumber" columnName="Route Number" moduleUrl="/home"></@c.sortColumn>
                    <@c.sortColumn columnId="departureDate" columnName="Departure date" moduleUrl="/home"></@c.sortColumn>
                    <@c.sortColumn columnId="arrivalDate" columnName="Arrival date" moduleUrl="/home"></@c.sortColumn>
                    <@c.sortColumn columnId="departureTime" columnName="Departure time" moduleUrl="/home"></@c.sortColumn>
                    <@c.sortColumn columnId="arrivalTime" columnName="Arrival time" moduleUrl="/home"></@c.sortColumn>
                    <@c.sortColumn columnId="startPoint" columnName="Point of departure" moduleUrl="/home"></@c.sortColumn>
                    <@c.sortColumn columnId="endPoint" columnName="Point of arrival" moduleUrl="/home"></@c.sortColumn>
                    <@c.sortColumn columnId="trainTrips.train.trainName" columnName="Train" moduleUrl="/home"></@c.sortColumn>
                </tr>
                </thead>
                <tbody>
                <#if tripList?size == 0>
                    <tr>
                        <td colspan="5">There are no trips.</td>
                    </tr>
                <#else>
                    <#list tripList as trip>
                        <#if trip.status=='ACCEPT'>
                            <tr>
                                <td>${trip.routeNumber}</td>
                                <td>${trip.departureDate}</td>
                                <td>${trip.arrivalDate}</td>
                                <td>${trip.departureTime}</td>
                                <td>${trip.arrivalTime}</td>
                                <td>${trip.startPoint}</td>
                                <td>${trip.endPoint}</td>
                                <td>${trip.trainTrips.train.trainName}</td>
                            </tr>
                        </#if>
                    </#list>
                </#if>
                </tbody>
            </table>
        </div>
    </div>
    <@c.pagination moduleUrl="/home"></@c.pagination>
</@c.page>
<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container">
        <h1>Edit Train</h1>

        <form method="post" action="/trains/${train.id}/update" onsubmit="return checkTrainNumberUnique(this);">
            <div class="form-group">
                <label for="trainNumber">Train Number</label>
                <input type="text" class="form-control" id="trainNumber" name="trainNumber" value="${train.trainNumber}">
            </div>

            <div class="form-group">
                <label for="trainName">Train Name</label>
                <input type="text" class="form-control" id="trainName" name="trainName" value="${train.trainName}">
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/trains" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
    <script>
        function checkTrainNumberUnique(form){
            url="/trains/check_train_number";
            trainNumber=$("#trainNumber").val();
            trainId=$("#id").val();
            csrfValue=$("input[name='_csrf']").val();
            params={id:trainId, trainNumber: trainNumber,_csrf:csrfValue};
            const modal = new bootstrap.Modal(document.getElementById('modalDialog'));
            $.post(url,params,function (response){
                if(response =="OK"){
                    form.submit();
                }else if(response=="Duplicated"){
                    modal.show();
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
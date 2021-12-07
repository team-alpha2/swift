<style type ="text/css" >
.header{     
    background-color: #2E86C1;   
    
}  
</style>

<div class="header">
<div class="w3-container w3-topbar w3-leftbar w3-rightbar w3-bottombar w3-border-white" >
  <img src="https://drive.google.com/thumbnail?id=1kLutYQtcu_-0RqnszxPJzimIN8R1rDSI" alt="logo" height="100px"  >

  <span class="w3-xxxlarge w3-margin"><b>eAsy Scheduler</b></span>
  <span class="w3-right">
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Sign up</span>
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log In</span>
    <span id="calendar" class="w3-large w3-button w3-margin w3-round-large w3-blue">View Calendar
        <input id="value" type="date" style="overflow:hidden">
        <button class="w3-large w3-button w3-margin w3-round-large w3-blue" onclick="handleData()">Submit Query</button>
    </span>
  </span>
</div>
</div>

<script>

hideCalendar = true;

function handleData() {
    let value = document.getElementById("value").value;
    
    setTimeout(() => {
        api_get_tasks(function(result){
            for (const task of result.tasks) {
                let date = new Date(task.time);

                let day = date.getDay();
                let month = date.getMonth();
                let year = date.getYear();

                let inputDate = new Date(value);

                let inputDay = inputDate.getDay();
                let inputMonth = inputDate.getMonth();
                let inputYear = inputDate.getYear();

                console.log("here")

                if(day == inputDay && month == inputMonth && year == inputYear)
                    display_task(task);
            }
        });
    }, 1000);

    console.log(value);
}

</script>


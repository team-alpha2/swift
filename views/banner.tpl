<style type ="text/css" >
.header{     
    background-image: linear-gradient(to right, #303030, #909090);   
}  

#custom{
    background-color: #2196F3!important
}

#custom:hover{
    background-color:aqua!important
}

</style>

<div class="header">
<div class="w3-container w3-topbar w3-leftbar w3-rightbar w3-bottombar w3-border-white">
<!--Find a way to make local images work-->
  <img src="https://i.ibb.co/Y7YGY1Q/testlogo.png" alt="test logo" style="border:2px solid #fff;transform:translate(0px, -10px);width:60px;height:50px;">
  <span class="w3-xxxlarge w3-margin"><b>eAsy Scheduler</b></span>
  <span class="w3-right">
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Sign up</span>
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log In</span>
    <span id="calendar" class="w3-large w3-button w3-margin w3-round-large w3-grey">View Calendar
        <input id="value" type="date" style="overflow:hidden">
        <button id="custom" class="w3-large w3-button w3-margin w3-round-large w3-blue" onclick="handleData()">Submit Query</button>
    </span>
  </span>
</div>
</div>

<script>

hideCalendar = true;

function handleData() {
    let value = document.getElementById("value").value;
    let elements = document.getElementsByClassName("task");



    setTimeout(() => {
        api_get_tasks(function(result){
            for (const task of result.tasks) {
                for(const e of elements) {
                    if(!e.innerText.includes(':'))
                        continue;

                    
                    
                }
                let date = new Date(task.time);

                let day = date.getDay();
                let month = date.getMonth();
                let year = date.getYear();

                let inputDate = new Date(value);

                let inputDay = inputDate.getDay();
                let inputMonth = inputDate.getMonth();
                let inputYear = inputDate.getYear();

                //new Date(document.getElementsByClassName("task")[2].innerText.substr(31).replace("\tdelete", ''))

                console.log("here")

                if(day == inputDay && month == inputMonth && year == inputYear)
                    display_task(task);
            }
        });
    }, 1000);

    console.log(value);
}

</script>


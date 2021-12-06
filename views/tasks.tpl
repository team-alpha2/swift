% include("header.tpl")
% include("banner.tpl")

<style>

.save_edit, .undo_edit, .move_task, .description, .edit_task, .delete_task, .time {
    cursor: pointer;
  }
  .completed {
    text-decoration-line: line-through;
  }
  .description { padding-left:8px }

  #divInput{
    display: inline;
  }
  #divInput:hover{
    background-color: #19567B;
  }

body {
  background-color: #77aa77;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100%25' height='100%25' viewBox='0 0 2 1'%3E%3Cdefs%3E%3ClinearGradient id='a' gradientUnits='userSpaceOnUse' x1='0' x2='0' y1='0' y2='1' gradientTransform='rotate(10,0.5,0.5)'%3E%3Cstop offset='0' stop-color='%2377aa77'/%3E%3Cstop offset='1' stop-color='%23486EFF'/%3E%3C/linearGradient%3E%3ClinearGradient id='b' gradientUnits='userSpaceOnUse' x1='0' y1='0' x2='0' y2='1' gradientTransform='rotate(127,0.5,0.5)'%3E%3Cstop offset='0' stop-color='%23cf8' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%23cf8' stop-opacity='1'/%3E%3C/linearGradient%3E%3ClinearGradient id='c' gradientUnits='userSpaceOnUse' x1='0' y1='0' x2='2' y2='2' gradientTransform='rotate(0,0.5,0.5)'%3E%3Cstop offset='0' stop-color='%23cf8' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%23cf8' stop-opacity='1'/%3E%3C/linearGradient%3E%3C/defs%3E%3Crect x='0' y='0' fill='url(%23a)' width='2' height='1'/%3E%3Cg fill-opacity='0.5'%3E%3Cpolygon fill='url(%23b)' points='0 1 0 0 2 0'/%3E%3Cpolygon fill='url(%23c)' points='2 1 2 0 0 0'/%3E%3C/g%3E%3C/svg%3E");
  background-attachment: fixed;
  background-size: cover;
}
   span {
     color: white;
     font-family: 'Roboto Condensed', sans-serif;
   }
  h1 {
    font-family: 'Roboto Condensed', sans-serif;
    color: white;
   }

.dark-mode {
  background-color: #638D63;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100%25' height='100%25' viewBox='0 0 2 1'%3E%3Cdefs%3E%3ClinearGradient id='a' gradientUnits='userSpaceOnUse' x1='0' x2='0' y1='0' y2='1'%3E%3Cstop offset='0' stop-color='%23638D63'/%3E%3Cstop offset='1' stop-color='%2319567B'/%3E%3C/linearGradient%3E%3ClinearGradient id='b' gradientUnits='userSpaceOnUse' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%235F5F5F' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%235F5F5F' stop-opacity='1'/%3E%3C/linearGradient%3E%3ClinearGradient id='c' gradientUnits='userSpaceOnUse' x1='0' y1='0' x2='2' y2='2'%3E%3Cstop offset='0' stop-color='%235F5F5F' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%235F5F5F' stop-opacity='1'/%3E%3C/linearGradient%3E%3C/defs%3E%3Crect x='0' y='0' fill='url(%23a)' width='2' height='1'/%3E%3Cg fill-opacity='0.5'%3E%3Cpolygon fill='url(%23b)' points='0 1 0 0 2 0'/%3E%3Cpolygon fill='url(%23c)' points='2 1 2 0 0 0'/%3E%3C/g%3E%3C/svg%3E");
  background-attachment: fixed;
  background-size: cover;
}

.button {
  border: none;
  color: white;
  padding: 10px 24px;
  border-radius: 8px;
  transition-duration: 0.4s;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 12px;
  margin: 5px 30px;
  cursor: pointer;
  position: absolute;
  bottom: 60px;
  left: 1%;
}
.button1 {
  background-color:#19567B;
  color: white;
  }

.button1:hover {
  background-color:#638D63;
  color: white;
}

</style>

<div class="w3-row">
  <div class="w3-col s6 w3-container w3-border-white">
    <div class="w3-row w3-xxlarge w3-bottombar w3-border-white w3-margin-bottom">
      <h1><i>Scheduled</i></h1>
    </div>
    <table id="task-list-today" class="w3-table">
    </table>
    
  </div>
  <div class="w3-col s6 w3-container w3-border-white">
    <div class="w3-row w3-xxlarge w3-bottombar w3-border-white w3-margin-bottom">
      <h1><i>To Be Scheduled</i></h1>
    </div>
    <table  id="task-list-tomorrow" class="w3-table">
    </table>
  </div>
</div>
<input id="current_input" hidden value=""/> 

<!--Adds the Button to the page-->
<button class="button button1", onclick="myFunction()">Change Theme</button>

<!--Calls the function to toggle the button-->
<script>
  function myFunction() {
    var element = document.body;
    element.classList.toggle("dark-mode");
  }
</script>

<script>

/* API CALLS */

function api_get_tasks(success_function) {
  $.ajax({url:"api/tasks", type:"GET", 
          success:success_function});
}

function api_create_task(task, success_function) {
  console.log("creating task with:", task)
  $.ajax({url:"api/tasks", type:"POST", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}

function api_update_task(task, success_function) {
  console.log("updating task with:", task)
  task.id = parseInt(task.id)
  $.ajax({url:"api/tasks", type:"PUT", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}

function api_delete_task(task, success_function) {
  console.log("deleting task with:", task)
  task.id = parseInt(task.id)
  $.ajax({url:"api/tasks", type:"DELETE", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}

/* KEYPRESS MONITOR */

function input_keypress(event) {
  if (event.target.id != "current_input") {
    $("#current_input").val(event.target.id)
  }
  id = event.target.id.replace("input-","");
  $("#filler-"+id).prop('hidden', true);
  $("#save_edit-"+id).prop('hidden', false);
  $("#undo_edit-"+id).prop('hidden', false);
}

/* EVENT HANDLERS */

function move_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("move item", event.target.id )
  id = event.target.id.replace("move_task-","");
  target_list = event.target.className.search("today") > 0 ? "tomorrow" : "today";
  api_update_task({'id':id, 'list':target_list},
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}

function complete_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("complete item", event.target.id )


  //original click on description to cross off a task
  if(event.target.id.includes("description-")){
    id = event.target.id.replace("description-","");
  }
  //allow clicks on time to cross off a task
  else if(event.target.id.includes("time-")){
    id = event.target.id.replace("time-", "");
  }


  completed = event.target.className.search("completed") > 0;
  console.log("updating :",{'id':id, 'completed':completed==false})
  api_update_task({'id':id, 'completed':completed==false}, 
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}

function edit_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("edit item", event.target.id)
  id = event.target.id.replace("edit_task-","");
  // move the text to the input editor
  $("#input-"+id).val($("#description-"+id).text());
  // hide the text display
  $("#move_task-"+id).prop('hidden', true);
  $("#description-"+id).prop('hidden', true);
  $("#edit_task-"+id).prop('hidden', true);
  $("#delete_task-"+id).prop('hidden', true);
  $("#time-"+id).prop('hidden', true);
  // show the editor
  $("#editor-"+id).prop('hidden', false);
  $("#save_edit-"+id).prop('hidden', false);
  $("#undo_edit-"+id).prop('hidden', false);
  // set the editing flag
  $("#current_input").val(event.target.id)
}

function save_edit(event) {
  console.log("save item", event.target.id)
  id = event.target.id.replace("save_edit-","");
  console.log("desc to save = ",$("#input-" + id).val())
  if ((id != "today") & (id != "tomorrow")) {
    api_update_task({'id':id, description:$("#input-" + id).val(), appointmentTime:$("#input-time-" + id).val(), appointmentColor:$("#appt-color-" +id).val()},
                    function(result) { 
                      console.log(result);
                      get_current_tasks();
                      $("#current_input").val("")
                    } );
  } else {
    api_create_task({description:$("#input-" + id).val(), list:id, appointmentTime:$("#input-time-" + id).val(), appointmentColor:$("#appt-color-" +id).val()},
                    function(result) { 
                      console.log(result);
                      get_current_tasks();
                      $("#current_input").val("")
                    } );
  }
}

function undo_edit(event) {
  id = event.target.id.replace("undo_edit-","")
  console.log("undo",[id])
  //reset values
  $("#input-" + id).val("");
  $("#input-time-" + id).val("");
  $("#appt-color-" + id).val("#ffffff");
  //turn off the save edit and undo edit buttons
  $("#save_edit-"+id).prop('hidden', true);
  $("#undo_edit-"+id).prop('hidden', true);
  if ((id != "today") & (id != "tomorrow")) {
    // hide the editor
    $("#editor-"+id).prop('hidden', true);
    // show the text display
    $("#move_task-"+id).prop('hidden', false);
    $("#description-"+id).prop('hidden', false);
    $("#filler-"+id).prop('hidden', false);
    $("#edit_task-"+id).prop('hidden', false);
    $("#delete_task-"+id).prop('hidden', false);
    $("#time-"+id).prop('hidden', false);
  }
  // set the editing flag
  $("#current_input").val("")
}

function delete_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("delete item", event.target.id )
  id = event.target.id.replace("delete_task-","");
  api_delete_task({'id':id},
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}

function display_task(x) {
  arrow = (x.list == "today") ? "arrow_forward" : "arrow_back";
  completed = x.completed ? " completed" : "";
  if ((x.id == "today") | (x.id == "tomorrow")) {
    t = '<tr id="task-'+x.id+'" class="task">' +
        '  <td style="width:36px"></td>' +  
        '  <td><span id="editor-'+x.id+'">' + 
        '        <input id="input-'+x.id+'" style="height:22px" class="w3-input w3-border" '+ 
        '          type="text" autofocus placeholder="Add an item..."/>'+
        '         <label for="input-time-'+x.id+'">Select a time:</label>'+
        '        <input id="input-time-'+x.id+'" style="height:22px; display:inline-block; width:180px;" class="w3-input w3-border" type="time"/>'+
        '         <label for="appt-color-'+x.id+'">Select a color:</label>'+
        '        <input id="appt-color-'+x.id+'" type="color" value="#ffffff" '+
        '          name="appt-color-'+x.id+'" style="height:22px; display:inline-block; width:22px; background-color:white;"/>'+
        '      </span>' + 
        '  </td>' +
        '  <td style="width:72px">' +
        '    <span id="filler-'+x.id+'" class="material-icons">more_horiz</span>' + 
        '    <span id="save_edit-'+x.id+'" hidden class="save_edit material-icons">done</span>' + 
        '    <span id="undo_edit-'+x.id+'" hidden class="undo_edit material-icons">cancel</span>' +
        '  </td>' +
        '</tr>';
  } else {
    t = '<tr id="task-'+x.id+'" class="task">' + 
        '  <td><span id="move_task-'+x.id+'" class="move_task '+x.list+' material-icons">' + arrow + '</span></td>' +
        '  <td><span id="edit_task-'+x.id+'" class="edit_task '+x.list+' material-icons">edit</span>' +
        '      <div id="divInput">'+
        '      <span id="description-'+x.id+'" class="description' + completed + '" style="color:'+x.appointmentColor+'";>' + x.description + '</span>' + 
        '      <span id="time-'+x.id+'" class="description '+completed+'" style="padding-left:0px; color:'+x.appointmentColor+'"' + '">'+ (x.appointmentTime ? ' - ' : '') + (x.appointmentTime ? x.appointmentTime : '') + '</span>' + 
        '       </div>'+
        '      <span id="editor-'+x.id+'" hidden>' + 
        '        <input id="input-'+x.id+'" style="height:22px" class="w3-input w3-border" type="text" autofocus/>' +
        '         <label for="input-time-'+x.id+'">Select a time:</label>'+
        '        <input id="input-time-'+x.id+'" name="input-time-'+x.id+'" style="height:22px; display:inline-block; width:180px;" class="w3-input w3-border"'+
        '        type="time" value="'+ (x.appointmentTime) +'"/>'+
        '        <label for="appt-color-'+x.id+'">Select a color:</label>'+
        '        <input id="appt-color-'+x.id+'" type="color" value="'+x.appointmentColor +'" '+
        '          name="appt-color-'+x.id+'" style="height:22px; display:inline-block; width:22px; background-color:white;"/>'+
        '      </span>' + 
        '  </td>' +
        '  <td>' +
        '    <span id="delete_task-'+x.id+'" class="delete_task material-icons">delete</span>' +
        '    <span id="save_edit-'+x.id+'" hidden class="save_edit material-icons">done</span>' + 
        '    <span id="undo_edit-'+x.id+'" hidden class="undo_edit material-icons">cancel</span>' +
        '  </td>' +
        '</tr>';
  }
  $("#task-list-" + x.list).append(t);
  $("#current_input").val("")
}

function get_current_tasks() {
  // remove the old tasks
  $(".task").remove();
  // display the new task editor
  display_task({id:"today", list:"today"})
  display_task({id:"tomorrow", list:"tomorrow"})
  // display the tasks
  api_get_tasks(function(result){
    for (const task of result.tasks) {
      display_task(task);
    }
    // wire the response events 
    $(".move_task").click(move_task);
    $(".description").click(complete_task)
    $(".edit_task").click(edit_task);
    $(".save_edit").click(save_edit);
    $(".undo_edit").click(undo_edit);
    $(".delete_task").click(delete_task);
    // set all inputs to set flag
    $("input").keypress(input_keypress);
  });
}

$(document).ready(function() {
  get_current_tasks()
});

</script>
% include("footer.tpl")

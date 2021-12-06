<div class="w3-container w3-topbar w3-leftbar w3-rightbar w3-bottombar w3-border-white">
  <span class="w3-xxxlarge w3-margin"><b>Schedule</b></span>
  <span class="w3-right">
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">zzzSign up</span>
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log In</span>
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log Out</span>
    <button id="calendar" class="w3-large w3-button w3-margin w3-round-large w3-blue" onclick="toggleCalendar()">View Calendar</span>
    <input type="date" style="overflow:hidden">
  </span>
</div>

<script>

hideCalendar = true;

function toggleCalendar() {
    let calendar = document.getElementById("calendar");
    hideCalendar = !hideCalendar;

    calendar.setAttribute("hidden", hideCalendar);
}

</script>


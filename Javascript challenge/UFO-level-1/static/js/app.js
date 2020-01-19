// from data.js
var tableData = data;

// YOUR CODE HERE!
console.log(data);
var tbody = d3.select("tbody");

data.forEach(function(ufoSighting) {
  console.log(ufoSighting);

  var row = tbody.append("tr");

  Object.entries(ufoSighting).forEach(function([key, value]) {
    console.log(key, value);
    // Append a cell to the row for each value
    // in the ufo sighting object
    var cell = tbody.append("td");
    cell.text(value);
  });
});

// Assign the data from `data.js` to a descriptive variable
var sightings = data;

// Select the submit button
var submit = d3.select("#filter-btn");

submit.on("click", function() {

  // Prevent the page from refreshing
  d3.event.preventDefault();

  // Select the input element and get the raw HTML node
  var inputElement = d3.select("#datetime");

  // Get the value property of the input element
  var inputValue = inputElement.property("value");

  //console.log(inputValue);

  var filteredData = sightings.filter(sighting => sighting.datetime === inputValue);

  console.log("this is filtereddata",filteredData);
//-------------------------------
  // delete existing table
  d3.select("tbody").selectAll("*").remove()
  // replace table with filtered data
  var tbody = d3.select("tbody");
  filteredData.forEach(function(ufoSighting) {
    console.log(ufoSighting);
    var row = tbody.append("tr");

    Object.entries(ufoSighting).forEach(function([key, value]) {
      console.log(key, value);

      // Append a cell to the row for each value in the ufo sighting object
      var cell = tbody.append("td");
      cell.text(value);
    });
  });
});

// Select the reset button
var resetbtn = d3.select("#reset-btn");
resetbtn.on("click", function() {
  // Prevent the page from refreshing
  d3.event.preventDefault();
//-------------------------------
// delete existing table
  d3.select("tbody").selectAll("*").remove()
  // replace table with complete dataset
  var tbody = d3.select("tbody");
  data.forEach(function(ufoSighting) {
    console.log(ufoSighting);
    var row = tbody.append("tr");
    Object.entries(ufoSighting).forEach(function([key, value]) {
      console.log(key, value);
      // Append a cell to the row for each value in the ufo sighting object
      var cell = tbody.append("td");
      cell.text(value);
    });
  });
});
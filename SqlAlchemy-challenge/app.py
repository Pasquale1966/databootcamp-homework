import datetime as dt
import numpy as np
import pandas as pd
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, inspect
from sqlalchemy import func
from sqlalchemy import Column, Integer, String, Float
from sqlalchemy import desc
from sqlalchemy.orm import sessionmaker, scoped_session
from flask import Flask,jsonify
################################################## Database Setup#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")
# reflect an existing database into a new model
Base = automap_base()# reflect the tables
Base.prepare(engine, reflect=True)
# Save references to each table
Measurement = Base.classes.measurement
Station = Base.classes.station
# Create our session (link) from Python to the DB
session = Session(engine)
################################################## Flask Setup#################################################
app = Flask(__name__)

#create query for /api/v1.0/precipitation

# Design a query to retrieve the last 12 months of precipitation data and plot the results
max_date = session.query(Measurement.date).order_by(Measurement.date.desc()).first()

# Get the first element of the tuple
max_date = max_date[0]

# Calculate the date 1 year ago from the last data point in the database
# The days are equal 365 so that the first day of the year is included
year_ago = dt.datetime.strptime(max_date, "%Y-%m-%d") - dt.timedelta(days=365)

# Perform a query to retrieve the data and precipitation scores
query = session.query(Measurement.date, Measurement.prcp,Measurement.tobs).filter(Measurement.date >= year_ago).all()

# Save the query results as a Pandas DataFrame and set the index to the date column
df = pd.DataFrame(query,columns=['date', 'precipitation','tobs'])

# Change datatype from element to datetime object on Pandas
df['date'] = str(pd.to_datetime(df['date'], format='%Y-%m-%d'))

# Set index to date
df.set_index('date', inplace=True)

# Sort the dataframe by date
df = df.sort_values(by='date',ascending=True)
dict_df = df.to_dict()["tobs"]
dict1_df = df.to_dict()["precipitation"]


#create query for stations api
stations_query = session.query(Station.id,Station.station,Station.name, Station.latitude, Station.longitude,Station.elevation).all()

#create query for tobs api 

#Design a query to find the most active stations
active_stations = session.query(Measurement.station,
                                func.count(Measurement.tobs)).group_by(Measurement.station).order_by(func.count(Measurement.tobs).desc()).all()

#List the stations and obsevation counts in descending order
#print(active_stations)

#Design a query to retrieve the last 12 months of temperature observation data (tobs) for the most active station
active_tobs_df = session.query(Measurement.station,Measurement.date,Measurement.tobs).filter(Measurement.date>=year_ago,Measurement.station==active_stations[0][0]).order_by(Measurement.tobs).all()


@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        "Hawaii Precipitation and Weather Data<br/><br/>"
        "Pick from the available routes below:<br/><br/>"
        "Precipiation.<br/>"
        "/api/v1.0/precipitation<br/><br/>"
        "A list of all the weather stations in Hawaii.<br/>"
        "/api/v1.0/stations<br/><br/>"
        "The Temperature Observations (tobs).<br/>"
        "/api/v1.0/tobs<br/><br/>"
        "Type in a single date (i.e., 2015-01-01) to see the min, max and avg temperature since that date.<br/>"
        "/api/v1.0/temp/<start><br/><br/>"
        "Type in a date range (i.e., 2015-01-01/2015-01-10) to see the min, max and avg temperature for that range.<br/>"
        "/api/v1.0/temp/<start>/<end><br/>"
    )

#'/api/v1.0/precipitation`
#Convert the query results to a Dictionary using `date` as the key and `prcp` as the value.
#Return the JSON representation of your dictionary.

@app.route("/api/v1.0/precipitation")
def precipitation():
    print("Server received request for 'Precipitation' page...")
    return jsonify(dict1_df)


#`/api/v1.0/stations`
#Return a JSON list of stations from the dataset.
@app.route("/api/v1.0/stations")
def stations():
    print("Server received request for 'Stations' page...")
    return jsonify(stations_query)

#`/api/v1.0/tobs`
# query for the dates and temperature observations from a year from the last data point.
#Return a JSON list of Temperature Observations (tobs) for the previous year.

@app.route("/api/v1.0/tobs")
def tobs():
    print("Server received request for 'Temperature Observations (tobs)' page...")
    return jsonify(dict_df)


@app.route("/api/v1.0/temp/<start>")
@app.route("/api/v1.0/temp/<start>/<end>")
def stats(start=None, end=None):
    """Return TMIN, TAVG, TMAX."""
    #Select statement
    sel = [func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)]
    if not end:
    # calculate TMIN, TAVG, TMAX for dates greater than start
        results = session.query(*sel).filter(Measurement.date >= start).all()
    #print(results)
    # Unravel results into a 1D array and convert to a list
    temps = list(np.ravel(results))
    return jsonify(temps)
    # calculate TMIN, TAVG, TMAX with start and stop
    results = session.query(*sel).filter(Measurement.date >= start).filter(Measurement.date <= end).all()
    # Unravel results into a 1D array and convert to a list
    temps = list(np.ravel(results))
    return jsonify(temps)

if __name__ == '__main__':
	app.run(debug=True)
        


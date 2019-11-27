import streamlit as st
import pandas as pd
import numpy as np
import time
import matplotlib.pyplot as plt
import numpy as np

from pandas import DataFrame
DATA_URL = ('C:\\Users\\Navee\\OneDrive\\Documents\\Tools\\apache-jmeter-5.1.1\\apache-jmeter-5.1.1\\bin\\LoadTest.csv')

st.title('Apache JMeter Load Test Results')
data = pd.read_csv(DATA_URL)
#if st.checkbox('Show raw data'):
    #st.subheader('Raw data')
    #st.write(data)

#Converting timestamp to datatime
#data['timeStamp'] = pd.to_datetime(data['timeStamp'],unit='ms')

#chart_data = pd.DataFrame(data,columns=['Connect','Latency','responseCode','bytes'])

#if st.checkbox('Connect'):
#    chart_data = pd.DataFrame(data,columns=['Connect'])
#    st.line_chart(chart_data)

#if st.checkbox('Latency'):
    #chart_data = pd.DataFrame(data,columns=['Latency'])
    #st.line_chart(chart_data) 

#data = pd.DataFrame(np.random.randn(200, 3), columns=['a', 'b', 'c'])

#st.write((data.groupby(['label'], as_index=False).mean().groupby('label')['Latency'].mean()))
#st.write((data.groupby(['label'], as_index=False).min().groupby('label')['Latency'].min()))
#st.write((data.groupby(['label'], as_index=False).max().groupby('label')['Latency'].max()))

st.subheader('Summary Report - Response Time')
st.write(data.groupby('label')['elapsed'].describe(percentiles=[0.75,0.95,0.99]))

#st.write((data['Latency']).describe())
#mean_table = ((data.groupby(['label'], as_index=False).mean().groupby('label')['Latency'].mean()))
#st.table(mean_chart)
#data['timeStamp'] = pd.to_datetime(data['timeStamp'],unit='ms')
#st.write(pd.to_datetime(data['timeStamp'],unit='ms'))
chart_data = pd.DataFrame(data,columns=['timeStamp','Latency','label'])
#st.table(pd.DataFrame(data,columns=['label']))

#st.table(chart_data)
st.vega_lite_chart(chart_data, {
    "mark": {"type": "line", "color": "grey"},    
    "selection": {
        "grid": {
        "type": "interval", "bind": "scales"
        }
    }, 
    'encoding': {
        "tooltip": [
      {"field": "timeStamp", "type": "temporal"},
      {"field": "label", "type": "nominal"},
      {"field": "Latency", "type": "quantitative"}
    ],
    'x': {'field': 'timeStamp', 'type': 'temporal'},
    'y': {'field': 'Latency', 'type': 'quantitative'},
    },
    }) 

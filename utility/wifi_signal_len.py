import math 
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

SOM = 10

gData = {'speed':[6,9,12,18,24,36,48,54], 'sensetivity':[-87,-86,-85,-83,-80,-76,-71,-66]}
nData = {'speed':[15,30,45,60,90,120,135,150], 'sensetivity':[-96,-95,-92,-90,-86,-83,-77,-74]}
gDf = pd.DataFrame(data=gData, dtype=np.int8)
nDf = pd.DataFrame(data=nData, dtype=np.int32)

freq24Data = {'frequency':[2412,2417,2422,2427,2432,2437,2442,2447,2452,2457,2462,2467,2472,2484]}
freq5Data =  {'frequency': [5180,5200,5220,5240,5260,5280,5300,5320,5500,5560,5620,5680,5520,5580,5640,5700,5540,5600,5660,5745,5765,5785,5805]}
freq24 = pd.DataFrame(data=freq24Data, index = [1,2,3,4,5,6,7,8,9,10,11,12,13,14], dtype=np.int32)
freq5 = pd.DataFrame(data=freq5Data, index = [36,40,44,48,52,56,60,64,100,112,124,136,104,116,128,140,108,120,132,149,153,157,161], dtype=np.int32)


def getChannelFreq(*channels, dataframe):
    frequencies = [dataframe.loc[x,'frequency'] for x in channels]
    return int(np.mean(frequencies)) if len(frequencies) > 1 else frequencies[0]

def getSignalLength(Pt, Gt, Gr, Pmin, Freq):
    Y = Pt + Gt + Gr - Pmin
    FSL = Y - SOM
    D = math.pow(10,(FSL - 33)/20 - math.log10(Freq))
    return D * 1000

### Gathering Chanel's Length list
the4ChannelLen = [getSignalLength(14, 2, 1, x, getChannelFreq(4,dataframe=freq24)) for x in  np.nditer(gDf['sensetivity'].values)]

### MatPlot Graph
plt.plot(gDf['speed'].values, the4ChannelLen, label = "802.11g: 4 channel")
plt.ylabel('Length(m)')
plt.xlabel('Speed(mBit/s)')
plt.legend()
plt.show()
import matplotlib.pyplot as plt
import sys

labels = 'File', 'Folder'
sizes = [sys.argv[1], sys.argv[2]]
explode = (0, 0)

fig1, ax1 = plt.subplots()
ax1.pie(sizes, explode=explode, labels=labels, autopct='%1.1f%%',
        shadow=True, startangle=90)
ax1.axis('equal')
plt.show()

#Question 2
#Kateryna Chernega
#7246161

readFile = open('car_imperial.txt', 'r')
writeFile = open('car_metric.txt', 'w')

for segment in readFile:
    conv = 0
    segment = segment.split(",")
    litre = segment[3].strip()
    for char in litre:
         if char.isdigit() or char.isspace():
            continue
         else:
              i = litre.index(char)
              value = litre[:i]
              conv = round((100 * 3.78541) / (1.6093 * float(value)), 1)
              break
    litre = str(str(conv) + ' litre/100 km')

    meterSqr = segment[4].strip()
    for char in meterSqr:
        if char.isdigit() or char.isspace():
            continue
        else:
            i = meterSqr.index(char)
            value = meterSqr[:i]
            conv = round(float(value) * 0.02832, 3)
            break
    meterSqr = str(str(conv) + ' m^3')

    segment[3] = litre
    segment[4] = meterSqr

    segment = ','.join(segment)
    writeFile.write(segment + "\n")
writeFile.close()
readFile.close()

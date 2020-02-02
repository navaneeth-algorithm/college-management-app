
'''
-----

This Code was written to change the mysql Query 
---
'''
import re
sqlFileRead = open('CollegeManagementSql.sql')
sqlFileWrite = open('CollegeManagementSql.txt','w')
fileContents = ''
for i in sqlFileRead.readlines():
    
    foreignKey = re.findall('INT FOREIGN KEY REFERENCES',i)
    if len(foreignKey)!=0:
        listString = i.split(' ')
        #re.sub(i,'')
        listString[5] = listString[5]+",\n"
        listString[7] = listString[7]+"("+listString[4]+")"
        afterPatch = ' '.join(listString)
        
        i = afterPatch
        #temp =re.sub(i,afterPatch,i)
        #print(afterPatch)
    fileContents = fileContents+i
print(fileContents)
sqlFileWrite.write(fileContents)

sqlFileRead.close()
sqlFileWrite.close()
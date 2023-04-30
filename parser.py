import pandas as pd
path="C:\\Users\\yagiz\\Desktop\\CS406-CS531 Project\\MSR-23_HPC_Perf_Repl_Package\\MSR-23_HPC_Perf_Repl_Package\\ReplicationPackage\\Dataset\\Results\\RQ1\\RQ1.xlsx"
listt=[]
actualList=[]
ownerList=[]
ProjectList=[]
HashList=[]
df = pd.read_excel(path)
#print(df.iloc[:,17])
listt.append(df.iloc[:,17])
#print(listt[0])
for i in listt[0]:
    actualList.append(i)
actualList.pop()
for i in actualList:
    text=i[19:]
    splittedVer=text.split('/')
    ownerList.append(splittedVer[0])
    ProjectList.append(splittedVer[1])
    HashList.append(splittedVer[3])

#Read the file mbox.txt from the directory
file=open(r"C:\Users\Manjunath\Desktop\DS_Mrinal\GyanVriksh_Course\Learn_Python\Codes\mbox.txt","r")

#initialize count of from and to emails to Zero
countfrom,countto=0,0

for line in file:
    if line.startswith('From:' or 'from:' or 'FROM:'):
        countfrom+=1
    if line.startswith('To:' or 'to:' or 'TO:'):
        countto+=1

print("The total no 'from' Mails = ",countfrom)
print("The total no 'to' Mails = ",countto)


file1=open(r"C:\Users\Manjunath\Desktop\DS_Mrinal\GyanVriksh_Course\Learn_Python\Codes\mbox.txt","r")

countspam = 0.0
spamtotal = 0.0
nspam=0.0

for line in file1:

    if line.startswith("X-DSPAM-Confidence:"):
        line = line.rstrip()
        startpos = line.find(':')
        spamconf = line[startpos+1:]
        nspam = spamconf.lstrip()
        spamtotal += float(nspam)
        countspam += 1

average = spamtotal / countspam

print("Average spam confidence:",average)


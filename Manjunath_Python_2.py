#Read the file mbox.txt from the directory
file=open(r"C:\Users\Manjunath\Desktop\DS_Mrinal\GyanVriksh_Course\Learn_Python\Codes\mbox.txt","r")
file1=open(r"C:\Users\Manjunath\Desktop\DS_Mrinal\GyanVriksh_Course\Learn_Python\Codes\mbox.txt","r")

#dictionary
frommail_dict=dict()
spam_dict=dict()

#lists
frommail=[]
spam=[]

#initialize count of 'from' emails
countfrom=0

#creating of list for 'from' emails

for line in file:
    if line.startswith('From:' or 'from:' or 'FROM:'):
        countfrom+=1
        line=line.rstrip()
        split=line.split()
        frommail.append(split[1])

#creating dictionary (key,value) =(mail,count)

for mail in frommail:
    frommail_dict[mail]=frommail_dict.get(mail,0)+1

countspam = 0.0
spamtotal = 0.0
nspam=0.0

#creating of list for 'spam' confidence/probability

for line in file1:

    if line.startswith("X-DSPAM-Confidence:"):
        line = line.rstrip()
        startpos = line.find(':')
        spamconf = line[startpos+1:]
        nspam = spamconf.lstrip()
        spam.append(nspam)
        spamtotal += float(nspam)
        countspam += 1

# ----------------check point--------------------------------------------------#

if (len_frommail == len_spam):
    print("\n  # code works  \n")
else:
    print("Count of 'From' emails and SPAM 'Confidence/Probability' doesnt match")

# -----------------------------------------------------------------------------#

try:
    li=list(zip(frommail,spam))
    mail_spam_dict={}

    for k,v in li:
            #if k already exists in d, just add up the values
            if k in mail_spam_dict:
                mail_spam_dict[k] += float(v)
            #otherwise, create a (k,int(v)) pair in the dict
            else:
                mail_spam_dict[k] = float(v)

    len_frommail=len(frommail)
    len_spam=len(spam)

    if (frommail_dict.keys()==mail_spam_dict.keys()):
        ndict=dict((k, float(mail_spam_dict[k]) / frommail_dict[k]) for k in mail_spam_dict)

    print(" \n dict(k,v)=(from mail, avg spam confidence) \n ",ndict)

except:
    print("Count of 'From' emails and SPAM 'Confidence/Probability' doesnt match")
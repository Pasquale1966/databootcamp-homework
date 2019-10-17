import os
import csv


cwd = os.getcwd()
election_path=os.path.join('C:/Users/pasqu/OneDrive/Documents/UT-TOR-DATA-PT-09-2019-U-C/Unit 3 - Python/Homework/Instructions/PyBank/Resources/election_data.csv')
#budget_path=os.path.join("Resources","budget_data.csv")
print (cwd)

votes = 0

with open(election_path, 'r') as csvfile:
    csv_reader = csv.reader(csvfile, delimiter = ",")
    next (csv_reader)

    #read csv into dictionary and count votes cast
    d={}
    for row in csv_reader:
        d[row[0]]=row[2]
        votes += 1

candidate_list=list(d.values())

freq = {}
for items in candidate_list:
    if (items in freq):
        freq[items] += 1
    else:
        freq[items] = 1

print(f" Freq: {freq}")

print(f"Election Results:")
print(f"----------------------------")
print(f"Total Votes: {votes}")
print(f"----------------------------")
for key, value in freq.items():
    print("{} : {}% ({})".format(key, round(((value/votes)*100),2), value)) 
print(f"----------------------------")
#for key, value in freq.items():

print("Winner: {}".format(max(freq.items(),key= lambda x :x[1])))

   #Specify the file to write to
output_path=os.path.join('C:/Users/pasqu/OneDrive/Documents/UT-TOR-DATA-PT-09-2019-U-C/Unit 3 - Python/Homework/Instructions/PyBank/Resources/election_results.csv')
#output_path = os.path.join('Resources', 'budget_output.csv')
# Open the file using "write" mode. Specify the variable to hold the contents
with open(output_path, 'w', newline='') as outfile2:
    #Initialize csv.writer
    csvwriter = csv.writer(outfile2, delimiter=',')
    # Write the row content
    csvwriter = csv.writer(outfile2)
    # Write the row content
    csvwriter.writerow(['Election Results:'])
    csvwriter.writerow(['-----------------'])
    csvwriter.writerow(['Total Votes: {}'.format(votes)])
    csvwriter.writerow(['-----------------'])
    for key, value in freq.items():
        csvwriter.writerow(['{} : {}% ({})'.format(key, round(((value/votes)*100),2), value)]) 
    csvwriter.writerow(['-----------------'])   
    csvwriter.writerow(['Winner: {}'.format(max(freq.items(),key= lambda x :x[1]))])


   
